FROM alpine
MAINTAINER Kevin Patel <kevin@ductrix.com>

RUN apk update 

RUN apk add --no-cache bash git openssh

# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa

RUN chmod 600 /root/.ssh/id_rsa

# Create known_hosts RUN touch /root/.ssh/known_hosts 
# Add bitbuckets key
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

# Clone the conf files into the docker container
RUN git clone git@bitbucket.org:ketul917/ductrix-src.git /var/ductrix/

# basic flask environment
RUN apk add --no-cache bash git nginx uwsgi uwsgi-python py-pip \

#RUN apk add --no-cache bash git py-pip \
	&& pip install --upgrade pip \
	&& pip install flask

RUN apk update 

# Install psycopg2 and other packages 
RUN apk add --virtual build-deps gcc python-dev musl-dev libffi-dev libxml2 libxml2-dev libxslt-dev\ 
  && apk add postgresql-dev \
  && pip install psycopg2 \
  && pip install sqlalchemy \
  && pip install uuid \
  && pip install ConfigParser \
  && pip install Crypto \
  && pip install datetime \
  && pip install rq \
  && pip install redis \
  && pip install ansible\
  && pip install ansible-vault\
  && pip install pyvmomi\
  && pip install tools\
  && apk del build-deps


# application folder
ENV APP_DIR /app

# app dir
RUN mkdir ${APP_DIR} \
	&& chown -R nginx:nginx ${APP_DIR} \
	&& chmod 777 /run/ -R \
	&& chmod 777 /root/ -R
VOLUME [${APP_DIR}]
WORKDIR ${APP_DIR}

# expose web server port
# only http, for ssl use reverse proxy
EXPOSE 443

# copy config files into filesystem
COPY nginx.conf /etc/nginx/nginx.conf
COPY app.ini /app.ini
COPY entrypoint.sh /entrypoint.sh


# exectute start up script
ENTRYPOINT ["/entrypoint.sh"]
