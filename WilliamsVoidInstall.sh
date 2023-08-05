# This is an installation script for Void to automate this autism
echo "Williams Void Installation Script"
cd /
mkdir Documents
mkdir Programs
mkdir Scripting
mkdir Repos
mkdir Videos
mkdir Wallpapers
mkdir Images
xbps-install --sync
echo "Installing Programming and Scripting packages"
xbps-install  -y tcc mercurial curl make gdb python3 python3-pip lua geckodriver vim git nasm xxd SDL2 SDL2-devel
pip install selenium pytest
echo "Installing X packages for window managers"
xbps-install -y  base-devel libX11-devel libXft-devel libXinerama-devel freetype-devel fontconfig-devel
echo "Installing cool programs"
xbps-install -y  dwm st dmenu sent sxiv gimp firefox kdenlive i2pd neofetch mpv sc-im zathura surf macchanger zathura-pdf-mupdf xwallpaper lf ImageMagick ffmpeg
echo "Setting up Mutt + Yandex Email with offline syncing"
echo "Yandex + Mutt enter your real name: "
read RealName
echo "Yandex + Mutt enter your Yandex email: "
read Email
echo "Yandex + Mutt enter your app password: "
read Password
xbps-install -y mutt offlineimap
cd /root/
echo "
#We use VI here
set editor = "vi"
#Account Settings
set from = "$Email"
set realname = "$RealName"
set ssl_starttls = yes
set ssl_force_tls = yes
set mbox_type = Maildir
set folder = /root/Maildir
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
echo "Email system finished setting up"
offlineimap
echo "Configuring X"
cd ~
echo "exec &dwm" > .xinitrc
neofetch
echo "Williams Void Installation Script has finished, check above for errors"
sleep 5
echo "Starting!"
cd ~
startx
