#!/bin/sh
# my not quite hands-free post-debian install script

set -e

# the mega package install
echo "updating package cache and performing mega install..."
sudo aptitude update;
sudo aptitude install `cat debian_pkgs.txt`; cd ..;

# use them dotfiles!
echo "installing dotfiles..."
cp .[^.]* ~/; cp -R lisp_on_linux/.[^.]* ~/;
sudo cp lisp_on_linux/org.freedesktop.NetworkManager.pkla /etc/polkit-1/localauthority/50-local.d/;
#FIXME: this copies .git too for some reason...

# set up some scripts/hacks that other dotfiles use
echo "installing hacks and scripts..."
cd ~/projects; git clone git@github.com:redline6561/hacks.git;
cd hacks; crontab cronjobs; cd ~;

# configure the almighty text operating system
echo "configuring the almighty emacs"
git clone git@github.com:redline6561/dotemacs.git emacs;
cd emacs; git submodule update --init; cd site-lisp/jabber-mode/;
autoreconf -i && ./configure && make;

# grab other random helpers and toys
echo "installing random doo-dads..."
mkdir ~/bin; cd ~/bin;
wget -c https://raw.github.com/technomancy/leiningen/stable/bin/lein;
chmod +x lein && lein; mkdir ~/bin/builds; cd ~/bin/builds;
wget -c http://beta.quicklisp.org/quicklisp.lisp;
wget -c http://www.gotlisp.com/lambda/lambda.txt; strfile lambda.txt lambda.dat;
sudo mv lambda.dat /usr/share/games/fortunes/;
wget -c http://redlinernotes.com/docs/redppa.tar.gz; tar zxvf redppa.tar.gz;
rm redppa.tar.gz; #cd debs; sudo dpkg -i *.deb; cd ..;

# install ccl
echo "installing ccl..."
svn co http://svn.clozure.com/publicsvn/openmcl/release/1.7/linuxx86/ccl;
cd ccl; ./lx86cl64 -e "(progn (rebuild-ccl :full t) (quit))";
ln -s ~/bin/builds/ccl/lx86cl64 ../ccl;

# install pypy
echo "installing pypy..."
cd ~/bin/builds;
wget -c https://bitbucket.org/pypy/pypy/downloads/pypy-1.7-linux64.tar.bz2;
tar jxvf pypy*.bz2 pypy; rm pypy*.bz2; ln -s ~/bin/builds/pypy/bin/pypy ../;

# install factor
echo "installing factor..."
wget -c http://downloads.factorcode.org/releases/0.94/factor-linux-x86-64-0.94.tar.gz;
tar zxvf factor*.tar.gz factor; rm factor*.tar.gz; ln -s ~/bin/builds/factor/factor ../;

# install quicklisp on my lisps, download all the libs on sbcl
echo "installing quicklisp! (also, lots of libs)"
sbcl --load quicklisp.lisp;
sbcl --eval "(progn (map nil 'ql-dist:ensure-installed (ql-dist:provided-releases (ql-dist:dist \"quicklisp\"))) (sb-ext:quit))";

# install wallpapers, randomfile
echo "installing personal effects..."
mkdir ~/Pictures; cd ~/Pictures; wget -c http://redlinernotes.com/docs/assets.tar.bz2;
tar jxvf assets.tar.bz2; rm assets.tar.bz2; cd ~/projects/hacks/;
ecl -eval "(asdf:make-build :randomfile :type :program :monolithic t :move-here t)";
mv asdf-output/randomfile-mono ~/bin/randomfile;

echo "All done! Remember to install the debs in ~/bin/builds/debs/..."
echo "Also...you may want to cd ~ && sudo rm -R .git due to an outstanding bug. :-/"
