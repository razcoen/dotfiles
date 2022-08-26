package main

type Alacritty struct{}

func (Alacritty) Setup(ctx Context, opts SetupOptions) error {
	err := Command{
		Title:  "Install Alacritty",
		Script: "cargo install alacritty",
	}.Execute(ctx)
	if err != nil {
		return err
	}
	if opts.Scratch {
		err := Command{
			Title:       "Allow Filesystem Permissions to Alacritty",
			Script:      "sudo codesign --force --deep --sign - /Applications/Alacritty.app",
			Interactive: true,
		}.Execute(ctx)
		return err
	}
	return nil
}
