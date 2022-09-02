FROM nginx:1.23 as nginx
RUN apt-get -y update && apt-get -y install firefox && apt-get -y install vim
