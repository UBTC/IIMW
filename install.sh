#  !/usr/bin/env bash
#  -*- coding:utf-8 -*-

echo "Installing"
sudo apt-get install lsb-core vim -y
sudo add-apt-repository ppa:ubuntu-elisp/ppa  -y
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
sudo apt-get upgrade -y

sudo apt-get install firefox goldendict alsamixergui vym golang sl calibre \
  wireshark catfish jabref xbacklight xarchiver alsa-utils pep8 evince zsh \
  ufw suckless-tools xautolock hamster-indicator tmux tor synaptic roxterm \
  openssl openssh-client pandoc playonlinux xchm texlive-full wget gdb git \
  transmission-gtk zip pyflakes gtkorphan gtk-recordmydesktop gksu dolphin \
  skype unzip libav-tools john nmap kismet hydra ophcrack hunt aircrack-ng \
  meld rar unrar aria2 axel octave vidalia dmsetup cryptsetup libpam-mount \
  docky gdebi auctex xfce4 clamav aspell exuberant-ctags amule vim gmchess \
  gnuplot julia stterm kde-window-manager emacs-snapshot emacs-snapshot-el \
  gnupg openvpn mdpress okular neovim gimp hdf5-tools curl fish iptux -y

sudo apt-get install -y ipython3 ipython3-notebook ipython3-qtconsole python3-regex python3-pip \
  python3-pygraph python3-setuptools python3-yaml python3-matplotlib python3-sympy python3-h5py \
  python3-networkx python3-scipy python3-simpy python3-pandas python3-mpmath

sudo pip3 install jupyter
sudo pip3 install neovim
sudo pip3 install pillow
sudo pip3 install plotly
sudo pip3 install statsmodels

sudo apt-get autoremove --purge -y

echo "Setting"
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

echo "Windows"
mv ~/.kde/share/config/kwinrc ~/.kde/share/config/kwinrc.backup
cp ./kwinrc ~/.kde/share/config/kwinrc
cp ./_keylaunchrc ~/.keylaunchrc
sudo cp ./IIMW.desktop /usr/share/xsessions/
sudo cp ./startIIMW /usr/bin/
sudo chmod +r /usr/bin/startIIMW

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

echo -e "Run `PlugInstall` in neovim to use plugins;\n\n vim has been installed, but has not been set up."
echo "Done"
