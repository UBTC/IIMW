#  !/usr/bin/env bash
#  -*- coding:utf-8 -*-

echo "Fucking"
sudo apt-get -y install wget
# hosts
sudo mv /etc/hosts /etc/hosts.backup0
sudo wget https://raw.githubusercontent.com/racaljk/hosts/master/hosts /etc/hosts

echo "Installing"
#sudo apt-get install lsb-core -y
# emacs
sudo add-apt-repository ppa:ubuntu-elisp/ppa  -y
# neovim
# sudo add-apt-repository ppa:neovim-ppa/unstable -y
# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# skype (in bash only!)
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
# sbt (of scala)
#echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
# Julia
#sudo echo "" >> /etc/apt/sources.list
#sudo echo "# Julia" >> /etc/apt/sources.list
#sudo echo "deb http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu " $(lsb_release -cs) " main" >> /etc/apt/sources.list
#sudo echo "deb-src http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu " $(lsb_release -cs) " main" >> /etc/apt/sources.list
#sudo echo "" >> /etc/apt/sources.list
#cat /etc/apt/sources.list # vim /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get --allow-unauthenticated -y install \
  scala goldendict neovim golang calibre openvpn jwm rar wireshark catfish \
  jabref pep8 vym ufw hamster-indicator tmux tor synaptic zsh fish gnuplot \
  openssl openssh-client pandoc playonlinux xchm texlive-full wget gdb git \
  transmission-gtk zip pyflakes gtkorphan gtk-recordmydesktop gksu gmchess \
  gdebi auctex clamav aspell exuberant-ctags amule vim emacs-snapshot curl \
  libav-tools default-jre default-jdk neovim gnome-tweak-tool libpam-mount \
  fortune-mod meld hdf5-tools libav-tools at axel gnupg octave unrar aria2 \
  gddrescue unzip skype python3-pip fcitx fcitx-config-gtk fcitx-sunpinyin \
  fcitx-googlepinyin mupdf emacs-snapshot-el google-chrome-unstable homebank
# mdpress vidalia xfce4 sbt 'octave-*' evince feh pavucontrol volumeicon-alsa
# john nmap kismet hydra ophcrack hunt aircrack-ng roxterm tcllib cryptsetup
# alsamixergui xbacklight xarchiver alsa-utils gimp dmsetup xautolock julia

sudo apt-get upgrade -y

# choose a Java to work with scala
sudo update-alternatives --config java

# install the latest scala 2.11
#wget http://www.scala-lang.org/files/archive/scala-2.11.8.deb
#sudo gdebi --n  scala-2.11.8.deb

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
#sudo pip3 install neovim
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
echo "remove Lock = Caps_Lock" > ~/.Xmodmap
echo "keysym Caps_Lock = Escape" >> ~/.Xmodmap
#echo "keysym Escape = Caps_Lock" >> ~/.Xmodmap
#echo "add Lock = Caps_Lock" >> ~/.Xmodmap
# ---
sudo mkdir /mnt/tmpDisk
mount -t tmpfs -o size=1024m tmpfs /mnt/tmpDisk
sudo echo "tmpfs /mnt/tmpDisk tmpfs nodev,nosuid,noexec,nodiratime,size=1024M 0 0" >> /etc/fstab
# ---
echo -e "\n\nseting up github user!!! <<< --- Please check again!!!\n\n"
git config --global push.default simple
git config --global user.name mogeiwang
git config --global user.email mogeiwang@gmail.com

#echo "Desktop"
#mv ~/.fluxbox ~/.fluxbox.backup
#git clone "https://github.com/UBTC/bFox" ~/.fluxbox

echo "Languages"
#mv ~/scala ~/.scala.backup
#mkdir ~/scala/package -p
#git clone "https://github.com/ubtc/impala" ~/scala/import
# ---
mv ~/.config/ipython ~/.config/ipython.backup
git clone "https://github.com/ubtc/wipy" ~/.config/ipython
# ---
git clone "https://github.com/ubtc/goJulia" ~/.goJulia
sh ~/.goJulia/install_go_pkg.sh
go env
#julia ~/.goJulia/install_jl_pkg.jl
#mkdir -p ~/julia/juliaFunc
#mv ~/.juliarc.jl ~/.julia.backup.jl
#cp ~/.goJulia/_juliarc.jl ~/.juliarc.jl

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
#vim -c PlugInstall > /dev/null
# neovim
#mv ~/.config/nvim ~/.config/nvim.backup
#git clone "https://github.com/ubtc/vine" ~/.config/nvim
#curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
#mkdir -p ~/.config/nvim/backup
#mkdir -p ~/.config/nvim/tmp
##nvim --headless -c PlugInstall
echo -e "`emacs` and `vim` have been installed;"
echo -e "    Run `PlugInstall` to install `vim` plugins (`PlugUpdate` to update)."
echo -e "    Press `U_x` key in elpa packages list view to update emacs packages (autoinstall in the 1st run)."

echo "Shells"
mv ~/.tmux.conf ~/.tmux.conf.backup
cp ./term/_tmux.conf ~/.tmux.conf
# ---
#mv ~/.config/roxterm.sourceforge.net ~/.config/roxterm.sourceforge.net.backup
#cp ./term/roxterm.sourceforge.net ~/.config/roxterm.sourceforge.net
# ---
mv ~/.ssh ~/.ssh.backup
mkdir -p ~/.ssh
cp ./shell/config.ssh ~/.ssh/config
# ---
cp ./shell/config.fish ~/.config/fish/
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc .zshrc.omzs
cp ./shell/_zshrc ~/.zshrc

# Vmware
wget https://download3.vmware.com/software/player/file/VMware-Player-12.5.0-4352439.x86_64.bundle
sudo sh VMware-Player-12.5.0-4352439.x86_64.bundle

echo "Done"
