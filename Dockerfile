# This Dockerfile takes cues from:
# https://github.com/dockerfiles/django-uwsgi-nginx
# http://blog.ditullio.fr/2016/07/24/docker-django-uwsgi-nginx-web-app/
# https://github.com/modernproject/backend/blob/master/config/nginx/conf.d/modernproject.conf

FROM nginx

MAINTAINER Rona Chong <ronachong@gmail.com>

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY /home/rona/projects/moshimoji-nginx/nginx-default.conf /etc/nginx/conf.d/default.conf

# add code - TODO: change this to only media/static dirs
COPY /home/rona/projects/moshimoji-backend/ /home/docker/code/

EXPOSE 80

# using shell syntax for command line allows me to run both commands
# at once, but it may mean that executables "will not be the container’s
# PID 1 - and will not receive Unix signals - so your executable will not
# receive a SIGTERM from docker stop <container>."
CMD /usr/sbin/nginx -T && /usr/sbin/nginx
