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
# for Go:
### please be very careful which go you are using!!!
### curl -O https://storage.googleapis.com/golang/go-.-.linux-amd64.tar.gz
### tar -xvf go-.-.linux-amd64.tar.gz ; sudo mv go /usr/local
#set -x PATH /usr/local/go/bin $PATH
### sudo apt install golang-1.8
set -x GOPATH $HOME/golang
set -x GOBIN $GOPATH/bin
set -x PATH /usr/lib/go-1.8/bin $PATH
set -x PATH $PATH $GOBIN
# for Spark:
set -x SPARK_HOME /opt/spark
set -x SPARK_BIN $SPARK_HOME/bin
set -x PATH $PATH $SPARK_BIN
set -x PYSPARK_PYTHON python3
set -x PYSPARK_DRIVER_PYTHON ipython
#set -x PYSPARK_DRIVER_PYTHON_OPTS "notebook"
# Misc.
#set -gx PATH $HOME/anaconda/bin $PATH
#set -gx PATH $HOME/tensorflow/bin $PATH
#set -gx PATH /opt/android-studio/bin $PATH
#set -gx NVIM_LISTEN_ADDRESS /tmp/neovim/neovim
# ---
set -x FISH_PATH $HOME/.config/fish
set -x PATH /usr/local/sbin $PATH
set -U fish_user_paths $fish_user_paths $GOBIN
# use 256 color term
if begin; status --is-interactive; end
    set -gx TERM xterm-256color
end

# Aliases
alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias -='cd -'
alias ed='emacs -nw'
alias ex='emacs'
alias pp='python3'
alias py='ipython3'
alias pyss='python -m SimpleHTTPServer'
alias pipu='sudo pip install --upgrade'
alias jpt='jupyter'
alias jpn='jupyter notebook'
alias jps='jupyter notebook --no-browser --port=8899' # server
alias jpc='ssh -N -f -L localhost:8888:localhost:8899 mw..@svr' # fill real info here!!!
alias jpcvt='jupyter nbconvert --to'
alias mm='tmux -2 attach'
alias sskg='ssh-keygen'
# use sskg to generate id_rsa&id_ras.pub, and copy .pub to ~/.ssh/authorized_keys on server.
alias qg='xmodmap ~/.Q-layout/Q.xmodmap'
alias qc='sudo loadkeys ~/.Q-layout/Q-iso15.kmap'
alias gb="go build -compiler gccgo -gccgoflags='-O3' "
alias mc="pandoc -f markdown+lhs slides.md -o slides.html -t dzslides -i -s -S --toc"
alias uu="sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove --purge -y"

# Function
function kc
  echo "::kotlinc $argv.kt -include-runtime -d $argv.jar"
  kotlinc $argv.kt -include-runtime -d $argv.jar
end

function kr
  echo "::java -jar $argv[1].jar $argv[2..-1]"
  java -jar $argv[1].jar $argv[2..-1]
end

function lc
  ls -ah --color=always $argv | less -R
end

function vi
    if command --search vim >/dev/null do
        vim  $argv[1..-1]
    else
        nvim $argv[1..-1]
    end
end

function vd
    if command --search vim >/dev/null do
        vimdiff $argv[1..-1]
    else
        nvim -d $argv[1..-1]
    end
end

# Local configuration
if test -r ~/.config/fish/local.fish
  . "~/.config/fish/local.fish"
end
