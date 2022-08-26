package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"path/filepath"
)

func getInstallScript(url string, name string) (*os.File, error) {
	resp, err := http.DefaultClient.Get(url)
	if err != nil { // TODO
		return nil, err
	}
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil { // TODO
		return nil, err
	}
	tmpdir := os.TempDir()
	installScript := filepath.Join(tmpdir, fmt.Sprintf("dotfiles-%s-install-script.sh", name))
	os.Remove(installScript)
	f, err := os.Create(installScript)
	if err != nil { // TODO
		return nil, err
	}
	defer f.Close()
	err = f.Chmod(0755)
	if err != nil { // TODO
		os.Remove(installScript)
		return nil, err
	}
	_, err = f.WriteString(string(body))
	if err != nil { // TODO
		os.Remove(installScript)
		return nil, err
	}
	return f, nil
}
