FROM nodered/node-red:1.0.2-12-arm32v7

######### Changing to root as below commands should be run as root #############

USER root

# Following command installs node-red-admin which is needed if you want to create a hashed password 
# for the node-red editor.  For that run command "node-red-admin hash-pw" in a terminal window
# for the node-red service in the BalenaCloud dashboard.
RUN npm install -g --unsafe-perm node-red-admin

# installing stuff for raspberry-pi-bme280 and sqlite
RUN apk update && apk add sudo wiringpi wiringpi-dev
#RUN apk update && apk add sqlite3 libi2c-dev i2c-tools wiringpi && rm -rf /var/cache/apk/*

# following command should assure that user node-red can use sudo without requiring to enter a password.
RUN echo "node-red ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

######### Changing back to node-red user #####################
USER node-red

RUN npm install node-red-dashboard
RUN npm install node-red-contrib-credentials
#RUN npm install --unsafe-perm node-red-node-sqlite

# install my version of node-red-contrib-balena that is extended with extra nodes to start/stop/restart service
# a node to retrieve the state of all services.
RUN npm install https://github.com/janvda/node-red-contrib-balena.git#service_start_stop_nodes

#compile raspberry-pi-bme280 library
RUN git clone https://github.com/andreiva/raspberry-pi-bme280.git && cd raspberry-pi-bme280 && make && cd ..

# see https://www.balena.io/docs/learn/develop/hardware/i2c-and-spi/
# following command changes the line in package.json :
#    "start": "node $NODE_OPTIONS node_modules/node-red/red.js -v $FLOWS"
# into
#    "start": "modprobe i2c-dev && node $NODE_OPTIONS node_modules/node-red/red.js -v $FLOWS"
RUN sed -i  -e 's/node \$NODE_OPTIONS/modprobe i2c-dev \&\& node $NODE_OPTIONS/' package.json

COPY ./settings.js /data/settings.js
COPY ./entrypoint.sh .

ENTRYPOINT  ["bash", "entrypoint.sh"]
