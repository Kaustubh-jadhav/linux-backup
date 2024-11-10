#!/bin/bash

# Configurable Variables
SOURCE_DIR="/home/user/data"        # The directory you want to back up
DEST_DIR="/mnt/backups"             # Backup destination directory
LOG_FILE="/var/log/backup_script.log" # Log file location
DATE=$(date +"%Y%m%d_%H%M%S")       # Timestamp for the backup
BACKUP_NAME="backup_$DATE.tar.gz"   # Backup filename
BACKUP_PATH="$DEST_DIR/$BACKUP_NAME" # Full path to the backup file

# Function to create the log entry
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

# Ensure the backup destination exists
if [ ! -d "$DEST_DIR" ]; then
    log_message "Destination directory does not exist. Creating $DEST_DIR."
    mkdir -p "$DEST_DIR"
    if [ $? -eq 0 ]; then
        log_message "Successfully created destination directory $DEST_DIR."
    else
        log_message "Error creating destination directory $DEST_DIR."
        exit 1
    fi
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    log_message "Source directory $SOURCE_DIR does not exist. Backup cannot proceed."
    exit 1
fi

# Start the backup process
log_message "Starting backup from $SOURCE_DIR to $BACKUP_PATH."

# Create the backup using tar
tar -czf "$BACKUP_PATH" -C "$SOURCE_DIR" . &> /dev/null

# Check if the backup was successful
if [ $? -eq 0 ]; then
    log_message "Backup completed successfully: $BACKUP_PATH."
else
    log_message "Backup failed for $SOURCE_DIR."
    exit 1
fi

# Optional: Clean up old backups (keep the last 7 days of backups, for example)
find "$DEST_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm -f {} \;
log_message "Old backups cleaned up (older than 7 days)."

# End of script
log_message "Backup script completed successfully."
