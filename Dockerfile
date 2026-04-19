FROM node:14-alpine

# Modern Alpine dropped the python2 "python" alias. Newer node images ship
# python3 via the `python3` package and node-gyp 5+ (bundled with npm on
# node:14) understand python3 natively.
ENV PYTHON=/usr/bin/python3
ENV npm_config_build_from_source=true

RUN apk update \
    && apk add --no-cache bash git make gcc g++ python3 linux-headers udev

COPY etc/node_mapping.json etc/node_mapping.json
COPY etc/zigbee2mqtt_configuration.yaml etc/zigbee2mqtt_configuration.yaml
COPY lib lib
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY app.js app.js

RUN npm i --production

CMD npm start
