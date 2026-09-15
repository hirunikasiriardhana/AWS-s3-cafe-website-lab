#!/bin/bash
# Run this INSIDE your lab's VS Code IDE terminal, from
# /home/ec2-user/environment, to assemble the full repo (including your
# real website assets) and push it to GitHub.
#
# Usage:
#   1. Place this script (and the README.md, .gitignore,
#      website_security_policy.json, python_3/permissions.py from this
#      downloaded repo) into /home/ec2-user/environment/aws-s3-cafe-website/
#   2. Edit GITHUB_USERNAME and REPO_NAME below.
#   3. Run: bash setup-repo.sh

set -e

GITHUB_USERNAME="your-github-username"
REPO_NAME="aws-s3-cafe-website"
LAB_DIR="/home/ec2-user/environment"
PROJECT_DIR="$LAB_DIR/$REPO_NAME"

echo "Copying website assets from lab resources..."
mkdir -p "$PROJECT_DIR/website"
cp -r "$LAB_DIR/resources/website/"* "$PROJECT_DIR/website/"

echo "Redacting IP address in policy file (edit manually if needed)..."
# sed -i 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\/32/YOUR_IP_ADDRESS\/32/' \
#   "$PROJECT_DIR/website_security_policy.json"

cd "$PROJECT_DIR"
git init
git add .
git commit -m "Initial commit: AWS S3 café website hosting project"
git branch -M main
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

echo ""
echo "Repo assembled at $PROJECT_DIR"
echo "Review website_security_policy.json to confirm your real IP is redacted,"
echo "then run:"
echo "  git push -u origin main"
echo "(You'll be prompted for your GitHub username and a Personal Access Token as the password.)"
