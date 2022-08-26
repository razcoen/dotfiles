package main

import (
	"bytes"
	"crypto/sha1"
	"errors"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"text/template"
	"time"

	"github.com/fatih/color"
	"github.com/theckman/yacspin"
	"go.uber.org/zap/zapcore"
	"go.uber.org/zap/zapio"
)

var dotfilesChecksum string
var env = `
############
# dotfiles #
############
case ":${PATH}:" in
    *:"{{.}}":*)
        ;;
    *)
      export PATH="{{.}}:$PATH"
      ;;
esac
`

func setup(ctx Context, opts SetupOptions) error {
	if !opts.JustSync {
		if err := installBinaries(ctx, opts); err != nil {
			return err
		}
	}
	return syncDotfiles(ctx, opts)
}

type SetupOptions struct {
	Yes      bool
	Scratch  bool
	JustSync bool
}

func installBinaries(ctx Context, opts SetupOptions) error {
	color.White("Install Binaries")
	////////////////////////////////////////////////////////////////
	// OhMyZsh
	////////////////////////////////////////////////////////////////
	ohmyzsh := OhMyZsh{}
	if !ohmyzsh.Installed() {
		if err := ohmyzsh.Install(ctx); err != nil {
			return err
		}
	}
	////////////////////////////////////////////////////////////////
	// Homebrew
	////////////////////////////////////////////////////////////////
	brew := Homebrew{
		Formulaes: []string{
			"go",
			"neovim",
			"fzf",
			"git",
			"gh",
			"coreutils",
			"tree",
			"watch",
			"lazygit",
			"nvm",
			"ripgrep",
			"zsh-autosuggestions",
		},
	}

	if !brew.Installed() {
		if err := brew.Install(ctx); err != nil {
			return err
		}
	} else {
		if err := brew.Update(ctx); err != nil {
			return err
		}
	}
	if err := brew.InstallOrUpgradeFormulaes(ctx); err != nil {
		return err
	}

	////////////////////////////////////////////////////////////////
	// Rust
	////////////////////////////////////////////////////////////////
	rust := Rust{}
	if err := rust.InstallOrUpdate(ctx); err != nil {
		return err
	}

	////////////////////////////////////////////////////////////////
	// Alacritty
	////////////////////////////////////////////////////////////////
	alacritty := Alacritty{}
	if err := alacritty.Setup(ctx, opts); err != nil {
		return err
	}
	return nil
}

func syncDotfiles(ctx Context, opts SetupOptions) error {
	color.White("Synchronize Dotfiles")
	dotfilesRoot := filepath.Dir(ctx.Path)
	homedir, _ := os.UserHomeDir()
	////////////////////////////////////////////////////////////////
	// sync .zshrc
	////////////////////////////////////////////////////////////////
	hasher := sha1.New()
	dotfiles, err := os.ReadFile(ctx.Path)
	if err != nil { // TODO
		return err
	}
	hasher.Write(dotfiles)
	checksum := fmt.Sprintf("%x", hasher.Sum(nil))
	if checksum != dotfilesChecksum {
		return errors.New("Please provide the path to the dotfiles script")
	}
	tpl := template.Must(template.New("env").Parse(env))
	buf := bytes.NewBuffer([]byte{})
	err = tpl.Execute(buf, dotfilesRoot)
	if err != nil {
		return err
	}
	zshrc, err := os.ReadFile(filepath.Join(dotfilesRoot, ".zshrc"))
	if err != nil {
		return err
	}
	zshrc = append(zshrc, []byte(buf.String())...)
	os.Remove(filepath.Join(homedir, ".zshrc"))
	if err := os.WriteFile(filepath.Join(homedir, ".zshrc"), zshrc, 0644); err != nil {
		return err
	}
	////////////////////////////////////////////////////////////////
	// sync .config
	////////////////////////////////////////////////////////////////
	err = Command{
		Title:  "Synchronize Neovim",
		Script: fmt.Sprintf("rsync -av --delete-before %s/.config/nvim/ %s/.config/nvim", dotfilesRoot, homedir),
	}.Execute(ctx)
	if err != nil {
		return err
	}
	err = Command{
		Title:  "Synchronize Alacritty",
		Script: fmt.Sprintf("rsync -av --delete-before %s/.config/alacritty/ %s/.config/alacritty", dotfilesRoot, homedir),
	}.Execute(ctx)
	if err != nil {
		return err
	}
	////////////////////////////////////////////////////////////////
	// sync .oh-my-zsh
	////////////////////////////////////////////////////////////////
	err = Command{
		Title:  "Synchronize OhMyZsh",
		Script: fmt.Sprintf("rsync -av --delete-before %s/.oh-my-zsh/custom %s/.oh-my-zsh/custom", dotfilesRoot, homedir),
	}.Execute(ctx)
	if err != nil {
		return err
	}

	////////////////////////////////////////////////////////////////
	// Neovim
	////////////////////////////////////////////////////////////////
	neovim := Neovim{}
	if err := neovim.InstallPlugins(ctx); err != nil {
		return err
	}
	return nil
}

type Command struct {
	Title       string
	Script      string
	Interactive bool
}

func (command Command) Execute(ctx Context) error {
	binary := strings.Split(command.Script, " ")[0]
	stdoutLoggerWriter := &zapio.Writer{
		Log:   ctx.Logger.Desugar().Named(binary),
		Level: zapcore.DebugLevel,
	}
	stderrLoggerWriter := &zapio.Writer{
		Log:   ctx.Logger.Desugar().Named(binary),
		Level: zapcore.ErrorLevel,
	}
	var stdout io.Writer = stdoutLoggerWriter
	var stderr io.Writer = stdoutLoggerWriter
	if command.Interactive {
		stdout = io.MultiWriter(stdoutLoggerWriter, os.Stdout)
		stderr = io.MultiWriter(stderrLoggerWriter, os.Stderr)
	}
	return withSpinner(func(spinner *yacspin.Spinner) error {
		if command.Interactive {
			spinner.Pause()
		}
		cmd := exec.CommandContext(ctx, "/bin/zsh", "-c", command.Script)
		message := command.Script
		spinner.Message(" " + message)
		stdout.Write([]byte(message + "\n"))
		cmd.Stdin = os.Stdin
		cmd.Stdout = stdout
		cmd.Stderr = stderr
		startTime := time.Now()
		err := cmd.Run()
		endTime := time.Now()
		// spinner.Restart()
		duration := endTime.Sub(startTime)
		duration.Abs()
		coloredMessage := color.New(color.FgHiBlack).Sprintf("%s (%.3fs)", message, duration.Seconds())
		if err == nil {
			greenCheckmark := color.New(color.FgHiGreen).Sprint("✓")
			spinner.StopMessage(fmt.Sprintf("%s %s", greenCheckmark, coloredMessage))
		} else {
			redX := color.New(color.FgHiRed).Sprint("x")
			spinner.StopMessage(fmt.Sprintf("%s %s", redX, coloredMessage))
		}
		return err
	})
}
