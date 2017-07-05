#!/bin/bash

apt_get_install_apps()
{
	app_packages=( \
		"atop" \
		"autokey-gtk" \
		"automake" \
		"binutils" \
		"byzanz" \
		"cargo" \
		"cowsay" \
		"cmake" \
		"curl" \
		"devilspie" \
		"dkms" \
		"dos2unix" \
		"evince" \
		"expect" \
		"fbreader" \
		"gimp" \
		"gimp-gap" \
		"git" \
		"gnupg" \
		"golang" \
		"htop" \
		"hexchat" \
		"lsdvd" \
		"m4" \
		"make" \
		"mercurial" \
		"nmap" \
		"openvpn" \
		"p7zip" \
		"pdfmod" \
		"pinta" \
		"patch" \
		"python" \
		"python2.7-devel" \
		"python-argparse" \
		"perl" \
		"pitivi" \
		"rxvt" \
		"screen" \
		"screenfetch" \
		"sound-juicer" \
		"sqlitebrowser" \
		"screenruler" \
		"terminator" \
		"texinfo" \
		"tmux" \
		"unzip" \
		"vim" \
		"vlc" \
		"unzip" \
		"devede" \
		"gpick" \
		"virtualbox" \
	)


	for i in "${app_packages[@]}"
	do
		echo "Installing: " $i
		apt-get -y install $i >>~/postinstall_log.txt 2>>~/postinstall_errors.txt
		if [ $? -ne 0 ]; then
			echo "There was a problem installing " $i " see log file "
		fi
	done
}

setup_vbox_guestadditions()
{

	KERNELVER = "$(uname -r)"

	rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	yum -y install gcc kernel-devel kernel-headers dkms make bzip2 perl

	KERN_DIR=/usr/src/kernels/$KERNELVER
	export KERN_DIR	

	mkdir /media/VirtualBoxGuestAdditions
	mount -r /dev/cdrom /media/VirtualBoxGuestAdditions/

	if [ $? -ne 0 ]; then
		echo "ERROR: Could not mount the guest additions disk. Ensure that it is inserted and run this method again"
		return 1
	fi

	./media/VirtualBoxGuestAdditions/VBoxLinuxAdditions.run


}

