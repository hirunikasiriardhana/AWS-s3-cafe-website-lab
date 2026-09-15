# AWS S3 Static Website Hosting — The Café Project ☕

A hands-on project demonstrating how to host a static website on **Amazon S3**
with **IP-restricted access control**, provisioned using the **AWS CLI** and
automated with **Boto3 (AWS SDK for Python)**.

## 📖 Overview

This project simulates a small business ("The Café") launching its first
web presence. It walks through creating an S3 bucket, applying a custom
security policy that restricts access to a specific IP range, uploading
static site assets, and validating the access-control behavior.

## 🏗️ Architecture

```
                     ┌─────────────────────────┐
   Allowed IP  ────▶ │   Amazon S3 Bucket       │
   (café network)    │   (static website files) │
                     │   + Bucket Policy         │
   Other IPs   ──X──▶│   (IP-based restriction)  │
                     └─────────────────────────┘
```

- **Amazon S3** — object storage serving the site's HTML/CSS/JS/images
- **Bucket Policy** — a custom JSON policy restricting `s3:GetObject`
  to a single IP address (`/32`), plus a signed-request-only rule for
  a specific object
- **Boto3** — Python script applies the bucket policy programmatically
- **AWS CLI** — used to create the bucket and bulk-upload site assets

## 🔧 What Was Done

1. Created an S3 bucket via `aws s3api create-bucket`
2. Disabled the default "Block all public access" setting (scoped down
   again immediately afterward via policy conditions)
3. Wrote a bucket policy (`website_security_policy.json`) that:
   - Allows `GetObject` only from an allow-listed IP address
   - Explicitly denies unsigned requests to a specific sensitive object
     (`report.html`)
4. Applied the policy programmatically using `python_3/permissions.py`
   (Boto3)
5. Bulk-uploaded the website's static assets with cache-busting headers:
   ```bash
   aws s3 cp ./website s3://<bucket-name>/ --recursive --cache-control "max-age=0"
   ```
6. Verified access control by:
   - Loading the site successfully from the allow-listed IP
   - Confirming an `AccessDenied` response via `curl` from a different
     network/IP

## 📂 Repo Structure

```
aws-s3-cafe-website/
├── README.md
├── website_security_policy.json   # IAM-style bucket policy (IP redacted)
├── python_3/
│   └── permissions.py             # Applies the bucket policy via Boto3
└── website/                       # Static site assets (HTML/CSS/JS/images)
```

## 🚀 Skills Demonstrated

- AWS CLI (bucket creation, bulk S3 uploads)
- S3 bucket policies & fine-grained access control (IP conditions,
  signed-request enforcement)
- Boto3 / AWS SDK for Python
- Static website hosting fundamentals on S3
- Access-control validation and testing

## ⚠️ Notes

- The IP address in `website_security_policy.json` has been redacted
  and replaced with a placeholder for privacy — replace
  `YOUR_IP_ADDRESS` with your own IP (in CIDR form, e.g. `1.2.3.4/32`)
  before applying this policy to your own bucket.
- Replace `<bucket-name>` in `python_3/permissions.py` with your own
  globally-unique S3 bucket name.
- This project was built as part of an AWS training lab exercise
  (café website scenario) and adapted for personal portfolio use.

## 📝 License

MIT — feel free to reuse for learning purposes.
