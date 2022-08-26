package main

import (
	"os/exec"
	"strings"
)

type Homebrew struct {
	Formulaes []string
}

func (h Homebrew) InstallOrUpgradeFormulaes(ctx Context) error {
	err := Command{
		Title:  "Install Homebrew Formulaes",
		Script: "brew install -q " + strings.Join(h.Formulaes, " "),
	}.Execute(ctx)
	if err != nil { // TODO
		return err
	}
	err = Command{
		Title:  "Update Homebrew Formulaes",
		Script: "brew upgrade -q " + strings.Join(h.Formulaes, " "),
	}.Execute(ctx)
	return err
}

func (h Homebrew) Update(ctx Context) error {
	return Command{
		Title:  "Update Homebrew",
		Script: "brew update",
	}.Execute(ctx)
}

func (Homebrew) Installed() bool {
	_, err := exec.LookPath("brew")
	return err == nil
}

func (h Homebrew) Install(ctx Context) error {
	f, err := getInstallScript("https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh", "homebrew")
	if err != nil { // TODO
		return err
	}
	// homebrew install script requires interactive (password and enter)
	return Command{
		Title:       "Install Homebrew",
		Script:      f.Name(),
		Interactive: true,
	}.Execute(ctx)
}
