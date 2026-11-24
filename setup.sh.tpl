#!/bin/bash
dnf install -y cronie
systemctl enable --now crond

cat > /usr/local/bin/backup_logs.sh <<'SCRIPT'
#!/bin/bash
TS=$(date +%Y%m%d-%H%M%S)
tar czf /tmp/logs-$TS.tar.gz /var/log/messages /var/log/cloud-init.log 2>/dev/null
aws s3 cp /tmp/logs-$TS.tar.gz s3://${bucket}/backups/logs-$TS.tar.gz --region ap-south-1
rm -f /tmp/logs-$TS.tar.gz
SCRIPT
chmod +x /usr/local/bin/backup_logs.sh

echo "* * * * * root /usr/local/bin/backup_logs.sh >> /var/log/backup.log 2>&1" > /etc/cron.d/s3-backup
