package main
// This script wraps i3status output and inject git branch
// To use it, go build it and ensure your ~/.i3status.conf contains this line:
//     output_format = "i3bar"
// in the 'general' section.
// Then, in your ~/.i3/config, use:
//     status_command i3status | path/to/executable

import (
    "bufio"
    "fmt"
    "os"
    "time"
    "encoding/json"
    "gopkg.in/src-d/go-git.v4"
)

func getGitState(repo *git.Repository) string {
    head, err := repo.Head()
    if err != nil {
        panic(err)
    }
    if head.Name().IsBranch() {
        return head.Name().Short()
    }
    return head.Hash().String()[:8]
}

func main() {
    scanner := bufio.NewScanner(os.Stdin)
    // scanner.Scan()
    // bytes := []byte(scanner.Text())
    // text := scanner.Text()[:-1]
    // fmt.Println(text)
    scanner.Scan()
    fmt.Println("{\"version\":1,\"click_events\":true}")

    // for i:=0; i<2; i++ {
        // pass the first line which contains version header
        // pass the second line, the start of infinite array
        scanner.Scan()
        fmt.Println(scanner.Text())
    // }

    path := "/home/jb/dev/cribl"
    repo, err := git.PlainOpen(path)
    if err != nil {
        panic(err)
    }

    path += "/.git/HEAD"
    gitState := make(map[string]string)
    gitState["full_text"] = getGitState(repo)
    lastTime := time.Now()

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

        var fi os.FileInfo
        fi, err = os.Stat(path)
        if err != nil {
            panic(err)
        }
        modTime := fi.ModTime()
        if modTime.After(lastTime) {
            lastTime = modTime
            gitState["full_text"] = getGitState(repo)
        }
        data = append([]map[string]string{gitState}, data...)

        bytes, err = json.Marshal(data)
        if err != nil {
            panic(err)
        }

        fmt.Println(prefix + string(bytes))
    }
}
