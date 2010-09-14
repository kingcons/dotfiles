alias ls='ls --color=auto'
alias ed='emacs -nw -q'
alias enox='emacs -nw'
alias fixusb='sudo /sbin/udevd --daemon'
alias mounters='lsof /media/RedStorage/'
alias talkers='fuser -v /dev/snd/*'
alias clbuild='/home/redline/builds/clbuild-dev/clbuild'
alias musync='rsync -rvzu --delete ~/music/ /media/disk/music/'
alias booksync='rsync -rvzu --delete ~/docs/books/ /media/disk/books/'
alias nexusync='musync && booksync'

stty -ixon
export EDITOR='emacs -nw'
export PATH=$PATH:$HOME/builds/bin
PS1='[\u@\h \W]\$ '
TERM=rxvt

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
