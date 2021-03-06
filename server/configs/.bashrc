alias ls='ls --color=auto'
alias ed='emacs -nw -q'
alias enox='emacs -nw'
alias fixusb='sudo /sbin/udevd --daemon'
alias mounters='lsof /media/RedStorage/'
alias talkers='fuser -v /dev/snd/*'
alias burn='wodim -v dev=/dev/cdrw'
alias musync='rsync -rvzu --delete ~/music/ /media/disk/music/'
alias booksync='rsync -rvzu --delete ~/docs/books/ /media/disk/books/'
alias nexusync='musync && booksync'
alias rootwasters='du -hxs /*'
alias spacewasters='du -hx ~ | sort -h | tail -n 20'
alias clbuild='/home/redline/builds/clbuild-dev/clbuild'
alias theusual='sudo pacman -Syu && pak -Su --aur && sudo pacman -Scc && df -h'
alias sshproxy='ssh -ND 6561 redlinernotes.com'
alias gothrust='ssh 109.169.54.131'
alias golinode='ssh 74.207.227.162'

stty -ixon
export EDITOR='emacs -nw'
export PATH=$PATH:$HOME/builds/bin
PS1='[\u@\h \W]\$ '
TERM=rxvt

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
