

# Wed Jan  4 14:09:08 CET 2017 - New files


CopyFile /etc/NetworkManager/NetworkManager.conf
CopyFile /etc/NetworkManager/VPN/nm-pptp-service.name
CopyFile /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
CopyFile /etc/NetworkManager/dispatcher.d/01ifupdown 755
CopyFile /etc/NetworkManager/system-connections/KikiKoki 600
CopyFile /etc/NetworkManager/system-connections/StuDOM 600
CopyFile /etc/NetworkManager/system-connections/eduroam 600
CopyFile /etc/NetworkManager/system-connections/win32 600
CopyFile /etc/adjtime
CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CopyFile /etc/localtime
CopyFile /etc/netctl/StuDOM
CopyFile /etc/netctl/wpa_studom.conf
CopyFile /etc/pacman.conf
CopyFile /wpa.conf

CopyFile /etc/dnsmasq.conf
CreateFile /etc/pacman.d/gnupg/.gpg-v21-migrated > /dev/null
CopyFile /etc/pacman.d/gnupg/gpg.conf
CopyFile /etc/pacman.d/gnupg/openpgp-revocs.d/4ADA2D6A2EB5055261ACF78CD775D12C04E97A0C.rev 600
CopyFile /etc/pacman.d/gnupg/private-keys-v1.d/1DE40145F8FEF76140C3074EE91B1C4F3A4ECE1A.key 600
CopyFile /etc/pacman.d/gnupg/pubring.gpg
CopyFile /etc/pacman.d/gnupg/pubring.gpg~
CreateFile /etc/pacman.d/gnupg/secring.gpg 600 > /dev/null
CopyFile /etc/pacman.d/gnupg/trustdb.gpg
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/pacman.d/mirrorlist.pacnew
