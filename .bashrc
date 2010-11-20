alias ls='ls --color=auto'
alias ed='emacs -nw -q'
alias enox='emacs -nw'
alias fixusb='sudo /sbin/udevd --daemon'
alias mounters='lsof /media/RedStorage/'
alias talkers='fuser -v /dev/snd/*'
alias rootwasters='du -hxs /*'
alias spacewasters='du -hx ~ | sort -h | tail -n 20'
alias burn='wodim -v dev=/dev/cdrw'
alias clbuild='/home/redline/builds/clbuild-dev/clbuild'
alias dbsh='ssh -X bbutler2@okaram.spsu.edu'
alias spsh='ssh cse1+bbutler2@192.168.43.17'
alias heftysh='ssh brit@67.202.54.82'
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
# alias godinky=''

stty -ixon
export EDITOR='emacs -nw -q'
export PATH=$PATH:$HOME/builds/bin
PS1='[\u@\h \W]\$ '
TERM=rxvt

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
