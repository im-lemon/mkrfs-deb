## MKRFS-DEB

A small wrapper tool around debootstrap I made for curses-containers to extract certain debian versions's rootfs. It wraps them up in a tar and generates a kernel image.

I also added a -h and -l option. -l lists all available distros for deboostrap, note that for some distributions: Kali, eLxr you need a keyring, use --get-keyrings to retrieve them. (Which is also something I added.)
