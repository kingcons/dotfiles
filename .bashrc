alias ls='ls --color=auto'
alias ed='emacsclient -c'
alias enox='emacs -nw'
alias embedfonts='gs -o embedded-fonts.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress'
alias fixusb='sudo /sbin/udevd --daemon'
alias fixjack='pactl load-module module-jack-sink channels=2; pactl load-module module-jack-source channels=2;pacmd set-default-sink jack_out'
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
alias sshswank='ssh -L 4006:localhost:4005 redlinernotes.com'
# alias ps3share='ushare -d -i wlan0 -c $1'
# alias rgrep='find . -name \!:2 -exec grep -i \!^ {} /dev/null \\\;'
alias theusual='sudo aptitude update && sudo aptitude full-upgrade && df -h'
alias passkeys='ssh-add ~/.ssh/id_rsa'
alias record='guvcview -n'
alias screencast='recordmydesktop --device=pulse'
alias transcode='mencoder -ovc x264 -x264encopts bitrate=768 -oac faac'
alias avimerge='mencoder -forceidx -ovc copy -oac copy'
alias ripmulti='cdrdao read-cd --device /dev/cdrom -v 2 --datafile CD.bin --read-raw CD.toc'

alias letswork='VBoxHeadless -s cmg &'
alias gowork='ssh cmg@vbox -Y -A'
alias worksucks='VBoxManage controlvm cmg acpipowerbutton'

stty -ixon
export EDITOR='emacsclient -c'
PS1='[\u@\h \W]\$ '
unset PROMPT_COMMAND # just in case, <3 you emacs multi-term
TERM=rxvt

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
