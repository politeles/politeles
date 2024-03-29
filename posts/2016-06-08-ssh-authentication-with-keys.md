---
aliases:
- /2016/06/08/ssh-authentication-with-keys
categories:
- ssh 
- bash 
- linux
date: '2016-06-08'
description: Passwordless auth from multiple host using SSH keys
layout: post
title: SSH authentication with keys
toc: true

---

# SSH authentication with keys

Handling errors on ssh authentication.

If you have ssh authentication with public / private keys, sometimes you might face the issue,
that even when the authorized_keys contains your public key on the target host, the system is asking the password.


Some things you can try:
- Copy your public key by using ssh-copy-id command.
- Check permissions: the target home folder should be at least 75x, so the group can't write.
- you can debug the output of the ssh authentication command by:


```ssh
 ssh -v jpons@example
OpenSSH_7.2p2, OpenSSL 1.0.2g  1 Mar 2016
debug1: Reading configuration data /home/jpons/.ssh/config
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Connecting to example [10.50.136.10] port 22.
debug1: Connection established.
debug1: identity file /home/jpons/.ssh/id_rsa type 1
debug1: key_load_public: No such file or directory
debug1: identity file /home/jpons/.ssh/id_rsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /home/jpons/.ssh/id_dsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /home/jpons/.ssh/id_dsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /home/jpons/.ssh/id_ecdsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /home/jpons/.ssh/id_ecdsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /home/jpons/.ssh/id_ed25519 type -1
debug1: key_load_public: No such file or directory
debug1: identity file /home/jpons/.ssh/id_ed25519-cert type -1
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_7.2
debug1: Remote protocol version 2.0, remote software version OpenSSH_6.2
debug1: match: OpenSSH_6.2 pat OpenSSH* compat 0x04000000
debug1: Authenticating to example:22 as 'orapws'
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: algorithm: ecdh-sha2-nistp256
debug1: kex: host key algorithm: ecdsa-sha2-nistp256
debug1: kex: server->client cipher: aes128-ctr MAC: umac-64-etm@openssh.com compression: none
debug1: kex: client->server cipher: aes128-ctr MAC: umac-64-etm@openssh.com compression: none
debug1: sending SSH2_MSG_KEX_ECDH_INIT
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: Server host key: ecdsa-sha2-nistp256 SHA256:ig7JOjjK6WgLs0FG/OonjCtoU8fyQjFpN45KkCwnIUA
debug1: Host 'example' is known and matches the ECDSA host key.
debug1: Found key in /home/jpons/.ssh/known_hosts:12
debug1: rekey after 4294967296 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: rekey after 4294967296 blocks
debug1: SSH2_MSG_NEWKEYS received
debug1: SSH2_MSG_SERVICE_ACCEPT received
```