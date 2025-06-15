sudo apt install -y xserver-xorg-core \
xserver-xorg-video-nvidia \
x11-xserver-utils \
x11-xkb-utils \
x11-utils \
thunar \
xfce4-panel \
xfce4-session \
xfce4-settings \
xfce4-terminal \
xfconf \
xfdesktop4 \
xfwm4 \
network-manager-openvpn \
network-manager-gnome \
network-manager-openvpn-gnome \
xinit \
mousepad \
bleachbit \
timeshift \
chromium \
xrdp \
linux-headers-$(uname -r)
sudo systemctl set-default multi-user.target
