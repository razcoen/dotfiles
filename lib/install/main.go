package main

import (
	"context"

	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"go.uber.org/zap"
)

var dotfilesPath string

type Context struct {
	context.Context
	Path   string
	Logger *zap.SugaredLogger
}

func NewContext(cmd *cobra.Command) Context {
	path, err := cmd.Flags().GetString("path")
	if err != nil { // TODO
		panic(err)
	}
	return Context{
		Context: context.Background(),
		Path:    path,
		Logger:  setupLogger(),
	}
}

func patchHelpCommand(cmd *cobra.Command) {
	originalHelpFunc := cmd.HelpFunc()
	cmd.SetHelpFunc(func(c *cobra.Command, s []string) {
		printFiglet("dotfiles", figletStyleGeorgia, color.New(color.FgHiYellow))
		originalHelpFunc(c, s)
	})
}

var rootCommand = &cobra.Command{
	Use:     "dotfiles", // TODO
	Version: version,    // TODO
	Run: func(cmd *cobra.Command, args []string) {
		setupLogger()
		defer teardown()
		dotfilesPath, _ = cmd.Flags().GetString("path")
		opts := SetupOptions{}
		opts.Yes, _ = cmd.Flags().GetBool("yes")
		opts.Scratch, _ = cmd.Flags().GetBool("scratch")
		opts.JustSync, _ = cmd.Flags().GetBool("just-sync")
		ctx := NewContext(cmd)
		if err := setup(ctx, opts); err != nil {
			panic(err)
		}
	},
}

func main() {
	setupFiglet()
	rootCommand.PersistentFlags().String("path", "p", "dotfiles project path (used to configure $PATH)")
	rootCommand.PersistentFlags().MarkHidden("path")
	rootCommand.Flags().BoolP("yes", "y", false, "Use to install/update everything")
	rootCommand.Flags().BoolP("scratch", "S", false, "Use to install and run commands required for scratch environment")
	rootCommand.Flags().Bool("just-sync", false, "Use to skip installing binaries, will only synchronize dotfiles")
	patchHelpCommand(rootCommand)
	rootCommand.Execute()
}

func teardown() {
	printLogpath()
}
