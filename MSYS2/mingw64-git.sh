#!/bin/bash
# https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper

sed -i '/^\[mingw32\]/{ s|^|[git-for-windows]\nServer = https://wingit.blob.core.windows.net/x86-64\n\n[git-for-windows-mingw32]\nServer = https://wingit.blob.core.windows.net/i686\n\n|; }' /etc/pacman.conf

rm -rf /etc/pacman.d/gnupg/
pacman-key --init
pacman-key --populate msys2

curl -k -L https://raw.githubusercontent.com/git-for-windows/build-extra/HEAD/git-for-windows-keyring/git-for-windows.gpg |
pacman-key --add - &&
pacman-key --lsign-key E8325679DFFF09668AD8D7B67115A57376871B1C &&
pacman-key --lsign-key 3B6D86A1BA7701CD0F23AED888138B9E1A9F3986

pacman -Syyuu --noconfirm

pacman -Suu --noconfirm

pacman -S mingw-w64-x86_64-{git,git-doc-html,git-credential-manager} --noconfirm

pacman -S mingw64/mingw-w64-x86_64-{curl,gnutls,openssl}