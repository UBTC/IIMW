#  !/usr/bin/env bash
#  -*- coding:utf-8 -*-

echo "installing"
nano /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get upgrade -y
# PPA may be required by neovim and plank:
sudo apt-get install neovim firefox ipython obconf goldendict alsamixergui \
  ufw suckless-tools xautolock hamster-indicator emacs24 fish tor synaptic \
  wireshark catfish jabref xbacklight fcitx xarchiver alsa-utils evince sl \
  openssl openssh-client pandoc playonlinux xchm texlive-full wget gdb git \
  transmission-gtk zip pyflakes gtkorphan python-chaco gtk-recordmydesktop \
  skype unzip libav-tools john nmap kismet hydra ophcrack hunt aircrack-ng \
  meld rar unrar aria2 axel octave vidalia dmsetup cryptsetup libpam-mount \
  plank gdebi auctex xfce4 clamav aspell exuberant-ctags python-setuptools \
  gksu python-sklearn python-matplotlib python-sympy python-pandas openbox \
  vym golang python-scipy python-scientific python-pygraphviz pep8 calibre \
  amule gimp gmchess python-simpy gnupg gnuplot openvpn python-statsmodels
sudo apt-get autoremove --purge -y
sudo pip install neovim

echo "setting up"
sudo ufw enable
sudo chsh -s /usr/bin/fish
sudo groupadd wireshark
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 4755 /usr/bin/dumpcap
sudo gpasswd -a mw wireshark
# ---
sudo mkdir /mnt/tmpDisk
mount -t tmpfs -o size=1024m tmpfs /mnt/tmpDisk
sudo echo "tmpfs /mnt/tmpDisk tmpfs nodev,nosuid,noexec,nodiratime,size=1024M 0 0" >> /etc/fstab
# ---
mv ~/.ssh ~/.ssh.backup
mkdir -p ~/.ssh
cp ./shell/config.ssh ~/.ssh/config

echo "configuring"
mv ~/.config/openbox ~/.config/openbox.backup
git clone 'https://github.com/mogeiwang/boxer' ~/.config/openbox
# ---
mv ~/.config/ipython ~/.config/ipython.backup
git clone 'https://github.com/mogeiwang/wipy' ~/.config/ipython
# ---
mv ~/.config/fish ~/.config/fish.backup
git clone 'https://github.com/mogeiwang/goFish' ~/.config/fish
# ---
sh ~/.config/fish/instpkg.sh

echo "editors"
mv ~/.emacs.d ~/.emacs.d.backup
git clone 'https://github.com/mogeiwang/vim-plus-emacs.git' ~/.emacs.d
emacs -nw --batch -l ~/.emacs.d/init.el -f package-refresh-contents
# ---
mv ~/.config/nvim ~/.config/nvim.backup
git clone 'https://github.com/mogeiwang/vine' ~/.config/nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.config/nvim/backup
mkdir -p ~/.config/nvim/tmp
nvim --headless -c PlugInstall

echo "done"
