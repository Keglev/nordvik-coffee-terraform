# Nordvik Coffee - Public Documentation Links

**Bucket**: `nordvik-coffee-project-docs`
**Region**: eu-central-1
**Access**: Public (read-only)
**Last Updated**: November 4, 2026

---

## 📚 Project Documentation

All project documentation is now publicly accessible via direct S3 URLs.

### Core Documents

#### 1️⃣ Project Overview & Quick Start
**README.md** - Your starting point for understanding the project

🔗 **Link**: https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/README.md

**Contains**:
- Project status and current state
- Quick links to live environments
- AWS resource inventory
- Getting started guide for developers
- Team contacts

**Size**: 6.6 KB | **Format**: Markdown

---

#### 2️⃣ Technical Architecture Documentation
**architecture.md** - Complete technical deep-dive

🔗 **Link**: https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/architecture.md

**Contains**:
- Current vs target architecture diagrams
- Detailed component specifications (CloudFront, WAF, Lambda, DynamoDB)
- Data flow diagrams for each request type
- Security architecture (5-layer defense in depth)
- High availability and disaster recovery procedures
- Scalability characteristics and capacity planning
- Monthly cost breakdown by service

**Size**: 13.3 KB | **Format**: Markdown with ASCII diagrams

---

#### 3️⃣ Production Readiness Implementation Plan
**production-readiness-plan.md** - Your 4-week roadmap to production

🔗 **Link**: https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/production-readiness-plan.md

**Contains**:
- Executive summary with goals and timeline
- 20 detailed tasks organized in 4 phases:
  - **Week 1**: Security Foundation (DynamoDB backups, WAF, SSL)
  - **Week 2**: Performance & Monitoring (CloudFront, X-Ray, alarms)
  - **Week 3**: Cost Control & Staging (Budgets, staging environment)
  - **Week 4**: CI/CD & Launch (GitHub Actions, tests, load testing)
- Each task includes implementation steps, acceptance criteria, and tests
- Success metrics and risk assessment
- Technology decisions and rationale

**Size**: 8.5 KB | **Format**: Markdown

---

#### 4️⃣ File Catalog & Inventory
**INVENTORY.md** - Complete catalog of all files in the bucket

🔗 **Link**: https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/INVENTORY.md

**Contains**:
- Bucket configuration details
- Directory structure
- File metadata (sizes, versions, modification dates)
- Access instructions (Console and CLI)
- Backup schedule and maintenance procedures
- Audit trail

**Size**: 8.5 KB | **Format**: Markdown

---

## 🔧 Infrastructure Backup Files

Complete Terraform infrastructure code is also publicly accessible.

### Terraform Configuration Files

Base URL: `https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/`

| File | Purpose | Link |
|------|---------|------|
| **versions.tf** | Provider versions | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/versions.tf) |
| **variables.tf** | Input variables | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/variables.tf) |
| **locals.tf** | Local values | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/locals.tf) |
| **outputs.tf** | Output values | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/outputs.tf) |
| **apigateway.tf** | API Gateway config | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/apigateway.tf) |
| **dynamodb.tf** | DynamoDB table | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/dynamodb.tf) |
| **s3.tf** | S3 website bucket | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/s3.tf) |
| **lambda.tf** | Lambda function | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/lambda.tf) |
| **iam.tf** | IAM roles & policies | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/iam.tf) |
| **documentation.tf** | This docs bucket | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/documentation.tf) |

### Application Code

| File | Purpose | Link |
|------|---------|------|
| **lambda_function.py** | Reviews API Lambda handler | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/lambda_src/lambda_function.py) |
| **index.html.tpl** | Website template | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/website/index.html.tpl) |

### State Files

⚠️ **WARNING**: State files contain resource IDs and ARNs

| File | Purpose | Link |
|------|---------|------|
| **terraform.tfstate** | Current infrastructure state | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/terraform.tfstate) |
| **terraform.tfstate.backup** | Previous state backup | [View](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/terraform.tfstate.backup) |

---

## 📥 Download Instructions

### Download Individual Files

Click any link above to view in browser, or use `curl`/`wget`:

```bash
# Download README
curl -O https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/README.md

# Download architecture docs
wget https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/architecture.md
```

### Download All Documentation

```powershell
# Using AWS CLI
aws s3 cp s3://nordvik-coffee-project-docs/docs/ ./docs/ --recursive --no-sign-request

# Using curl (individual files)
curl -O https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/README.md
curl -O https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/architecture.md
curl -O https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/production-readiness-plan.md
curl -O https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/INVENTORY.md
```

---

## 🌐 Share These Links

You can share these direct links with:
- ✅ Team members
- ✅ Stakeholders
- ✅ External consultants
- ✅ Anyone who needs access to project documentation

**No AWS account or authentication required!**

---

## 📱 Quick Access URLs

### For Quick Reference (Copy & Paste)

**Main Documentation**:
```
README:
https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/README.md

Architecture:
https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/architecture.md

Implementation Plan:
https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/production-readiness-plan.md

Inventory:
https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/INVENTORY.md
```

**Infrastructure Code**:
```
Lambda Function:
https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/lambda_src/lambda_function.py

Website Template:
https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/website/index.html.tpl

Terraform State:
https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/terraform-backup/terraform.tfstate
```

---

## 🔐 Security Note

**What's Public**:
- ✅ Documentation (README, architecture, plans)
- ✅ Terraform configuration files
- ✅ Application code (Lambda, website template)
- ✅ Infrastructure state files

**What's NOT Public**:
- ❌ AWS credentials or secrets
- ❌ Database contents (DynamoDB)
- ❌ User data or reviews
- ❌ Private customer information

The state files contain resource ARNs and IDs but no sensitive credentials. However, they do reveal your infrastructure topology.

---

## 📊 Usage Statistics

| Category | Files | Total Size |
|----------|-------|------------|
| Documentation | 4 files | 36.7 KB |
| Terraform Config | 11 files | ~15 KB |
| State Files | 2 files | 131 KB |
| Application Code | 2 files | 31 KB |
| **TOTAL** | **19 files** | **~215 KB** |

---

## 🔄 Updates

This document and all linked files are versioned in S3. If you see outdated information:
1. Check the "Last Modified" timestamp in the browser/curl response
2. Force refresh your browser (Ctrl+F5)
3. Re-download the file

**Versioning**: All files have versioning enabled - previous versions are preserved.

---

## ❓ Questions or Issues?

If you have trouble accessing any links:
1. Check your internet connection
2. Try a different browser
3. Verify the URL is copied correctly
4. Contact the project team

---

## 📝 Document Recommendations

**For New Team Members**: Start with [README.md](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/README.md)

**For Architects/Developers**: Review [architecture.md](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/architecture.md)

**For Project Managers**: Check [production-readiness-plan.md](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/production-readiness-plan.md)

**For Operations**: Refer to [INVENTORY.md](https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/INVENTORY.md)

---

**Bucket**: nordvik-coffee-project-docs
**Region**: eu-central-1 (Frankfurt)
**Access Level**: Public Read
**Last Updated**: November 4, 2026
**Maintained By**: Development Team
