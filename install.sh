#  !/usr/bin/env bash
#  -*- coding:utf-8 -*-

echo "installing"
sudo apt-get install lsb-core vim
sudo echo '' >> /etc/apt/sources.list
sudo echo '# Julia' >> /etc/apt/sources.list
sudo echo 'deb http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu ' $(lsb_release -cs) ' main' >> /etc/apt/sources.list
sudo echo 'deb-src http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu ' $(lsb_release -cs) ' main' >> /etc/apt/sources.list
sudo echo '' >> /etc/apt/sources.list
sudo echo '# neovim' >> /etc/apt/sources.list
sudo echo 'deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu ' $(lsb_release -cs) ' main' >> /etc/apt/sources.list
sudo echo 'deb-src http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu ' $(lsb_release -cs) ' main' >> /etc/apt/sources.list
cat /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install firefox ipython goldendict alsamixergui python-igraph \
  wireshark catfish jabref xbacklight xarchiver alsa-utils python-networkx \
  ufw suckless-tools xautolock hamster-indicator emacs24 tmux tor synaptic \
  openssl openssh-client pandoc playonlinux xchm texlive-full wget gdb git \
  transmission-gtk zip pyflakes gtkorphan python-chaco gtk-recordmydesktop \
  skype unzip libav-tools john nmap kismet hydra ophcrack hunt aircrack-ng \
  meld rar unrar aria2 axel octave vidalia dmsetup cryptsetup libpam-mount \
  docky gdebi auctex xfce4 clamav aspell exuberant-ctags python-setuptools \
  gksu python-sklearn python-matplotlib python-sympy python-pandas dolphin \
  vym golang python-scipy python-scientific python-pygraphviz pep8 calibre \
  amule gimp gmchess python-simpy gnupg gnuplot openvpn python-statsmodels \
  python-yaml python-scitools python-regex evince mdpress okular neovim sl \
  zsh roxterm stterm kde-window-manager julia hdf5-tools curl
echo
echo "Installing all packages recommended by  python-scitools  may be a good idea!"
sudo apt-get autoremove --purge -y
sudo pip install jupyter
sudo pip install neovim
sudo pip install pillow

echo "setting up"
sudo ufw enable
sudo chsh -s /usr/bin/zsh
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
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc .zshrc.omzs
cp ./shell/_zshrc ~/.zshrc
# ---
echo "seting up github user!!! <<< --- Please check again!!!"
git config --global push.default simple
git config --global user.name mogei
git config --global user.email mogeiwang@gmail.com

echo "Languages"
mv ~/.config/ipython ~/.config/ipython.backup
git clone 'https://github.com/ubtc/wipy' ~/.config/ipython
# ---
git clone 'https://github.com/ubtc/goJulia' ~/.goJulia
sh ~/.goJulia/fish/install_go_pkg.sh
go env
julia ~/.goJulia/install_jl_pkg.jl
mkdir -p ~/julia/juliaFunc
mv ~/.juliarc.jl ~/.julia.backup.jl
cp ~/.goJulia/_juliarc.jl ~/.juliarc.jl
# ---
mv ~/.tmux.conf ~/.tmux.conf.backup
cp ./term/_tmux.conf ~/.tmux.conf

echo "windows"
mv ~/.kde/share/config/kwinrc ~/.kde/share/config/kwinrc.backup
cp ./kwinrc ~/.kde/share/config/kwinrc
cp ./_keylaunchrc ~/.keylaunchrc
sudo cp ./IIMW.desktop /usr/share/xsessions/
sudo cp ./startIIMW /usr/bin/

echo "editors"
mv ~/.emacs.d ~/.emacs.d.backup
git clone 'https://github.com/ubtc/vpemacs.git' ~/.emacs.d
emacs -nw --batch -l ~/.emacs.d/init.el -f package-refresh-contents
# ---
mv ~/.config/nvim ~/.config/nvim.backup
git clone 'https://github.com/ubtc/vine' ~/.config/nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.config/nvim/backup
mkdir -p ~/.config/nvim/tmp
nvim --headless -c PlugInstall

echo "done"
