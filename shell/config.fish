# ~/.config/fish/config.fish

# Generic
set fish_greeting (fortune)
set EDITOR emacs
set VISUAL emacs
# ---
set -x LANG en_US.UTF-8
set -x LANGUAGE $LANG
set -x LC_ALL $LANG
set -x LC_CTYPE $LANG
set -x LC_MESSAGES $LANG
# ---
set -x FISH_PATH $HOME/.config/fish
set -x GOPATH $HOME/golang
set -x GOBIN $GOPATH/bin
set -x PATH /usr/lib/go-1.8/bin $PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH $PATH $GOBIN
set -U fish_user_paths $fish_user_paths $GOBIN
set -gx PATH $HOME/anaconda/bin $PATH
set -gx PATH $HOME/tensorflow/bin $PATH
set -gx PATH /opt/android-studio/bin $PATH
set -x NVIM_LISTEN_ADDRESS /tmp/neovim/neovim

# Aliases
alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias -='cd -'
alias ed='emacs -nw'
alias em='emacs'
alias vi='vim'
alias pp='python3'
alias py='ipython3'
alias pyss='python -m SimpleHTTPServer'
alias jpt='jupyter'
alias jpn='jupyter notebook'
alias jps='jupyter notebook --no-browser --port=8889' # server
alias jpc='ssh -N -f -L localhost:8888:localhost:8889 mw..@svr' # fill real info here!!!
alias jpcvt='jupyter nbconvert --to'
alias mm='tmux -2 attach'
alias sskg='ssh-keygen'
# use sskg to generate id_rsa&id_ras.pub, and copy .pub to ~/.ssh/authorized_keys on server.
alias mc="pandoc -f markdown+lhs slides.md -o slides.html -t dzslides -i -s -S --toc"
alias gb="go build -compiler gccgo -gccgoflags='-O3' "
alias uu="sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove --purge -y"

# functions
function kc
  echo "::kotlinc $argv.kt -include-runtime -d $argv.jar"
  kotlinc $argv.kt -include-runtime -d $argv.jar
end

function kr
  echo "::java -jar $argv[1].jar $argv[2..-1]"
  java -jar $argv[1].jar $argv[2..-1]
end

function lsp
  ls -ah --color=always $argv | less -R
end

# Misc
stty echo

# Local configuration
if test -r ~/.config/fish/local.fish
  . "~/.config/fish/local.fish"
end
