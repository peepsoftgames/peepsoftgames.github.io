#!/bin/sh 
# Based installation script for Void to automate this autism, assuming user is root.
printf "Williams Void Installation Script\n"
cd ~/
mkdir Documents
mkdir Programs
mkdir Scripting
mkdir Repos
mkdir Videos
mkdir Wallpapers
mkdir Images
xbps-install --sync
printf "Installing Programming and Scripting packages\n"
xbps-install  -y tcc mercurial curl make gdb python3 python3-pip lua geckodriver vim git nasm xxd SDL2 SDL2-devel ksh
pip install selenium pytest
printf "Installing X packages for window managers\n"
xbps-install -y  base-devel libX11-devel libXft-devel libXinerama-devel freetype-devel fontconfig-devel
printf "Installing cool programs\n"
xbps-install -y  dwm st dmenu sent sxiv gimp firefox kdenlive i2pd neofetch sc-im zathura surf macchanger zathura-pdf-mupdf xwallpaper lf ImageMagick ffmpeg doas mdp xdotool xbindkeys powertop
printf "Setting up Mutt + Yandex Email with offline syncing\n"
printf "Yandex + Mutt enter your real name: \n"
read RealName
printf "Yandex + Mutt enter your Yandex email: \n"
read Email
printf "Yandex + Mutt enter your app password: \n"
read Password
xbps-install -y mutt offlineimap
cd ~
echo "
#We use VI here
set editor = "vi"
#Account Settings
set from = "$Email"
set realname = "$RealName"
set ssl_starttls = yes
set ssl_force_tls = yes
set mbox_type = Maildir
set folder = ~/Maildir
##YANDEX IMAP
set imap_user = "$Email" #Email
set imap_pass = "$Password" #App Password
set spoolfile = +INBOX
##YANDEX SMTP
set smtp_url = "smtps://$Email@smtp.yandex.com:465/"
set smtp_pass = "$Password"
set use_from = yes
" > .muttrc
echo "
[general]
accounts = $RealName
[Account $RealName]
localrepository = YandexLocal
remoterepository = YandexRemote
[Repository YandexRemote]
type = IMAP
sslcacertfile = /etc/ssl/certs/ca-certificates.crt
remotehost = imap.yandex.com
remoteuser = $Email
remotepass = $Password
ssl = yes
[Repository YandexLocal]
type = Maildir
localfolders = Maildir
restoreattime = no
" > .offlineimaprc
printf "Email system finished setting up\n"
offlineimap
printf "Configuring X\n"
cd ~
echo "exec &dwm" > .xinitrc
printf "Autooptimization via PowerTOP\n"
powertop --calibrate
powertop --auto-tune
neofetch
printf "Helping you set up a printer\n"
xbps-install -y cups cups-pdf epson-inkjet-printer-escpr system-config-printer
ln -s /etc/sv/cups /var/service/
sv start cups
firefox http://localhost:631/
printf "Williams Void Installation Script has finished, check above for errors\n"
sleep 5
printf "Starting!\n"
startx
