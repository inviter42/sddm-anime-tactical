Anime Tactical is based on SDDM Sugar Candy, created from scratch by Marian Arlt. In making of this theme the original code base has been refactored, all of the components moved to the modern Qt6 and configuration options has been reduced to the most necessary.

<br/><br/>
### Installation  

**From within KDE Plasma**  

If you are on [KDE Plasma](https://www.kde.org/plasma-desktop)—by default [Manjaro](https://manjaro.org/), [OpenSuse](https://www.opensuse.org/), [Neon](https://neon.kde.org/), [Kubuntu](https://kubuntu.org/), [KaOS](https://kaosx.us/) or [Chakra](https://www.chakralinux.org/) for example—you are lucky and can simply go to your system settings and under "Startup and Shutdown" followed by "Login Screen (SDDM)" click "Get New Theme". From there search for "Anime Tactical" and install.

If for some reason you cannot find the category named "Login Screen (SDDM)" in your system settings then you are missing the module `sddm-kcm`. Install this little helper with your package manager first. You will be grateful you did.

**From other desktop environments**  

Download the tar archive from the files tab of this web page and extract the contents to the theme directory of SDDM *(change the path for the downloaded file if necessary)*:

<pre>$ sudo tar -xzvf ~/anime-tactical.tar.gz -C /usr/share/sddm/themes</pre>  

This will extract all the files to a folder called "anime-tactical" inside of the themes directory of SDDM.

After that you will have to point SDDM to the new theme by editing its config file, preferrably at `/etc/sddm.conf` *(create if necessary)*. You can take the default config file of SDDM as a reference which might be found at: `/usr/lib/sddm/sddm.conf.d/sddm.conf`.  

In the `[Theme]` section simply add the themes name to this line: `Current=anime-tactical`. If you don't care for SDDM options and you had to create the file from blank just add these two lines and save it. Also see the [Arch wiki on SDDM](https://wiki.archlinux.org/index.php/SDDM).  

**Dependencies**

[SDDM  >= 0.21](https://github.com/sddm/sddm) & [Qt6 >= 6.10](https://doc.qt.io/qt-6/)  
including: [`Qt Quick Controls 2`](https://doc.qt.io/qt-6/qtquickcontrols-index.html), [`Qt Graphical Effects`](https://doc.qt.io/qt-6/qtgraphicaleffects5-index.html), [`Qt SVG`](https://doc.qt.io/qt-6/qtsvg-index.html), [`Qt Quick Layouts`](https://doc.qt.io/qt-6/qtquicklayouts-index.html) each `>= 6.0`—*see below for distro specific package names*  

*Make sure these are installed with their required version or higher! SDDM might need an enabled system service/daemon to work. This is often done automatically during installation.*  

**Debian based** distros using the **APT** package manager:  
*(Ubuntu/Kubuntu/Kali/Neon/antiX etc.)*  
<pre>sudo apt install --no-install-recommends sddm qt6-base qt6-declarative qml‑module‑qtgraphicaleffects libqt6svg6</pre>  

**Arch based** distros using the **pacman** package manger:  
*(Obarun/Artix/Manjaro/KaOS/Chakra etc.)*  
<pre>sudo pacman -S --needed sddm qt6-base qt6-declarative qt6-svg qt5-graphicaleffects</pre>  

**openSUSE** using the **zypper** package manager:  
<pre>sudo zypper install sddm qt6-base qt6-declarative libQt6Svg6 libqt5-qtgraphicaleffects</pre>  

**Red Hat** based distros using the **dnf** package manager:  
*(Fedora/Mageia/RHEL/CentOS)*  
<pre>sudo dnf install sddm qt6-base qt6-qtdeclarative qt6-qtsvg qt5‑qtgraphicaleffects</pre>  

<br/><br/>
### Configuration

All of the customization options are available in the `theme.conf` file. All of the options have comments next to them, explaining what they do.

**Pro tip**: It's super annoying to log out and back in every time you want to see a change made to the `theme.conf` file. To preview your changes from withing your running desktop environment session simply issue:  
<pre>sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/anime-tactical</pre>

Note the `-qt6` at the end of the greeter - the theme will work only with this specific version!

And as if that wouldn't still be enough you can **translate every single button and label** because SDDM still [needs your help](https://github.com/sddm/sddm/wiki/Localization) to make localization as complete as possible!  

<br/><br/>
### Legal Notice

This file is part of SDDM Anime Tactical.
A theme for the Simple Display Desktop Manager.

Copyright (C) 2018–2020 Marian Arlt
Copyright (C) 2025 Ivan Alantiev

SDDM Anime Tactical is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or any later version.

You are required to preserve this and any additional legal notices, either
contained in this file or in other files that you received along with
SDDM Anime Tactical that refer to the author(s) in accordance with
sections §4, §5 and specifically §7b of the GNU General Public License.

SDDM Anime Tactical is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with SDDM Anime Tactical. If not, see <https://www.gnu.org/licenses/>

<br/><br/>
### Extra credits

Despite all of the UI changes and improvements this theme brings with it, a lot of heavy lifting has been done by Marian Arlt. If you like the theme, consider donating to her [PayPayl](https://www.paypal.me/marianarlt) account.
