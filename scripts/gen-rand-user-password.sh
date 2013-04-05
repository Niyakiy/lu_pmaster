#!/bin/sh

# @autor: N1yakiy
# $1 - linux user name

# DESCRIPTION
# linux user's random password generator (4 use with Puppet configs by N1yakiy)
# WARNING! password will not be stored except hash in /etc/shadow
# WARNING! assuming ssh key based auth with key already in user's .ssh/autorized_keys

# 20 char length password generated with openssl
PASSWORD=`/usr/bin/openssl rand -base64 20`

# crypt password with sha-512 (debian 6+ default hash)
CRYPTED=`/usr/bin/mkpasswd -m sha-512 $PASSWORD`
USER=$1

# modifying user's password
/usr/sbin/usermod -p $CRYPTED $USER
