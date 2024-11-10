# linux-backup
Linux Backup Automation Script with Logging
Explanation of the Script
## Variables:

SOURCE_DIR: The directory to be backed up (you can change this to any folder you need to back up).
DEST_DIR: The location where the backups will be stored (ensure this is on a separate disk or partition if needed).
LOG_FILE: Path to the log file where the script will write messages about the backup process.
DATE: Current timestamp in the format YYYYMMDD_HHMMSS, used to generate a unique name for the backup.
BACKUP_NAME: The name of the backup file, which includes the timestamp.
BACKUP_PATH: Full path to the backup file (combines the destination directory and the backup filename).
Log Function:

## log_message:
 A function that appends a log message with a timestamp to the log file (/var/log/backup_script.log).
Backup Process:

First, the script checks if the backup destination (DEST_DIR) exists. If not, it creates it.
Then, it checks if the source directory (SOURCE_DIR) exists. If it doesn’t, it exits with an error.
The tar command is used to compress the source directory into a .tar.gz file at the destination.
The script checks if the tar command was successful and logs the result.
## Cleanup of Old Backups:

The script includes a cleanup process that removes backups older than 7 days using the find command with -mtime +7.
This helps to ensure that backups don't accumulate indefinitely and take up unnecessary disk space.
## Log Files:

The log file (/var/log/backup_script.log) will contain a timestamped entry of each action performed by the script. This makes it easy to track the success or failure of the backup.
Email Configuration:

The variable EMAIL holds the email address for notifications.
send_email Function:

This function sends the email with a subject and body. It uses the mail command (you can also use sendmail if preferred).
Email on Success/Failure:

Email notifications are sent on success or failure of key actions like creating directories, starting the backup, or cleaning old backups.
Requirements:
You need a mail utility installed on the server. On most Linux systems, mail or mailx should work, but if not, you may need to install it using a package manager (e.g., sudo yum install mailx on CentOS/RHEL or sudo apt install mailutils on Ubuntu).
