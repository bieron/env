package main
// This script wraps i3status output and inject git branch of work repo
// and current version of the cribl server running at :9000 (if any)
// To use it, go build it and ensure your ~/.i3status.conf contains this line:
//     output_format = "i3bar"
// in the 'general' section.
// Then, in your ~/.i3/config, use:
//     status_command i3status | path/to/executable

import (
  "io"
  "bufio"
  "bytes"
  "syscall"
  "strings"
  "fmt"
  "os"
  "os/exec"
  "time"
  "encoding/json"
  "github.com/go-git/go-git/v5"
)

func getGitState(repo *git.Repository) string {
  head, err := repo.Head()
  check(err)
  hash := head.Hash().String()[:8]
  if head.Name().IsBranch() {
    return fmt.Sprintf("%s (%s)", head.Name().Short(), hash)
  }
  return hash
}

func getCriblServerPid() string {
  cmd := exec.Command("lsof", "-ti", ":9000", "-sTCP:LISTEN")
  out, err := cmd.Output()
  if err != nil {
    return "";
  }
  return string(out[:len(out)-1])
}

/* builds the original cmdline using /proc data except it calls "version" instead of "server"
* works with both node cribl.bundle.js and ./cribl
*/
func getCriblVersion(pid string) string {
  if len(pid) == 0 {
    return ""
  }
  procDir := fmt.Sprintf("/proc/%s/", pid)
  // get the original CMD
  output, err := os.ReadFile(procDir + "cmdline")
  check(err)
  cmdline := string(output)
  argv := strings.Split(cmdline[:len(cmdline)-1], "\x00")
  // replace "server" with "version"
  argv[len(argv)-1] = "version"

  cmd := exec.Command(procDir + "exe", argv[1:]...)
  var dir string
  dir, err = os.Readlink(procDir + "cwd")
  check(err)
  cmd.Dir = dir
  // cmd.Stderr = os.Stderr
  out, err := cmd.Output()
  if err != nil {
    // panic(err)
    return "unknown version"
  }
  idx := bytes.Index(out, []byte(":")) + 2
  return string(out[idx:len(out)-1])
}

func getMike() string {
  cmd := exec.Command("pamixer", "--default-source", "--get-volume-human")
  out, err := cmd.Output()
  if err != nil {
    return "";
  }
  // except terminal newline
  return string(out[:len(out)-1])
}

var statusProc *os.Process
func getChildStream() io.ReadCloser {
  cmd := exec.Command("i3status")
  stdout, err := cmd.StdoutPipe()
  check(err)
  check(cmd.Start())
  statusProc = cmd.Process
  return stdout
}


func check(e error) {
  if e != nil { panic(e) }
}

const LCLICK  = 1
// const MCLICK  = 2
// const RCLICK  = 3
const USCROLL = 4
const DSCROLL = 5

func reactToClicks() {
  events := bufio.NewScanner(os.Stdin)

  for events.Scan() {
    bytes := []byte(events.Text())
    if bytes[0] == '[' { continue }
    if bytes[0] == ',' {
      bytes = bytes[1:]
    }
    var data map[string]any
    check(json.Unmarshal(bytes, &data))
    button := int(data["button"].(float64))
    if button != USCROLL && button != DSCROLL && button != LCLICK {
      continue
    }
    var cmd *exec.Cmd
    spankChild := false
    switch data["name"] {
    case "wireless":
      if button == LCLICK {
        cmd = toggleWireless()
        spankChild = true
      }
    case "mic":
      cmd = exec.Command("pamixer", "--default-source", click2VolumeAction(button))
      spankChild = true
    case "volume":
      cmd = exec.Command("pamixer", click2VolumeAction(button))
    }
    if cmd != nil {
      check(cmd.Run())
      if spankChild {
        check(statusProc.Signal(syscall.SIGUSR1))
      }
    } else {
      fmt.Fprintf(os.Stderr, "Unsupported click on region:%s, button:%d\n", data["name"], button)
    }
  }
}

func toggleWireless() *exec.Cmd {
  cmd := exec.Command("ip", "link", "show", "wlp0s20f3");
  out, err := cmd.Output()
  check(err)
  var toggle string
  if bytes.Index(out, []byte{'U','P'}) > -1 {
    toggle = "down"
  } else {
    toggle = "up"
  }
  return exec.Command("sudo", "ip", "link", "set", "wlp0s20f3", toggle)
}

func click2VolumeAction(button int) string {
  switch button {
  case USCROLL: return "-i5"
  case DSCROLL: return "-d5"
  case LCLICK: return "-t"
  }
  return ""
}


func main() {
  stdout := getChildStream()
  scanner := bufio.NewScanner(stdout)
  scanner.Scan()
  fmt.Println("{\"version\":1,\"click_events\":true}")
  // pass the second line, the start of infinite array
  scanner.Scan()
  fmt.Println(scanner.Text())

  path := "/home/jb/dev/cribl"
  repo, err := git.PlainOpen(path)
  check(err)

  path += "/.git/HEAD"
  gitState := make(map[string]string)
  gitState["full_text"] = getGitState(repo)
  lastModTime := time.Now()

  lastPid := getCriblServerPid()
  criblVersion := make(map[string]string)
  criblVersion["full_text"] = getCriblVersion(lastPid)

  go reactToClicks()

  var prefix string
  for scanner.Scan() {
    bytes := []byte(scanner.Text())
    if bytes[0] == ',' {
      bytes = bytes[1:]
      prefix = ","
    }
    var data []map[string]string
    check(json.Unmarshal(bytes, &data))

    // git branch
    var fi os.FileInfo
    fi, err = os.Stat(path)
    check(err)
    modTime := fi.ModTime()
    if modTime.After(lastModTime) {
      lastModTime = modTime
      gitState["full_text"] = getGitState(repo)
    }
    data = append([]map[string]string{gitState}, data...)
    // end git branch

    // cribl version
    criblPid := getCriblServerPid()
    // fmt.Println(criblPid, lastPid)
    if criblPid != lastPid {
      criblVersion["full_text"] = getCriblVersion(criblPid)
      lastPid = criblPid
    }
    if len(criblVersion["full_text"]) > 0 {
      // fmt.Println(criblVersion["full_text"])
      data = append([]map[string]string{criblVersion}, data...)
    }
    // end cribl version

    // get mic vol & muteness
    mike := getMike()
    if len(mike) > 0 {
      mikeData := make(map[string]string);
      mikeData["name"] = "mic"
      if mike=="muted" {
        mikeData["color"] = "#FF0000"
        mikeData["full_text"] = "♬"
      } else {
        mikeData["full_text"] = "♬ " + mike
      }
      length := len(data)
      data = append(data[:length-1], mikeData, data[length-1])
    }
    // end get mic

    bytes, err = json.Marshal(data)
    check(err)
    fmt.Print(prefix)
    fmt.Print(string(bytes))
  }
}
