#!/bin/bash

DST=root@testserver.entroserv.de
SRC=mailserver-backup

# Backup email databases and email files
rsync -avEzph --stats --delete -e ssh $SRC/var/mail/ $DST:/var/mail/
ssh $DST -t "mysql postfix < /var/mail/databases/postfix.sql"
ssh $DST -t "mysql dovecot < /var/mail/databases/dovecot.sql"

# Backup mailman
rsync -avEzph --stats --delete -e ssh $SRC/var/lib/mailman/data/ $DST:/var/lib/mailman/
rsync -avEzph --stats --delete -e ssh $SRC/var/lib/mailman/lists/ $DST:/var/lib/mailman/
rsync -avEzph --stats --delete -e ssh $SRC/var/lib/mailman/archives/ $DST:/var/lib/mailman/

# Backup tine20
rsync -avEzph --stats --delete -e ssh $SRC/var/lib/tine20/ $DST:/var/lib/tine20/
ssh $DST -t "mysql tine20 < /var/lib/tine20/databases/tine20.sql"

