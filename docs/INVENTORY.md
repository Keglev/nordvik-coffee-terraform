# Nordvik Coffee - Project Documentation Inventory

**S3 Bucket**: `nordvik-coffee-project-docs`
**Region**: eu-central-1
**Created**: November 4, 2026
**Last Updated**: November 4, 2026

---

## Bucket Configuration

- ✅ **Versioning**: Enabled (all document versions preserved)
- ✅ **Encryption**: AES-256 server-side encryption
- ✅ **Public Access**: Blocked (private bucket)
- ✅ **Lifecycle Policy**: Old versions archived to Glacier after 90 days

---

## Directory Structure

```
s3://nordvik-coffee-project-docs/
├── docs/                                  # Project documentation
│   ├── README.md                         # Project overview and quick start
│   ├── architecture.md                   # Detailed architecture documentation
│   ├── production-readiness-plan.md      # 20-task implementation plan
│   └── INVENTORY.md                      # This file
│
└── terraform-backup/                      # Infrastructure code backup
    ├── *.tf                              # Terraform configuration files
    ├── terraform.tfstate                 # Current state file
    ├── terraform.tfstate.backup          # Previous state backup
    ├── lambda_src/
    │   └── lambda_function.py           # Lambda function code
    ├── website/
    │   └── index.html.tpl               # Website template
    └── docs/                             # Documentation copies
```

---

## Document Details

### 📋 Project Documentation (`docs/`)

#### README.md (6.6 KB)
- **Purpose**: Project overview, quick links, getting started guide
- **Audience**: All team members, new developers
- **Key Sections**:
  - Project status and current state
  - Quick links to live environments
  - AWS resource inventory
  - Getting started instructions
  - Team contacts

#### architecture.md (13.3 KB)
- **Purpose**: Detailed technical architecture documentation
- **Audience**: Developers, architects, operators
- **Key Sections**:
  - Current vs target architecture diagrams
  - Component details (CloudFront, WAF, Lambda, DynamoDB)
  - Data flow diagrams
  - Security architecture layers
  - High availability and disaster recovery
  - Scalability characteristics
  - Cost breakdown

#### production-readiness-plan.md (8.5 KB)
- **Purpose**: Comprehensive 20-task implementation plan
- **Audience**: Project managers, developers, stakeholders
- **Key Sections**:
  - Executive summary
  - 4-week timeline broken into phases
  - 20 detailed tasks with acceptance criteria
  - Success metrics and risk assessment
  - Technology decisions and rationale

#### INVENTORY.md (This File)
- **Purpose**: Catalog of all files in documentation bucket
- **Audience**: Operators, auditors
- **Content**: File inventory, metadata, access instructions

---

### 🔧 Infrastructure Backup (`terraform-backup/`)

#### Terraform Configuration Files
- `versions.tf` - Provider versions and requirements
- `variables.tf` - Input variables
- `locals.tf` - Local values
- `outputs.tf` - Output values
- `apigateway.tf` - API Gateway configuration
- `dynamodb.tf` - DynamoDB table
- `s3.tf` - S3 website bucket
- `lambda.tf` - Lambda function
- `iam.tf` - IAM roles and policies
- `documentation.tf` - This documentation S3 bucket (self-referencing)

#### State Files
- `terraform.tfstate` - Current infrastructure state (65.5 KB)
- `terraform.tfstate.backup` - Previous state (65.5 KB)
- **WARNING**: These contain resource IDs and should be kept secure

#### Application Code
- `lambda_src/lambda_function.py` - Reviews API handler (3.1 KB)
- `website/index.html.tpl` - Website template (28.2 KB)

---

## Access Instructions

### View Files via AWS Console
1. Navigate to S3 in AWS Console
2. Open bucket: `nordvik-coffee-project-docs`
3. Browse folders and download files as needed

### Download via AWS CLI
```powershell
# Download entire docs folder
aws s3 cp s3://nordvik-coffee-project-docs/docs/ ./docs/ --recursive --profile developer

# Download specific file
aws s3 cp s3://nordvik-coffee-project-docs/docs/README.md ./README.md --profile developer

# List all files
aws s3 ls s3://nordvik-coffee-project-docs/ --recursive --profile developer
```

### View File Versions
```powershell
# List versions of a specific file
aws s3api list-object-versions --bucket nordvik-coffee-project-docs --prefix docs/README.md --profile developer

# Download specific version
aws s3api get-object --bucket nordvik-coffee-project-docs --key docs/README.md --version-id <VERSION_ID> README-old.md --profile developer
```

---

## File Metadata

### docs/README.md
- **Size**: 6,612 bytes
- **Lines**: ~175
- **Format**: Markdown
- **Last Modified**: 2026-11-04 14:11:19
- **Version**: 1.0

### docs/architecture.md
- **Size**: 13,319 bytes  
- **Lines**: ~450
- **Format**: Markdown with ASCII diagrams
- **Last Modified**: 2026-11-04 14:11:19
- **Version**: 1.0
- **Contains**: 
  - 2 architecture diagrams
  - 5 component detail sections
  - Cost breakdown
  - Disaster recovery procedures

### docs/production-readiness-plan.md
- **Size**: 8,496 bytes
- **Lines**: ~280
- **Format**: Markdown
- **Last Modified**: 2026-11-04 14:11:19
- **Version**: 1.0
- **Contains**:
  - 20 implementation tasks
  - 4 phases over 4 weeks
  - Success criteria
  - Risk assessment

### terraform-backup/terraform.tfstate
- **Size**: 65,532 bytes
- **Format**: JSON
- **Last Modified**: 2026-11-04 14:11:27
- **Contains**:
  - 15 managed resources
  - S3 bucket: nordvik-coffee-6d9ceed2
  - DynamoDB table: nordvik-coffee-reviews
  - Lambda: nordvik-coffee-reviews-handler
  - API Gateway: ldcninwmmj
- **Security**: Contains ARNs and IDs - treat as sensitive

---

## Backup Schedule

### Automated Backups
- **S3 Versioning**: Every file change creates new version automatically
- **Lifecycle Policy**: Old versions move to Glacier after 90 days
- **Retention**: Versions kept for 365 days then expired

### Manual Backups
Recommended schedule for Terraform backup updates:
- **Weekly**: After any infrastructure change
- **Before major changes**: Before production deployments
- **After incidents**: Document post-incident state

Update command:
```powershell
aws s3 sync c:\Users\tanja\nordvik-coffee-terraform\ s3://nordvik-coffee-project-docs/terraform-backup/ --exclude ".terraform/*" --exclude "*.zip" --exclude "*.json" --exclude ".git/*" --profile developer
```

---

## Document Maintenance

### When to Update Documents

**README.md** - Update when:
- New team members join
- AWS resources change
- Live environment URLs change
- Contact information changes

**architecture.md** - Update when:
- Architecture changes (new services, removed services)
- Data flow changes
- Security model changes
- Cost structure significantly changes

**production-readiness-plan.md** - Update when:
- Tasks completed (mark with ✅)
- Timeline adjustments needed
- Scope changes
- New requirements discovered

### Version Control
- All documents have version number in footer
- Increment version on significant changes
- Add changelog entry in document
- S3 versioning preserves all previous versions

---

## Related Resources

### AWS Console Links
- S3 Bucket: https://s3.console.aws.amazon.com/s3/buckets/nordvik-coffee-project-docs
- CloudWatch Logs: /aws/lambda/nordvik-coffee-reviews-handler
- DynamoDB: nordvik-coffee-reviews table

### GitHub Repository
- Repository: TBD (add when created)
- Branch: main
- CI/CD: GitHub Actions (planned)

### External Documentation
- AWS S3 Documentation: https://docs.aws.amazon.com/s3/
- Terraform AWS Provider: https://registry.terraform.io/providers/hashicorp/aws/

---

## Audit Trail

| Date | Action | User | Files Affected | Notes |
|------|--------|------|----------------|-------|
| 2026-11-04 | Initial upload | developer | All | Created documentation bucket and uploaded initial docs |
| 2026-11-04 | Terraform backup | developer | terraform-backup/* | First full infrastructure backup |

---

## Notes

- This bucket is NOT part of the Terraform-managed infrastructure (bootstrapped manually)
- Bucket policy restricts access to authorized IAM users only
- Documents should be updated whenever project state changes
- Consider setting up automated backup of this bucket to another region for DR

---

**Document Version**: 1.0
**Last Updated**: November 4, 2026
**Maintained By**: Development Team
**Next Review**: Weekly or after major changes
