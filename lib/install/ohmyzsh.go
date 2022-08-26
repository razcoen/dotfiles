package main

import (
	"os"
	"path/filepath"
)

type OhMyZsh struct{}

func (OhMyZsh) Installed() bool {
	homedir, _ := os.UserHomeDir()
	_, err := os.Stat(filepath.Join(homedir, ".oh-my-zsh"))
	return err == nil
}

func (OhMyZsh) Install(ctx Context) error {
	f, err := getInstallScript("https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh", "oh-my-zsh")
	if err != nil { // TODO
		return err
	}
	// homebrew install script requires interactive (password and enter)
	return Command{
		Title:  "Install OhMyZsh",
		Script: f.Name(),
	}.Execute(ctx)
}
