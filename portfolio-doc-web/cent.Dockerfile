FROM sumitpatankar/centosapache:0.1 as centos-apache-web

USER root

LABEL name="apache-website"

RUN mkdir /etc/httpd/sites-enabled; mkdir /etc/httpd/sites-available

COPY /portfolio-website-proj/conf-apache/httpd/sites-available/myapp.apache.com.conf /etc/httpd/sites-available/myapp.apache.com.conf

RUN ln -s /etc/httpd/sites-available/myapp.apache.com.conf /etc/httpd/sites-enabled/myapp.apache.com.conf

ADD /portfolio-website-proj/conf-apache/myapp.apache.com /var/www/myapp.apache.com

USER apache

EXPOSE  80

CMD     ["/usr/sbin/httpd","-D","FOREGROUND"]