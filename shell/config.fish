# ~/.config/fish/config.fish

# Generic
set fish_greeting (fortune)
set EDITOR vim
set VISUAL vim
# ---
set -x LANG en_US.UTF-8
set -x LANGUAGE $LANG
set -x LC_ALL $LANG
set -x LC_CTYPE $LANG
set -x LC_MESSAGES $LANG
# ---
set -x FISH_PATH $HOME/.config/fish
set -x GOPATH $HOME/goWork
set -x GOBIN $GOPATH/bin
set -x PATH /usr/local/sbin $PATH
set -x PATH $PATH $GOBIN
set -U fish_user_paths $fish_user_paths $GOBIN
set -x JULIAFUNCDIR ~/julia/juliaFunc
# set -x JULIA_PKGDIR /usr/local/julia/julia-packages
set -gx PATH ~/tensorflow/bin $PATH
set -x NVIM_LISTEN_ADDRESS /tmp/neovim/neovim

# Aliases
alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias -='cd -'
alias ed='emacs -nw'
alias vi='vim'
#alias jl='julia'
alias pp='python3'
alias py='ipython3'
alias pyss='python -m SimpleHTTPServer'
alias jpt='jupyter'
alias jpn='jupyter notebook'
alias jpc='jupyter nbconvert --to'
alias mm='tmux -2 attach'
alias sc='scala -feature'
alias scc='scalac'
alias sskg='ssh-keygen'
# use sskg to generate id_rsa&id_ras.pub,
# and copy .pub to ~/.ssh/authorized_keys on server.
#alias nv="stterm -c Neovim -T Neovim -f 'Liberation Mono:pixelsize=15:antialias=true:autohint=true' -e fish -c 'nvim'"
alias mc="pandoc -f markdown+lhs slides.md -o slides.html -t dzslides -i -s -S --toc"
alias gb="go build -compiler gccgo -gccgoflags='-O3' "
alias uu="sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove --purge -y"

# functions
function kc
  echo "::kotlinc $argv.kt -include-runtime -d $argv.jar"
  kotlinc $argv.kt -include-runtime -d $argv.jar
end

function kr
  echo "::java -jar $argv.jar"
  java -jar $argv.jar
end

function lsp
  ls -ah --color=always $argv | less -R
end

# Misc
# initialise_ssh_agent
stty echo
# vi_mode

# Local configuration
if test -r ~/.config/fish/local.fish
  . "~/.config/fish/local.fish"
end
