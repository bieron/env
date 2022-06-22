package main
// This script wraps i3status output and inject git branch of work repo
// and current version of the cribl server running at :9000 (if any)
// To use it, go build it and ensure your ~/.i3status.conf contains this line:
//     output_format = "i3bar"
// in the 'general' section.
// Then, in your ~/.i3/config, use:
//     status_command i3status | path/to/executable

import (
    "bufio"
    "bytes"
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
    if err != nil {
        panic(err)
    }
    hash := head.Hash().String()[:8]
    if head.Name().IsBranch() {
        return fmt.Sprintf("%s (%s)", head.Name().Short(), hash)
    }
    return hash
}

func getCriblServerPid() string {
    cmd := exec.Command("lsof", "-ti", ":9000")
    out, err := cmd.Output()
    if err != nil {
        return "";
        panic(err)
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
    if err != nil {
        panic(err)
    }
    cmdline := string(output)
    argv := strings.Split(cmdline[:len(cmdline)-1], "\x00")
    // replace "server" with "version"
    argv[len(argv)-1] = "version"

    cmd := exec.Command(procDir + "exe", argv[1:]...)
    var dir string
    dir, err = os.Readlink(procDir + "cwd")
    if err != nil {
        panic(err)
    }
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

func main() {
    scanner := bufio.NewScanner(os.Stdin)
    scanner.Scan()
    fmt.Println("{\"version\":1,\"click_events\":true}")
    // pass the second line, the start of infinite array
    scanner.Scan()
    fmt.Println(scanner.Text())

    path := "/home/jb/dev/cribl"
    repo, err := git.PlainOpen(path)
    if err != nil {
        panic(err)
    }

    path += "/.git/HEAD"
    gitState := make(map[string]string)
    gitState["full_text"] = getGitState(repo)
    lastModTime := time.Now()

    lastPid := getCriblServerPid()
    criblVersion := make(map[string]string)
    criblVersion["full_text"] = getCriblVersion(lastPid)

    var prefix string
    for scanner.Scan() {
        bytes := []byte(scanner.Text())
        if bytes[0] == ',' {
            bytes = bytes[1:]
            prefix = ","
        }
        var data []map[string]string
        err = json.Unmarshal(bytes, &data)
        if err != nil {
            panic(err)
        }

        // git branch
        var fi os.FileInfo
        fi, err = os.Stat(path)
        if err != nil {
            panic(err)
        }
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

        bytes, err = json.Marshal(data)
        if err != nil {
            panic(err)
        }

        fmt.Println(prefix + string(bytes))
    }
}
