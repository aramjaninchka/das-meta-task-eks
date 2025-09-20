# S3 Bucket Creation Steps for TF State Storage:

### Bucket Name: aram-dasmeta-task-state
### Region: eu-north-1

### Bucket Creation
```bash
aws s3 mb s3://aram-dasmeta-task-state --region eu-north-1
```
### Versioning Enabling
```bash
aws s3api put-bucket-versioning --bucket aram-dasmeta-task-state --versioning-configuration Status=Enabled
```
### Enable Deny Deletion Policy

### Policy: deny-deletion.json

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyDeleteBucket",
            "Effect": "Deny",
            "Principal": "*",
            "Action": [
                "s3:DeleteBucket",
                "s3:DeleteBucketPolicy"
            ],
            "Resource": "arn:aws:s3:::your-bucket-name"
        }
    ]
}
```
### Applying the policy

```bash
aws s3api put-bucket-policy --bucket aram-dasmeta-task-state --policy file://./deny-deletion.json
```
### Edit the providers.tf, add the backend config block


