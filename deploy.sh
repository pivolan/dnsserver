#!/bin/sh
ROOT_PATH=$(cd $(dirname $0) && pwd);
PROJECT_PATH='~/go/src/github.com/pivolan/dnsserver'

CREDS='root@dedic2.lo'
echo $CREDS
ssh $CREDS "mkdir -p $PROJECT_PATH/;cd $PROJECT_PATH/;rm /tmp/GeoLite2-City.mmdb;mv $PROJECT_PATH/GeoLite2-City.mmdb /tmp/ ;rm -R $PROJECT_PATH/*;mv /tmp/GeoLite2-City.mmdb $PROJECT_PATH/"
rsync -azv --exclude='.idea' --exclude='GeoLite2-City.mmdb' --exclude='.git' --exclude='balances.json' $ROOT_PATH/* $CREDS:$PROJECT_PATH
ssh $CREDS "cd $PROJECT_PATH/;go build *.go;supervisorctl restart nameserver;"
echo `date` $CREDS