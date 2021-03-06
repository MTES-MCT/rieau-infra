#!/bin/bash

cd rieau-infra/backup

source backup.env

TIME=`date +%d-%m-%Y"_"%H_%M_%S`
FILENAME=backup-rieau-$TIME.tar.gz

docker-compose -f ../app/docker-compose.yml exec -T db pg_dump -U rieau > rieau_dump.sql
docker-compose -f ../sso/docker-compose.yml exec -T db pg_dump -U keycloak > sso_dump.sql

tar -zcvf $DEST/$FILENAME $SRC/traefik/acme.json rieau_dump.sql sso_dump.sql

ftp -p -inv $FTP_SITE <<EOF
    user $FTP_USER $FTP_PASS
    lcd $DEST
    mput *.tar.gz
    bye
EOF

rm *_dump.sql

rm $DEST/$FILENAME