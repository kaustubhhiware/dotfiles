# dotfiles
Because dotfiles were getting quite a handful to manage.

Proxy settting in `_etc_environment`

All .config files needed for UI and UX.

* Themes and all can be known from `screenshot.png`
* lock screen image - `elementary.jpg`
* xfce window icon - `ubuntu_flat.png`

 Preferably keep these files in some location like - `/usr/share/backgrounds` or `/usr/share/icons`

 Add show desktop, remove docky icon. Settings still accessible from split in window.

* Terminal theme loosely based on solarised dark -

 Foreground text - `#ACE6ED`
 Background - `#020F12`

* No reason to use anything apart from xfce desktop. Low on resources, consumes upto 700 MB RAM on start, against 1.1 GB in Unity.[Config files from ~/.config/xfce4/](xfce4/)

 Install xfce desktop -

 `sudo apt-get install xubuntu-desktop  xfce4-goodies`

 Keyboard bindings here - `xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml`. Also, bindings.txt for reference.

 Menu file for docky - `xfce4/menu.desktop`

* Docky is :heart:

* Atom - hackable code editor
 Open source FTW ! I use no other editor apart from this with the exception of nano on servers.
 I know, #vimmasterrace.

 Installation is as simple as `apm install minimap`
 OR
 [Installing packages with brute force like I do](https://discuss.atom.io/t/manually-install-package/9251/14)

 Suggested Packages -
 * [minimap](https://atom.io/packages/minimap)
 * [file-icons](https://github.com/file-icons/atom)
 * [pigments](https://atom.io/packages/pigments)

 Check the loading time with `Packages > Timecop`

* recentmost.c - Sometimes I'm just a klutz, and I forget where my file is. Thanks to this [gentleman](https://github.com/shadkam/recentmost), that is no longer a problem.[Not my code]

 Usage -
 <pre style="background: rgb(238, 238, 238); border: 1px solid rgb(204, 204, 204); padding: 5px 10px;">gcc -Wall -Wextra -o recentmost recentmost.c
find ~/ -type f|~/recentmost 1000 | grep file_you_lost</pre>
