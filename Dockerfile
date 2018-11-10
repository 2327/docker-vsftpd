FROM alpine:latest

RUN apk add --no-cache vsftpd && \
    addgroup -g 101 1c && \
    adduser -h /home/./1c -s /bin/false -D -u 101 -G 1c 1c

RUN echo "local_enable=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "write_enable=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "local_umask=022" >> /etc/vsftpd/vsftpd.conf \
  && echo "passwd_chroot_enable=yes" >> /etc/vsftpd/vsftpd.conf \
  && echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_enable=Yes' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_max_port=30100' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_min_port=30200' >> /etc/vsftpd/vsftpd.conf \
  && sed -i "s/anonymous_enable=YES/anonymous_enable=NO/" /etc/vsftpd/vsftpd.conf

ADD vsftpd.sh /

EXPOSE 20 21 30100-30200

CMD /vsftpd.sh

