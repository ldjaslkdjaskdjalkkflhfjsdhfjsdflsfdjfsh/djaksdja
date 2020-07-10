#!/bin/bash

ip link set wlp2s0 up

wifi-menu

timedatectl set-ntp true
mkfs.ext4 /dev/sda6
mkswap /dev/sda5
swapon /dev/sda5
mount /dev/sda6 /mnt
nano /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
hwclock --systohc
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo -e "en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" >> /etc/locale.gen 
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LANG=ru_RU.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8
echo FONT=cyr-sun16 > /etc/vconsole.conf
echo arch > /etc/hostname
passwd root
echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 arch.localdomain arch" >> /etc/hosts
mkinitcpio -P
useradd -m -g wheel -c 'arch' -s /bin/bash arch
passwd arch
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
pacman -S networkmanager intel-ucode xf86-input-synaptics xf86-video-nouveau xf86-video-intel pcmanfm iucode-tool terminator git ttf-dejavu alsa-utils xorg-server xorg-xinit xorg-twm xterm xorg-server-devel xorg-drivers

echo "[archlinuxfr]

SigLevel = Never

Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
systemctl enable NetworkManager
systemctl start NetworkManager
modprobe cpuid
bsdtar -Oxf /boot/intel-ucode.img | iucode_tool -tb -lS -
yay -S pamac-aur-git i3-gaps-next-git polybar 
pacman -S sddm
systemctl enable sddm
systemctl start sddm
#lynx ranger alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio
# nmcli dev wifi connect имя_точки password пароль
# network-manager-applet xdg-user-dirs
##Или Wi-fi
iwctl

#Если не знаете название вашего устройства, то пишем:
#ip link

#Например ваш device = wlp5s0

#station device connect SSID
#Где SSID = название вашей сети
#После этого вам будет предложено ввести пароль

#Подробнее https://wiki.archlinux.org/index.php/Iwd#iwctl 

#.xinitrc exec i3
#yay -Syu
# sudo startx


# f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils file-roller p7zip unrar gvfs aspell-ru pulseaudio 
#dmesg -T | grep microcode
