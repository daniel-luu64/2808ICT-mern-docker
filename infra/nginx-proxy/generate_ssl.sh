#!/bin/bash
mkdir -p $(dirname $0)/certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout $(dirname $0)/certs/localhost.key \
  -out $(dirname $0)/certs/localhost.crt \
  -subj "/CN=localhost"
