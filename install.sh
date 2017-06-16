#  !/usr/bin/env bash
#  -*- coding:utf-8 -*-

echo "Fucking"
sudo apt-get -y install wget  # lsb-core?
# hosts
sudo mv /etc/hosts /etc/hosts.backup0
sudo wget https://raw.githubusercontent.com/racaljk/hosts/master/hosts /etc/hosts

echo "Installing"
# emacs
sudo add-apt-repository ppa:ubuntu-elisp/ppa  -y
# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# GNOME Shell integration for Chromium browser
#sudo add-apt-repository -y ppa:ne0sight/chrome-gnome-shell
# skype (in bash only!)
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

sudo apt-get update -y
sudo apt-get --allow-unauthenticated -y install \
  mupdf goldendict tcllib golang calibre openvpn jwm rar wireshark catfish \
  jabref pep8 vym ufw hamster-indicator tmux tor synaptic zsh fish gnuplot \
  openssl openssh-client pandoc playonlinux xchm texlive-full wget gdb git \
  transmission-gtk zip pyflakes gtkorphan gtk-recordmydesktop gksu gmchess \
  gdebi auctex clamav aspell exuberant-ctags amule vim emacs-snapshot curl \
  libav-tools default-jre default-jdk kismet geany xmodmap libpam-mount sl \
  fortune-mod meld hdf5-tools libav-tools at axel gnupg octave unrar aria2 \
  gddrescue unzip skype python3-pip fcitx fcitx-config-gtk fcitx-sunpinyin \
  fcitx-googlepinyin mupdf emacs-snapshot-el google-chrome-stable homebank
  # chrome-gnome-shell gnome-tweak-tool
sudo apt-get upgrade -y

sudo pip3 install ipython
sudo pip3 install notebook
sudo pip3 install qtconsole
sudo pip3 install regex
sudo pip3 install setuptools
sudo pip3 install h5py
sudo pip3 install python-nmap
sudo pip3 install mpmath
sudo pip3 install sympy
sudo pip3 install jupyter
sudo pip3 install pillow
sudo pip3 install numpy
sudo pip3 install scipy
sudo pip3 install matplotlib
sudo pip3 install networkx
sudo pip3 install pandas
sudo pip3 install moviepy
sudo pip3 install future
sudo pip3 install statsmodels
sudo pip3 install mdp
sudo pip3 install pyneuroml
sudo pip3 install ipdb # IPython debugger
sudo pip3 install keras
sudo pip3 install flask # micro web framework
sudo pip3 install simpy
sudo pip3 install tushare # stock data
# --- install tensorflow in fish sh.
sudo pip3 install tensorflow
# if use virtualenv
#sudo pip3 install virtualenv # for tensorflow
#virtualenv  --system-site-packages  ~/tensorflow
#fish -c "~/tensorflow/bin/pip3 install --upgrade tensorflow"

sudo apt-get autoremove --purge -y

echo "Setting"
sudo ufw enable
sudo chsh -s /usr/bin/fish mw
# ---
sudo rm /var/crash/*
sudo echo "enabled=1" >> /etc/default/apport
# ---
sudo groupadd wireshark
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 4755 /usr/bin/dumpcap
sudo gpasswd -a mw wireshark
# ---
cp ~/.Xmodmap ~/.Xmodmap.backup
cp ./terminal/_Xmodmap.watery ~/.Xmodmap
echo '' >> ~/.xinitrc
echo 'xmodmap ~/.Xmodmap' >> ~/.xinitrc
# ---
sudo mkdir /mnt/tmpDisk
mount -t tmpfs -o size=1024m tmpfs /mnt/tmpDisk
sudo echo "tmpfs /mnt/tmpDisk tmpfs nodev,nosuid,noexec,nodiratime,size=1024M 0 0" >> /etc/fstab
# ---
echo -e "\n\nseting up github user!!! <<< --- Please check again!!!\n\n"
git config --global push.default simple
git config --global user.name wmji
git config --global user.email maoji.wang@cims.nyu.edu

echo "Languages"
mv ~/.config/ipython ~/.config/ipython.backup
git clone "https://github.com/ubtc/gopy" ~/.config/ipython
# ---
sh ~/.config/ipython/install_go_pkg.sh
go env

echo "Editors"
# emacs
mv ~/.emacs.d ~/.emacs.d.backup
git clone "https://github.com/ubtc/plus.git" ~/.emacs.d
emacs -nw --batch -l ~/.emacs.d/init.el -f package-refresh-contents
# vim
mv ~/.vim ~/.vim.backup
git clone 'https://github.com/ubtc/vine' ~/.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/tmp
echo -e "`emacs` and `vim` have been installed;"
echo -e "    Run `PlugInstall` to install `vim` plugins (`PlugUpdate` to update)."
echo -e "    Press `U_x` key in elpa packages list view to update emacs packages (autoinstall in the 1st run)."

echo "Shells"
mv ~/.tmux.conf ~/.tmux.conf.backup
cp ./terminal/_tmux.conf ~/.tmux.conf
# ---
mv ~/.ssh ~/.ssh.backup
mkdir -p ~/.ssh
cp ./shell/config.ssh ~/.ssh/config
# ---
cp ./shell/config.fish ~/.config/fish/
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc .zshrc.omzs
cp ./shell/_zshrc ~/.zshrc

# virtuals
wget https://download3.vmware.com/software/player/file/VMware-Player-12.5.0-4352439.x86_64.bundle
sudo sh VMware-Player-12.5.0-4352439.x86_64.bundle

echo "Done"
