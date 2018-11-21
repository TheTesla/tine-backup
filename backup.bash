#!/bin/bash

SRC=root@testserver.entroserv.de
DST=mailserver-backup

# Backup email databases and email files
ssh $SRC -t "mkdir -p /var/mail/databases/"
ssh $SRC -t "mysqldump postfix --result-file=/var/mail/databases/postfix.sql"
ssh $SRC -t "mysqldump dovecot --result-file=/var/mail/databases/dovecot.sql"
mkdir -p $DST/var/mail
rsync -avEzph --stats --delete --exclude='learn*.sieve' -e ssh $SRC:/var/mail $DST/var/

# Backup mailman
mkdir -p $DST/var/lib/mailman/data/
mkdir -p $DST/var/lib/mailman/lists/
mkdir -p $DST/var/lib/mailman/archives/
rsync -avEzph --stats --delete -e ssh $SRC:/var/lib/mailman/data $DST/var/lib/mailman/
rsync -avEzph --stats --delete -e ssh $SRC:/var/lib/mailman/lists $DST/var/lib/mailman/
rsync -avEzph --stats --delete -e ssh $SRC:/var/lib/mailman/archives $DST/var/lib/mailman/

# Backup tine20
ssh $SRC -t "mkdir -p /var/lib/tine20/databases/"
ssh $SRC -t "mysqldump tine20 --result-file=/var/lib/tine20/databases/tine20.sql"
mkdir -p $DST/var/lib/tine20/
rsync -avEzph --stats --delete --exclude='tmp/' --exclude='cache/' -e ssh $SRC:/var/lib/tine20 $DST/var/lib/

