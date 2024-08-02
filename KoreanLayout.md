# Add Korean Layout

## Add the korean locale
Edit the file `/etc/locale.gen` and uncomment `ko_KR.UTF-8 UTF-8`. After making the changes, run:
```sh
sudo locale-gen
```

## Install and configure Ibus
```sh
sudo pacman -S ibus ibus-hangul noto-fonts-cjk
```

### Configure
Open the `~/.xprofile` or the `~/.xinitrc` file and write:
```sh
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drx
```
After starting IBus, you should see its icon in your system tray. Right-click on the IBus icon, select "Preferences," and go to the "Input Method" tab. Add "Korean - Hangul" as an input method. To switch to the Korean Hangul input method, use the keyboard shortcut you defined in IBus preferences (usually Ctrl+Space by default). When you want to type in Hangul, press the shortcut to activate the Hangul input method. You should be able to type Hangul characters using your keyboard.

### Add i3 binding
If the defaults binding do not work, you can add the bindings directly in the i3 config file: 
```
bindsym $MOD+<key>              exec --no-startup-id ibus engine <layout>
```

You can find the `<layout>` by typing: 
```sh
ibus engine         # current layout
ibus list-engine    # all layouts 
```

### Troubleshouting
Do not forget to reset i3/ restart xorg. 
