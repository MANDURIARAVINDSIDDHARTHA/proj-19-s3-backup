# Project 19: Scheduled S3 Backup

Terraform creates an EC2 instance with an IAM role allowed to write to an S3 bucket. User data installs cron and schedules a job (every minute for demo purposes) that tars the logs and uploads them to s3://<bucket>/backups/.
