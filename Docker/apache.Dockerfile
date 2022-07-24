FROM centos:7 as apache-web

USER root

LABEL name="website"

# Simple startup script to avoid some issues observed with container restart
# ADD run-httpd.sh /run-httpd.sh
# RUN chmod -v +x /run-httpd.sh

# CMD ["/run-httpd.sh"]
ENV container docker

RUN yum -y install systemd net-tools vim httpd; yum clean all; \
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN adduser -u $APACHE_ADMIN_UID -ms /bin/bash $APACHE_ADMIN
VOLUME [ "/sys/fs/cgroup" ]

USER $APACHE_ADMIN
WORKDIR $APACHE_HOME
EXPOSE  8080
CMD [ "/usr/sbin/init", "/usr/sbin/httpd -D FOREGROUND" ]