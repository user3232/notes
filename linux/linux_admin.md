
# Administrative common commands

https://www.lpi.org


* Administration
    * https://github.com/mtds/sysadmin_notes
    * [Linux certification wikibook](https://en.wikibooks.org/wiki/LPI_Linux_Certification)
    * [IBM Linux Professional Institute (LPI) exam prep](https://www.ibm.com/developerworks/linux/lpi/)
    * http://www.linux-tutorial.info/
    * https://en.wikibooks.org/wiki/Linux_Guide


* network:
    * route, ip route show
    * ifconfig, ip addr show
    * netstat, ss
    * /etc/resolv.conf, /etc/hosts
    * IPv4, IPv6
    * ping
    * host
    * ip
    * ifconfig
    * route
    * arp
    * iw
    * iwconfig
    * iwlist
    * ping, ping6
    * nc
    * tcpdump
    * nmap
    * /etc/network/, /etc/sysconfig/network-scripts/
    * traceroute, traceroute6
    * mtr
    * hostname
    * System log files such as /var/log/syslog, /var/log/messages and the systemd journal
    * dmesg
    * /etc/resolv.conf
    * /etc/hosts
    * /etc/hostname, /etc/HOSTNAME
    * /etc/hosts.allow, /etc/hosts.deny
    * /etc/named.conf
    * /var/named/
    * /usr/sbin/rndc
    * kill
    * host
    * dig
    * /var/named/
    * zone file syntax
    * resource record formats
    * named-checkzone
    * named-compilezone
    * masterfile-format
    * dig
    * nslookup
    * host
    * /etc/named.conf
    * /etc/passwd
    * DNSSEC
    * dnssec-keygen
    * dnssec-signzone
    * /proc/sys/net/ipv4/
    * /proc/sys/net/ipv6/
    * /etc/services
    * iptables
    * ip6tables
    * dhcp:
        * dhcpd.conf
        * dhcpd.leases
        * DHCP Log messages in syslog or systemd journal
        * arp
        * dhcpd
        * radvd
        * radvd.conf
    * ssh:
        * ssh
        * sshd
        * /etc/ssh/sshd_config
        * /etc/ssh/
        * Private and public key files
        * PermitRootLogin, PubKeyAuthentication, AllowUsers, PasswordAuthentication, Protocol
    * OpenVPN
        * /etc/openvpn/
        * openvpn
* apache:
    * access logs and error logs
    * .htaccess
    * httpd.conf
    * mod_auth_basic, mod_authz_host and mod_access_compat
    * htpasswd
    * AuthUserFile, AuthGroupFile
    * apachectl, apache2ctl
    * httpd, apache2
    * Apache2 configuration files
    * /etc/ssl/, /etc/pki/
    * openssl, CA.pl
    * SSLEngine, SSLCertificateKeyFile, SSLCertificateFile
    * SSLCACertificateFile, SSLCACertificatePath
    * SSLProtocol, SSLCipherSuite, ServerTokens, ServerSignature, TraceEnable
* squid nginx proxy:
    * squid.conf
    * acl
    * http_access    
    * /etc/nginx/
    * nginx
* security:
    * /etc/pam.d/
    * pam.conf
    * nsswitch.conf
    * pam_unix, pam_cracklib, pam_limits, pam_listfile, pam_sss
    * sssd.conf
* users:
    * /etc/passwd, /etc/shadow, /etc/group
    * id, last, who, w
    * sudo, su
    * /etc/passwd, /etc/shadow, /etc/group, /etc/skel/
    * useradd, groupadd
    * passwd
    * ls -l, ls -a
    * chmod, chown
* logging processes, memory,... :
    * ps, top, free
    * syslog, dmesg
    * /etc/, /var/log/
    * /boot/, /proc/, /dev/, /sys/
    * iostat
    * netstat
    * w
    * top
    * sar
    * vmstat
    * pstree, ps
    * Isof
    * uptime
* kernel
    * /usr/src/linux/
    * /usr/src/linux/Documentation/
    * zImage
    * bzImage
    * xz compression
    * mkinitrd
    * mkinitramfs
    * make
    * make targets (all, config, xconfig, menuconfig, gconfig, oldconfig, mrproper, zImage, bzImage, * modules, modules_install, rpm-pkg, binrpm-pkg, deb-pkg)
    * gzip
    * bzip2
    * module tools
    * /usr/src/linux/.config
    * /lib/modules/kernel-version/
    * depmod
    * dkms
    * /lib/modules/kernel-version/modules.dep
    * module configuration files in /etc/
    * /proc/sys/kernel/
    * /sbin/depmod
    * /sbin/rmmod
    * /sbin/modinfo
    * /bin/dmesg
    * /sbin/lspci
    * /usr/bin/lsdev
    * /sbin/lsmod
    * /sbin/modprobe
    * /sbin/insmod
    * /bin/uname
    * /usr/bin/lsusb
    * /etc/sysctl.conf, /etc/sysctl.d/
    * /sbin/sysctl
    * udevmonitor
    * udevadm monitor
    * /etc/udev/
* systemd
    * /usr/lib/systemd/
    * /etc/systemd/
    * /run/systemd/
    * systemctl
    * systemd-delta
    * /etc/inittab
    * /etc/init.d/
    * /etc/rc.d/
    * chkconfig
    * update-rc.d
    * init and telinit    
* filesystem and booting:
    * mount
    * fsck
    * inittab, telinit and init with SysV init
    * The contents of /boot/, /boot/grub/ and /boot/efi/
    * EFI System Partition (ESP)
    * GRUB
    * grub-install
    * efibootmgr
    * UEFI shell
    * initrd, initramfs
    * Master boot record
    * systemctl
    * /etc/fstab
    * /etc/mtab
    * /proc/mounts
    * mount and umount
    * blkid
    * sync
    * swapon
    * swapoff
    * mkfs (mkfs.*)
    * mkswap
    * fsck (fsck.*)
    * tune2fs, dumpe2fs and debugfs
    * btrfs, btrfs-convert
    * xfs_info, xfs_check, xfs_repair, xfsdump and xfsrestore
    * smartd, smartctl
* Access control
    * getfacl
    * setfacl
    * getfattr
    * setfattr
* virtualization
    * XEN
        * Domain0 (Dom0), DomainU (DomU)
        * PV-DomU, HVM-DomU
        * /etc/xen/
        * xl
        * xl.cfg
        * xl.conf
        * xe
        * xentop
    * KVM
        * Kernel modules: kvm, kvm-intel and kvm-amd
        * /etc/kvm/
        * /dev/kvm
        * kvm
        * KVM monitor
        * qemu
        * qemu-img
    * libvirt
        * libvirtd
        * /etc/libvirt/
        * virsh
        * oVirt
* containers:
    * docker
    * Dockerfile
    * .dockerignore
    * docker-compose
    * docker
    * kubectl
    * docker-machine
    * vagrant
    * Vagrantfile
    * packer
    * ansible.cfg
    * ansible-playbook
    * ansible-vault
    * ansible-galaxy
    * ansible-doc


