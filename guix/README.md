## A Guix Config

* emacs profile
* lisp and c compilers

what else?

* stumpwm config
* nyxt

What do we want the install process to look like?

1. Install guix-sd with nonguix channel added using system.scm
2. Clone this repo, cd into this directory, and run install.sh

Install.sh should:

* Place dotfiles appropriately (just .bashrc, .stumpwmrc, and dotemacs clone hopefully)
* Loop over each defined profile setting it up as requested

