FROM nodered/node-red-docker:rpi-v8

# installing an editor
USER root
RUN apt-get update && apt-get install nano sqlite3 libi2c-dev i2c-tools wiringpi
USER node-red

# allow to do sudo within node-red
RUN sudo usermod -a -G sudo node-red

RUN npm install node-red-contrib-resinio
RUN npm install node-red-dashboard
RUN npm install node-red-contrib-credentials
RUN npm install --unsafe-perm node-red-node-sqlite

#compile raspberry-pi-bme280 library
RUN git clone https://github.com/andreiva/raspberry-pi-bme280.git && cd raspberry-pi-bme280 && make && cd ..

# see https://www.balena.io/docs/learn/develop/hardware/i2c-and-spi/
# following command changes the line in package.json :
#    "start": "node $NODE_OPTIONS node_modules/node-red/red.js -v $FLOWS"
# into
#    "start": "modprobe i2c-dev && node $NODE_OPTIONS node_modules/node-red/red.js -v $FLOWS"
RUN sed -i  -e 's/node \$NODE_OPTIONS/modprobe i2c-dev \&\& node $NODE_OPTIONS/' package.json

COPY ./settings.js /data/settings.js
