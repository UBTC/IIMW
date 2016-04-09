# ~/.config/fish/config.fish

# Generic
set fish_greeting (fortune)
set EDITOR nvim
set VISUAL nvim
set -x NVIM_LISTEN_ADDRESS /tmp/neovim/neovim
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

# Aliases
alias ed='vim'
alias em='emacs -nw'
alias ec='emacs'
alias vi='gvim'
alias ne='nvim'
alias nd='nvim -d'
alias jl='julia'
alias py='ipython'
alias jp='jupyter'
alias jn='jupyter notebook'
alias jc='jupyter nbconvert --to'
alias mm='tmux -2'
alias tmux='tmux -2'
alias nv="stterm -c Neovim -T Neovim -f 'Liberation Mono:pixelsize=15:antialias=true:autohint=true' -e fish -c 'nvim'"
alias mc="pandoc -f markdown+lhs slides.md -o slides.html -t dzslides -i -s -S --toc"
alias gb="go build -compiler gccgo -gccgoflags='-O3' "
alias uu="sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove --purge -y"

# Misc
# initialise_ssh_agent
stty echo
# vi_mode

# Local configuration
if test -r ~/.config/fish/local.fish
  . "~/.config/fish/local.fish"
end
