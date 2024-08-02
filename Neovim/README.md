# Neovim

## Install NVChad
First uninstall previous configuration: 
```shell
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

Copy the config files into the `.config` folder: 
```shell
cp -r nvim ~/.config/
```

## After installation
Make sure to install all the dependencies:
```vim
:MasonInstallAll
```

Needed manual configuration for Python:
```vim
:TSInstall python
```

## Troubleshouting
Idk, but it is needed to manually add the `nvchad` folder to the share files: 
```shell
cp -r nvchad ~/.local/share/nvim/
```
