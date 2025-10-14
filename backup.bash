#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups/postgresql"
DB_NAME="production_db"

pg_dump -h localhost -U backup_user -d $DB_NAME -Fc > "$BACKUP_DIR/${DB_NAME}_${DATE}.dump"

find $BACKUP_DIR -name "${DB_NAME}_*.dump" -mtime +7 -delete