# Archcraft
<p align="center">
    <img src="images/logo_archcraft.gif" width="200">
</p>
<p align="center"><b>Yet another minimal linux distribution, based on <a href="https://archlinux.org">Arch Linux</a>.</b></p>
<p align="center">
    <a target="_blank" href="https://archcraft.io"><img src="https://img.shields.io/badge/os-archcraft-88BC98"/></a>
    <a target="_blank" href="https://github.com/archcraft-os"><img src="https://img.shields.io/badge/github-black"/></a>
</p>

## Installation
Simply download the iso file from [archcraft's website](https://archcraft.io/download.html).

To use i3, just run `sudo pacman -Syyu archcraft-i3wm` and reboot.

## After the installation
### Xorg natural scrolling   
> Checkout [Xorg's documentation](https://wiki.archlinux.org/title/Xorg).

Create the config file:
```sh
# /etc/X11/xorg.conf.d/30-touchpad.conf

Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "true"
    MatchDriver "libinput"
    Option "NaturalScrolling" "true"
EndSection
```

### Ssh files
```shell
chmod 600 * 
chmod 644 *.pub
```

### Right keyboard layout with Rofi  
> Checkout [Xprofile's documentation](https://wiki.archlinux.org/title/Xprofile).

Create `.xprofile` in the home directory, it will be sourced at every session start. 
```sh
# ~/.xprofile

setxkbmap fr
```

### Mount disk 
> Checkout how to [mount a filesystem manually](https://wiki.archlinux.org/title/File_systems#Mount_a_file_system).

First check the disk's information:
```sh
$ lsblk -f 

NAME        FSTYPE FSVER LABEL    UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
├─sda1      ntfs         DATA     DC28D18828D161D6                        423G    46% /mnt
└─sda2      ext4   1.0            13d3aa9b-a42c-4f35-b31c-a442311d19be
nvme0n1
├─nvme0n1p1 vfat   FAT32 SYSTEM   EAEC-175B                             134,1M    48% /boot/efi
├─nvme0n1p2
├─nvme0n1p3 ntfs         OS       DC5EEDD75EEDAB0A
├─nvme0n1p4 ext4   1.0            8026e89f-c41d-42fd-870d-7885014690fa  101,5G     8% /
└─nvme0n1p5 ntfs         RECOVERY 06985657985644F9
```
The disk has the UUID DC28D18828D161D6 and the type ntfs.

Then modify the fstab file by adding the information and by providing a mounting point (usually /mnt):
```sh
# /etc/fstab

UUID=<the uuid of your disk>  <mounting point> <type> user,exec,auto,nofail 0 0 
```
It may break git, to fix that run `git config --global --add safe.directory '*'`.

> You can also add symlink elsewhere with `ln -s /mnt ~/Documents`.

Better config: [fstab](https://wiki.archlinux.org/title/fstab)
```sh
UUID=E252-F54E                              /mnt        /exfat      nofail,x-systemd.device-timeout=10,gid=users,fmask=113,dmask=002    0   2
```

Permissions: `mount -o gid=users,fmask=113,dmask=002 /dev/sda2 /mnt`

### Better Ranger 
> Checkout [ranger's documentation](https://wiki.archlinux.org/title/ranger).

- Go to last dir on exit:
```sh
# ~/.zshrc

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
```

- Show hidden files:
```sh
# ~/.config/ranger/rc.conf

set show_hidden true
```

- Make sure vim is the default editor:
```sh
# ~/.zshrc

export VISUAL=vim
export EDITOR="$VISUAL"
```

### Better Git
- Initial configuration:
```shell
git config --global init.defaultBranch main
git config --global user.email "sckathach@hackademint.org" 
git config --global user.name "Sckathach"
```


- Vim by default:
```sh
# ~/.zshrc

export GIT_EDITOR=vim
```

- The famous 'Git log a dog'
```sh
#~/.zshrc

alias gl='git log --all --decorate --oneline --graph'
```

### Hide password entirely when loggin in 
Edit `/usr/share/sddm/themes/archcraft/theme.conf` and set `ForceHideCompletePassword` to `"true"`.

### Rofi not launched when <win> is pressed 
Edit the `.config/i3/config.d/02_keybindings.conf`, add a new keybinding for Rofi and delete the `$ALT+F1` binding. 
