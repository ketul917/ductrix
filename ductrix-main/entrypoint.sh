#!/bin/bash

cd /var/ductrix ; git pull
supervisord --config /var/ductrix/web/supervisord.conf

if [ "$1" == "-d" ]; then
	echo "Running app in debug mode!"
	python /var/ductrix/web/app.py
else
	echo "Running app in production mode!"
	nginx && uwsgi --ini /app.ini
fi
