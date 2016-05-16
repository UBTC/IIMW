#  !/usr/bin/env bash
#  -*- coding:utf-8 -*-

echo "Installing"
sudo apt-get install lsb-core -y

sudo add-apt-repository ppa:ubuntu-elisp/ppa  -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
sudo echo "" >> /etc/apt/sources.list
sudo echo "# Julia" >> /etc/apt/sources.list
sudo echo "deb http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu " $(lsb_release -cs) " main" >> /etc/apt/sources.list
sudo echo "deb-src http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu " $(lsb_release -cs) " main" >> /etc/apt/sources.list
sudo echo "" >> /etc/apt/sources.list
sudo echo "# neovim" >> /etc/apt/sources.list
sudo echo "deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu " $(lsb_release -cs) " main" >> /etc/apt/sources.list
sudo echo "deb-src http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu " $(lsb_release -cs) " main" >> /etc/apt/sources.list
cat /etc/apt/sources.list # vim /etc/apt/sources.list
sudo apt-get update -y

sudo apt-get --allow-unauthenticated -y install \
  xfce4 goldendict alsamixergui vym golang calibre openvpn openbox mdpress \
  wireshark catfish jabref xbacklight xarchiver alsa-utils pep8 zathura sl \
  ufw xautolock hamster-indicator tmux tor synaptic zsh julia fish gnuplot \
  openssl openssh-client pandoc playonlinux xchm texlive-full wget gdb git \
  transmission-gtk zip pyflakes gtkorphan gtk-recordmydesktop gksu gmchess \
  skype unzip libav-tools john nmap kismet hydra ophcrack hunt aircrack-ng \
  meld rar unrar aria2 axel octave vidalia dmsetup cryptsetup libpam-mount \
  gdebi auctex clamav aspell exuberant-ctags amule vim emacs-snapshot curl \
  neovim evince pavucontrol google-chrome hdf5-tools feh python3-pip gnupg \
  emacs-snapshot-el gimp volumeicon-alsa
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
sudo pip3 install neovim
sudo pip3 install pillow
sudo pip3 install numpy
sudo pip3 install scipy
sudo pip3 install matplotlib
sudo pip3 install networkx
sudo pip3 install pandas
sudo pip3 install future
sudo pip3 install statsmodels

sudo apt-get autoremove --purge -y

echo "Setting"
sudo ufw enable
sudo chsh -s /usr/bin/fish mw
sudo groupadd wireshark
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 4755 /usr/bin/dumpcap
sudo gpasswd -a mw wireshark
# ---
sudo mkdir /mnt/tmpDisk
mount -t tmpfs -o size=1024m tmpfs /mnt/tmpDisk
sudo echo "tmpfs /mnt/tmpDisk tmpfs nodev,nosuid,noexec,nodiratime,size=1024M 0 0" >> /etc/fstab
# ---
echo -e "\n\nseting up github user!!! <<< --- Please check again!!!\n\n"
git config --global push.default simple
git config --global user.name mogeiwang
git config --global user.email mogeiwang@gmail.com

echo "Languages"
mv ~/.config/ipython ~/.config/ipython.backup
git clone "https://github.com/ubtc/wipy" ~/.config/ipython
# ---
git clone "https://github.com/ubtc/goJulia" ~/.goJulia
sh ~/.goJulia/install_go_pkg.sh
go env
julia ~/.goJulia/install_jl_pkg.jl
mkdir -p ~/julia/juliaFunc
mv ~/.juliarc.jl ~/.julia.backup.jl
cp ~/.goJulia/_juliarc.jl ~/.juliarc.jl

echo "Desktop"
mv ~/.config/openbox ~/.config/openbox.backup
git clone "https://github.com/UBTC/boxer" ~/.config/openbox

echo "Editors"
mv ~/.emacs.d ~/.emacs.d.backup
git clone "https://github.com/ubtc/PULSE.git" ~/.emacs.d
emacs -nw --batch -l ~/.emacs.d/init.el -f package-refresh-contents
# ---
mv ~/.config/nvim ~/.config/nvim.backup
git clone "https://github.com/ubtc/vine" ~/.config/nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mkdir -p ~/.config/nvim/backup
mkdir -p ~/.config/nvim/tmp
# nvim --headless -c PlugInstall
echo -e "Run `PlugInstall` in neovim to use plugins;\n\n vim has been installed, but has not been set up."

echo "Shells"
mv ~/.tmux.conf ~/.tmux.conf.backup
cp ./term/_tmux.conf ~/.tmux.conf
# ---
mv ~/.ssh ~/.ssh.backup
mkdir -p ~/.ssh
cp ./shell/config.ssh ~/.ssh/config
# ---
cp ./shell/config.fish ~/.config/fish/
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc .zshrc.omzs
cp ./shell/_zshrc ~/.zshrc

echo "Done"
