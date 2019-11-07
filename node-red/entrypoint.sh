#!/bin/bash

echo "Allowing node-red to write to folder /data ..."
sudo chown node-red:node-red /data

echo "Starting node-red ..."
npm start -- --userDir /data