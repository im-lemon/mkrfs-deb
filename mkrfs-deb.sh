#!/usr/bin/bash

releases=$(ls /usr/share/debootstrap/scripts)

if [ $# != 1 ]; then
	echo "Pass a release argument. Note: mkrfs also supports kali, eLxr (If you have those keyrings) and older Ubuntu (no keyring needed!)."
	exit -1
fi

if [ $1 == "-h" ]; then
	echo ""
	echo "              mkrfs is a wrapper around debootstrap, it uses debootstrap to prepare a rootfs, 
	      tars it up, and extracts a kernel image from said rootfs.
	      
	      additional info:

	      github: https://github.com/im-lemon/mkrfs-deb
	      issues: https://github.com/im-lemon/mkrfs-deb/issues

	      also, to print available distributions, use -l.

	      please note that debootstrap needs keyrings for eLxr and kali.
	      to get those, use the --get-keyrings flag."
	echo ""

	exit 0
fi

if [ $1 == "-l" ]; then
	echo ""
	echo "$releases"
	exit 0
fi

if [ "$1" == "--get-keyrings" ]; then
	echo "Retrieving KALI keyring."
	echo ""

	sudo wget https://archive.kali.org/archive-keyring.gp -O /usr/share/keyrings/kali-archive-keyring.gpg


	echo ""
	echo "[MKRFS_DEB_GETKEYRING done]"
	echo ""
	echo "Retrieving ELXR keyring."
	wget http://mirror.elxr.dev/elxr/pool/main/e/elxr-archive-keyring/elxr-archive-keyring_2025.12-elxr3_all.deb
	sudo dpkg -i elxr-archive-keyring_2025.12-elxr3_all.deb
	rm *.deb
	rm *.deb.1
	echo "[MKRFS_DEB_GETKEYRING done]"
	exit 0
fi

rel=$1

echo ""
sudo debootstrap $1 $HOME/build
echo ""
sudo tar --numeric-owner -cpf "$HOME/deb-rootfs.tar" -C "$HOME/build" .

rm -rf build/

echo "Name for kernel image: "
read ki_n

if ["$ki_n" = ""]; then
	ki_n="bzImage"
fi

cp /boot/vmlinuz* $HOME/$ki_n

echo "Copied kernel image into home folder as $ki_n."
