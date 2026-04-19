FROM node:12.5-alpine

# python → python3 in current Alpine; expose PYTHON for node-gyp (used by native builds).
ENV PYTHON=/usr/bin/python3
ENV npm_config_build_from_source=true

RUN apk update \
    && apk add bash git make gcc g++ python3 linux-headers udev \
    && npm install -g node-gyp@9

COPY etc/node_mapping.json etc/node_mapping.json
COPY etc/zigbee2mqtt_configuration.yaml etc/zigbee2mqtt_configuration.yaml
COPY lib lib
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY app.js app.js

RUN npm i --production

CMD npm start
