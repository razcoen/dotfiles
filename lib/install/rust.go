package main

type Rust struct{}

func (Rust) InstallOrUpdate(ctx Context) error {
	f, err := getInstallScript("https://sh.rustup.rs", "rust")
	if err != nil {
		return err
	}
	return Command{
		Title:  "Install Rust",
		Script: f.Name() + " -y",
	}.Execute(ctx)
}
