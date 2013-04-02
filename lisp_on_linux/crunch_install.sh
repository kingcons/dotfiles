#!/bin/sh
# my not quite hands-free post-crunch install script

set -e

# the mega package install
echo "updating package cache and performing mega install..."
sudo apt-get update; sudo apt-get upgrade;
sudo apt-get install `cat crunch_pkgs.txt`; cd ..;

# use them dotfiles!
echo "installing dotfiles..."
cp lisp_on_linux/.ssh/config ~/.ssh/; cp .gitconfig ~/;
cp .Xdefaults ~/; cp .bashrc ~/.bash_aliases; cp .{screen,conkeror}rc ~/;
cat << EOF >> ~/.config/openbox/autostart

# redline's tweaks
eval `ssh-agent`
set | grep SSH > ~/.ssh/agent.env
~/projects/hacks/keyup.sh
emacs --daemon &
setxkbmap -option "ctrl:nocaps" &
EOF
#cp .[^.]* ~/; cp -R lisp_on_linux/.[^.]* ~/;

# set up some scripts/hacks that other dotfiles use
echo "installing hacks and scripts..."
cd ~/projects; git clone git@github.com:redline6561/hacks.git;
# cd hacks; crontab cronjobs; cd ~;

# configure the almighty text operating system
echo "configuring the almighty emacs"
git clone git@github.com:redline6561/prelude.git;
ln -s ~/projects/prelude ~/.emacs.d;

# grab other random helpers and toys
echo "installing random doo-dads..."
mkdir ~/bin; cd ~/bin;
# install leiningen
wget -c https://raw.github.com/technomancy/leiningen/stable/bin/lein;
chmod +x lein && lein; mkdir ~/bin/builds; cd ~/bin/builds;
# install lambda.txt quotes
wget -c http://www.gotlisp.com/lambda/lambda.txt; strfile lambda.txt lambda.dat;
sudo mv lambda.dat /usr/share/games/fortunes/;
# install ccl
echo "installing ccl..."
svn co http://svn.clozure.com/publicsvn/openmcl/release/1.9/linuxx86/ccl;
cd ccl; ./lx86cl64 -e "(progn (rebuild-ccl :full t) (quit))"; cd ..;
ln -s ~/bin/builds/ccl/lx86cl64 ../ccl;
# install pypy
echo "installing pypy..."
wget -c https://bitbucket.org/pypy/pypy/downloads/pypy-2.0-beta1-linux64-libc2.13.tar.bz2;
tar jxvf pypy*.bz2 pypy; rm pypy*.bz2; mv pypy* pypy;
ln -s ~/bin/builds/pypy/bin/pypy ../pypy;
# install factor
echo "installing factor..."
wget -c http://downloads.factorcode.org/releases/0.95/factor-linux-x86-64-0.95.tar.gz;
tar zxvf factor*.tar.gz factor; rm factor*.tar.gz;
ln -s ~/bin/builds/factor/factor ../factor;
# install luajit
echo "installing luajit..."
wget -c http://luajit.org/download/LuaJIT-2.0.0.tar.gz;
tar zxvf LuaJIT*.tar.gz; rm LuaJIT*.tar.gz; mv LuaJIT* luajit;
cd luajit; make && make install PREFIX=`pwd`; cd ..;
ln -s ~/bin/builds/luajit/bin/luajit ../luajit;
# install quicklisp for sbcl, download all the libs!
echo "install ALL OF THE QUICKLISP THINGS!"
sbcl --load /usr/share/cl-quicklisp/quicklisp.lisp;
sbcl --eval "(progn (map nil 'ql-dist:ensure-installed (ql-dist:provided-releases (ql-dist:dist \"quicklisp\"))) (sb-ext:quit))";

# google+ hangouts
echo "installing google talk plugin..."
wget -c https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb;
sudo dpkg -i google-talkplugin*; rm google-talkplugin*;
# skype (ugh)
echo "installing skype... (sorry)"
wget -c http://download.skype.com/linux/skype-debian_4.1.0.20-1_i386.deb;
sudo dpkg -i skype-debian*; rm skype-debian*;

# install wallpapers?
# echo "installing personal effects..."
# cd ~/images; wget -c http://redlinernotes.com/docs/assets.tar.bz2;
# tar jxvf assets.tar.bz2; rm assets.tar.bz2;
# install opendylan and pharo? install quickproject?
# wget -c http://redlinernotes.com/docs/redppa.tar.gz; tar zxvf redppa.tar.gz;
# rm redppa.tar.gz; #cd debs; sudo dpkg -i *.deb; cd ..;
