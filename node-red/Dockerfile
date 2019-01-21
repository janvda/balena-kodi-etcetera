FROM nodered/node-red-docker:rpi-v8

# installing an editor
USER root
RUN apt-get update && apt-get install nano sqlite3 libi2c-dev i2c-tools wiringpi
USER node-red

RUN npm install node-red-contrib-resinio
RUN npm install node-red-dashboard
RUN npm install node-red-contrib-credentials
RUN npm install --unsafe-perm node-red-node-sqlite

#compile raspberry-pi-bme280 library
RUN git clone https://github.com/andreiva/raspberry-pi-bme280.git && cd raspberry-pi-bme280 && make && cd ..

COPY ./settings.js /data/settings.js
