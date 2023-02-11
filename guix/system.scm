;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules
 (gnu)
 (gnu system nss)
 (gnu services avahi)
 (nongnu packages linux)
 (guix channels)
 (guix inferior)
 (srfi srfi-1))

(use-service-modules desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (firmware (cons* iwlwifi-firmware
                  %base-firmware))
 (locale "en_US.utf8")
 (timezone "America/New_York")
 (keyboard-layout
  (keyboard-layout "us" #:options '("ctrl:nocaps")))
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (target "/boot/efi")
   (keyboard-layout keyboard-layout)))
 (file-systems
  (cons* (file-system
          (mount-point "/home")
          (device
           (uuid "f5674ecc-9a70-46c2-ad3c-8724e86375b3"
                 'ext4))
          (type "ext4"))
         (file-system
          (mount-point "/")
          (device
           (uuid "42bb3504-3d6c-43da-84d6-e629e7ebe155"
                 'ext4))
          (type "ext4"))
         (file-system
          (mount-point "/boot/efi")
          (device (uuid "CD73-6127" 'fat32))
          (type "vfat"))
         %base-file-systems))
 (host-name "perhonen")
 (users (cons* (user-account
                (name "cons")
                (comment "Brit Butler")
                (group "users")
                (home-directory "/home/cons")
                (supplementary-groups
                 '("wheel" "audio" "video" "netdev")))
               %base-user-accounts))
 (packages
  (append
   (map specification->package
        '("font-fira-code"
          "font-awesome"
          "font-dejavu"
          "nss-certs"
          "nss-mdns"
          "openssh"
          "polybar"
          "stumpwm"
          "avahi"
          "dunst"
          "xterm"
          "gvfs"
          "git"))
   %base-packages))
 (services
  (append
   (list (set-xorg-configuration
          (xorg-configuration
           (keyboard-layout keyboard-layout))))
   %desktop-services))
 (name-service-switch %mdns-host-lookup-nss))
