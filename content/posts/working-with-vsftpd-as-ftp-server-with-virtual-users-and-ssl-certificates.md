+++ 
draft = false
date = 2016-08-26T00:09:12+02:00
title = "Working with Vsftpd as ftp server with virtual users and SSL certificates"
description = ""
slug = "working-with-vsftpd-as-ftp-server-with-virtual-users-and-ssl-certificates" 
tags = []
categories = []
externalLink = ""
series = []
+++


# Working with Vsftpd as ftp server with virtual users and SSL certificates


Installation and configuration of Vsftpd with virtual users and SSL certificates.
Hi, on this post, I'm going to explain how to configure the very secure FTP daemon, <a href="https://security.appspot.com/vsftpd.html">vsftpd</a>

We want to install a ftp server with virtual users and SSL certificates.
Virtual users allow us to define users that are not on the underlying unix system.
There are several configuration files that we need to configure.
The main configuration file for vsftpd is usually located at /etc/vsdftpd.conf 
This is my first configuration file:
 
<pre class="theme:dark-terminal lang:sh decode:true " >

# Virtual users configuration
# pointing to the correct PAM service file
pam_service_name=vsftpd
write_enable=YES
hide_ids=YES
listen=YES
#connect_from_port_20=YES
anonymous_enable=NO
local_enable=YES
dirmessage_enable=YES
xferlog_enable=YES
chroot_local_user=YES
# passwd_chroot_enable=yes

user_config_dir=/etc/vsftpd_user_conf
guest_enable=YES
guest_username=virtual
virtual_use_local_privs=YES
</pre> 

I tell vsftp to work with a PAM service called vsftpd. This is for authenticate the virtual users. Then, I tell vsftp to jail the users, to enable guest (virtual) users and lookup directory /etc/vsftpd_user_conf to get the user configuration. So, each user on vsftpd will have a plain text file with the home folder and some other properties. This is really useful when you can't work with the template user prefix flag. In my case, the users does not follow a regular pattern, and also, each user has a different home folder, which is not related to the user name. For instance, user jose, will have as home folder /data/customer1.

Now let's take a look at the configuration of SSL certificates to make our connection more secure.
<h2>Configuration of SSL certificates</h2>

To work with SSL but allow only TSL v1 and higher, then we write the following on the configuration file vsftpd.conf:


 
<pre class="theme:dark-terminal lang:sh decode:true " ># SSL MANAGEMENT
ssl_enable=YES

#choose what you like, if you accept anon-connections
# you may want to enable this
allow_anon_ssl=YES

#choose what you like,
# it's a matter of performance i guess
# force_local_data_ssl=NO

#choose what you like
force_local_logins_ssl=YES

# Select which SSL ciphers vsftpd will allow for encrypted SSL connections (required by FileZilla)
ssl_ciphers=HIGH
# Disable SSL session reuse (required by WinSCP)
require_ssl_reuse=NO


#you should at least enable this if you enable ssl...
ssl_tlsv1=YES
#choose what you like
ssl_sslv2=NO
#choose what you like
ssl_sslv3=NO
#give the correct path to your currently generated *.pem file
rsa_cert_file=/etc/ssl/certs/vsftpd.pem
#the *.pem file contains both the key and cert
rsa_private_key_file=/etc/ssl/certs/vsftpd.pem</pre> 



Note that the certificate files can be created with openSSL. You can generate a certificate by executing this:
<code>
openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/certs/vsftpd.pem -out /etc/ssl/certs/vsftpd.pem
</code>
<h2>Configuration of PAM for virtual users</h2>


The first point is the configuration of virtual users, that is, no system users will log onto this system.
To do so, we need to configure an authentication mechanism, we will work with a module from PAM to authenticate virtual users. The documentation about PAM is somehow confusing, but I organized in two main links: <a href="http://www.linux-pam.org/">the main project page</a>, and <a href="https://fedorahosted.org/linux-pam/">the source code page, hosted by red hat</a>. There are some docs at the kernel.org main page, but it seems everything there is outdated.l 

To work with virtual users, we have to create a PAM service. This is basically a plain text configuration file in which we tell PAM which modules load to check the authentication. I will explain more in depth all details for a PAM service configuration later.I see three interesting authentication methods using PAM. 
<ul>
	<li><a href="https://wiki.archlinux.org/index.php/Very_Secure_FTP_Daemon#PAM_with_virtual_users">Authentication based on file</a>, so we will create a file in our system with the users and all the encrypted passwords.</li>
	<li>Authentication base on a tiny database, as far as I can read on the docs, PAM supports a  small database called <a href="https://en.wikipedia.org/wiki/Berkeley_DB">Berckley DB</a>.</li>
	<li>Authentication based on LDAP</li>

</ul>
The main document to prepare the configuration is <a href="https://wiki.archlinux.org/index.php/Very_Secure_FTP_Daemon">the Arch linux wiki for vsftpd.</a>
There are several problems with the first two authentication methods.
It seems that the support based on file is deprecated and no longer supported by the latest versions of PAM.
According to the ARCH linux wiki and forums, you can compile the package by using the <a href="https://aur.archlinux.org/packages/libpam_pwdfile/">AUR repo</a>.
If you are using a different linux distribution, you <a href="https://github.com/tiwe-de/libpam-pwdfile">can compile the package from github</a>.

On the other hand, it seems that due to licensing reasons, the support on the latest versions of BerckleyDB was dropped. <a href="https://web.stanford.edu/class/cs276a/projects/docs/berkeleydb/reftoc.html">You can find a tutorial on this database here</a>.

I will explain the three methods, starting by file based authentication.

<h2>Authentication based on file with PAM for virtual users</h2>
First of all, ensure that your current PAM version supports pam_pwdfile.so mechanism. Depending on the distribution you are using it could be on a different location, on ARCH, OpenSuse and Ubuntu:

<code>
ls -l /lib/security/pam_pwdfile.so
</code>
If you can't see the file, your distribution of PAM could not support this kind of authentication. If so, take a look at the git repository above and try to compile the library.
To configure a service in PAM to authenticate vsftp, we create the following file on /etc/pam.d/vsftpd:
<code>
auth required pam_pwdfile.so pwdfile /etc/vsftpd/.passwd
account required pam_permit.so
</code>

Basically this file tells PAM to use the authentication module pam_pwdfile.so, which looks at the users on the password file /etc/vsftpd/.passwd. 




With this configuration, we configure each virtual user with two files, one for the passwords and another with the properties, i.e. the home folder.
So all passwords are encrypted with OpenSSL algorithm:

With this command you get the password:

openssl passwd -1

[root@archpepex /]# openssl passwd -1 -noverify paquillo
$1$Mueh8aru$ejQWwyL9ZKiT/fe5ubpZE0

then add this info to the password file located in /etc/vsftpd/.passwd That file should looks like:

[root@archpepex /]# cat /etc/vsftpd/.passwd
paquillo:785DLoWKQK6oU
manolo:$1$Z8GKEXx7$h5Tq2RWBkEE02uv.xf1pN.
manolito:ozh3acxyO/Kq2

Then we need a file to configure a user, as stated on the vsftp.conf file, for user paquillo,
we should edit this file: /etc/vsftpd_user_conf/paquillo

[root@archpepex /]# cat /etc/vsftpd_user_conf/paquillo
write_enable=YES
allow_writeable_chroot=YES
chroot_local_user=YES
local_root=/srv/ftp/paquillo

You can adapt the local root folder as desired.

The full config file is here:
 
<pre class="theme:dark-terminal lang:sh decode:true " >#
# vsftpd Configuration File
# SSL TSL &gt; 1 enabled
# Virtual users enabled
# Virtual users chrooted
# Passive port range 28000 - 28099
# Listen port: 10021
############################################

# Virtual users configuration
# pointing to the correct PAM service file
pam_service_name=vsftpd
write_enable=YES
hide_ids=YES
listen=YES
#connect_from_port_20=YES
anonymous_enable=NO
local_enable=YES
dirmessage_enable=YES
xferlog_enable=YES
chroot_local_user=YES
# passwd_chroot_enable=yes

user_config_dir=/etc/vsftpd_user_conf
guest_enable=YES
guest_username=virtual
virtual_use_local_privs=YES
#local_root=/srv/ftp/$USER
#user_sub_token=$USER

# Listen port configuration
listen_port=10021

# Passive port configuration
pasv_min_port=28000
pasv_max_port=28099
pasv_address=192.168.56.101

# SSL MANAGEMENT
ssl_enable=YES

#choose what you like, if you accept anon-connections
# you may want to enable this
allow_anon_ssl=YES

#choose what you like,
# it's a matter of performance i guess
# force_local_data_ssl=NO

#choose what you like
force_local_logins_ssl=YES

# Select which SSL ciphers vsftpd will allow for encrypted SSL connections (required by FileZilla)
ssl_ciphers=HIGH
# Disable SSL session reuse (required by WinSCP)
require_ssl_reuse=NO


#you should at least enable this if you enable ssl...
ssl_tlsv1=YES
#choose what you like
ssl_sslv2=NO
#choose what you like
ssl_sslv3=NO
#give the correct path to your currently generated *.pem file
rsa_cert_file=/etc/ssl/certs/vsftpd.pem
#the *.pem file contains both the key and cert
rsa_private_key_file=/etc/ssl/certs/vsftpd.pem



</pre> 
