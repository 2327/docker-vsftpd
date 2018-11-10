#!/usr/bin/env sh

if [ -z ${PASSWORD} ]; then
  PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-8};echo;)
  echo "Generated password for user '1c': ${PASSWORD}"
fi
echo "1c:${PASSWORD}" |/usr/sbin/chpasswd
chown 1c:1c /home/1c/ -R

if [ -z $1 ]; then
  /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
else
  $@
fi

