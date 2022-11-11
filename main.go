package main

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"

	"go.uber.org/zap"
)

func main() {
	logger := NewLogger()
	i := Installer{
		Logger:    logger,
		OS:        "darwin",
		SourceDir: os.Getenv("SOURCE_DIR"),
		Links: []string{
			".zshrc",
			".config/alacritty",
			".config/kitty",
			".oh-my-zsh/custom",
		},
	}
	if err := i.Validate(); err != nil {
		logger.Error(err)
		os.Exit(1)
	}
	if err := i.Link(); err != nil {
		logger.Error(err)
		os.Exit(1)
	}
}

type Installer struct {
	Logger    *zap.SugaredLogger
	OS        string
	Links     []string
	SourceDir string
}

func (i Installer) Validate() error {
	runtimeOS := runtime.GOOS
	i.Logger.With("os", runtimeOS).Infof("Detected OS")
	if runtimeOS != i.OS {
		return fmt.Errorf("Expected to run on '%s' but running on: '%s'", i.OS, runtimeOS)
	}
	if _, err := os.Stat(i.SourceDir); err != nil {
		return fmt.Errorf("Missing variable SourceDir, use SOURCE_DIR environment")
	}
	i.Logger.With("source", i.SourceDir).Infof("Validated source")
	return nil
}

func (i Installer) Link() error {
	homedir, err := os.UserHomeDir()
	if err != nil {
		return err
	}
	for _, link := range i.Links {
		target := filepath.Join(homedir, link)
		i.Logger.With("link", target).Debugf("Removing link")
		if err := os.Remove(target); err != nil {
      i.Logger.Debug(err)
		}
		source := filepath.Join(i.SourceDir, link)
		i.Logger.With("source", source, "target", target).Infof("Creating symlink")
		if err := os.Symlink(source, target); err != nil {
			return err
		}
	}
	return nil
}

func NewLogger() *zap.SugaredLogger {
	logger, err := zap.NewDevelopment()
	if err != nil {
		panic(err)
	}
	return logger.Sugar()
}
