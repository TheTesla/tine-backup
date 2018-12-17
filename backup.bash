#!/bin/bash

USER=root
SERVER=testserver.entroserv.de
BACKUP=~/myserverbackup

sudo SRC=$USER@$SERVER DST=$BACKUP/$SERVER ./backuprun.bash


