package main

type Neovim struct {
}

func (n Neovim) InstallPlugins(ctx Context) error {
	return Command{
		Title:  "Installing Neovim Plugins",
		Script: "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'",
	}.Execute(ctx)
}
