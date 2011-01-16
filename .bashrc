alias ls='ls --color=auto'
alias ed='emacsclient -c'
alias enox='emacs -nw'
alias fixusb='sudo /sbin/udevd --daemon'
alias mounters='lsof /media/RedStorage/'
alias talkers='fuser -v /dev/snd/*'
alias rootwasters='du -hxs /*'
alias spacewasters='du -hx ~ | sort -h | tail -n 20'
alias headset='bluez-simple-agent hci0 00:21:19:24:68:7F'
alias burn='wodim -v dev=/dev/cdrw'
alias musync='rsync -rvzu --delete ~/music/ /media/disk/music/'
alias booksync='rsync -rvzu --delete ~/docs/books/ /media/disk/books/'
alias nexusync='musync && booksync'
alias logsync='rsync -av ~/.purple/logs/ ~/docs/logs/'
alias sshproxy='ssh -ND 6561 redlinernotes.com'
# alias ps3share='ushare -d -i wlan0 -c $1'
# alias rgrep='find . -name \!:2 -exec grep -i \!^ {} /dev/null \\\;'
alias theusual='sudo pacman -Syu && pak -Su --aur && sudo pacman -Scc && df -h'
alias golinode='ssh 74.207.227.162'
alias gothrust='ssh 109.169.54.131'
alias passkeys='ssh-add ~/.ssh/id_rsa'

stty -ixon
export EDITOR='emacsclient -c'
export PATH=$PATH:$HOME/builds/bin
export CHICKEN_DOC_REPOSITORY=/home/redline/emacs/site-lisp/chicken-doc/
PS1='[\u@\h \W]\$ '
TERM=rxvt

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
