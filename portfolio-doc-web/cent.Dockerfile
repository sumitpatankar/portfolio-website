FROM sumitpatankar/centosapache:0.1 as centos-apache-web

USER root

LABEL name="apache-website"

USER apache

EXPOSE  80

CMD     ["/usr/sbin/httpd","-D","FOREGROUND"]