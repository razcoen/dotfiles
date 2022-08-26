package main

import (
	"bytes"
	"os"
	"path/filepath"
	"time"

	"github.com/fatih/color"
	"github.com/lukesampson/figlet/figletlib"
	"github.com/theckman/yacspin"
	"go.uber.org/zap"
)

var fonts map[figletStyle]*figletlib.Font

type figletStyle = string

const (
	figletStyleRoman   figletStyle = "roman"
	figletStyleSmall   figletStyle = "small"
	figletStyleBasic   figletStyle = "basic"
	figletStyleGeorgia figletStyle = "Georgia11"
)

var logger *zap.SugaredLogger
var logpath string

func setupFiglet() {
	styles := []figletStyle{
		figletStyleRoman,
		figletStyleSmall,
		figletStyleBasic,
		figletStyleGeorgia,
	}
	fonts = make(map[string]*figletlib.Font, len(styles))
	fontsPath := filepath.Join(filepath.Dir(filepath.Dir(os.Args[0])), "fonts", "figlet")
	for _, style := range styles {
		font, err := figletlib.GetFontByName(fontsPath, style)
		if err != nil { // TODO
			panic(err)
		}
		fonts[style] = font
	}
}

func setupLogger() *zap.SugaredLogger {
	tmpdir := os.TempDir()
	logpath = filepath.Join(tmpdir, "dotfiles.log")
	os.Remove(logpath)
	_, err := os.Create(logpath)
	if err != nil { // TODO
		panic(err)
	}
	cfg := zap.NewDevelopmentConfig()
	cfg.OutputPaths = []string{logpath}
	basicLogger, err := cfg.Build()
	if err != nil { // TODO
		panic(err)
	}
	logger = basicLogger.Sugar()
	return logger
}

func printLogpath() {
	color.HiBlack("Checkout the installation log for more info %s", logpath)
}

func printFiglet(message string, style figletStyle, color *color.Color) {
	font := fonts[style]
	buf := bytes.NewBuffer([]byte{})
	figletlib.FPrintMsg(buf, message, font, 300, font.Settings(), "left")
	color.Printf(string(buf.Bytes()))
}

func withSpinner(do func(*yacspin.Spinner) error) error {
	cfg := yacspin.Config{
		Frequency:       100 * time.Millisecond,
		CharSet:         yacspin.CharSets[9],
		SuffixAutoColon: true,
	}

	spinner, err := yacspin.New(cfg)

	spinner.Start()
	err = do(spinner)
	spinner.Stop()
	return err
}
