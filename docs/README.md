# Nordvik Coffee - Project Documentation

Welcome to the Nordvik Coffee project documentation repository.

## Project Overview

**Nordvik Coffee** is a small-batch artisan coffee roastery website built on AWS infrastructure using Terraform. The site features:
- Static marketing website showcasing coffee products
- Interactive review system with real-time counter
- Customer reviews stored in DynamoDB
- Serverless architecture for cost efficiency and scalability

## Current Status

**Phase**: Development → Production Migration
**Last Updated**: November 3, 2026
**Infrastructure**: AWS (eu-central-1)
**Deployment Method**: Terraform + Manual (moving to CI/CD)

### What's Working
- ✅ Static website hosted on S3
- ✅ Reviews API (GET/POST) via API Gateway + Lambda
- ✅ DynamoDB database for review storage
- ✅ Dynamic review counter (count + average rating)
- ✅ Infrastructure as Code with Terraform

### What's In Progress
- 🔄 Custom domain + HTTPS (CloudFront + ACM)
- 🔄 WAF security layer
- 🔄 Monitoring and alerting
- 🔄 CI/CD pipeline
- 🔄 Staging environment

## Documentation Structure

```
docs/
├── README.md                          # This file - project overview
├── production-readiness-plan.md       # 20-task implementation plan
├── architecture.md                    # Detailed architecture docs
├── runbooks/
│   ├── operations-runbook.md         # Day-to-day operations
│   ├── deployment-guide.md           # How to deploy changes
│   └── disaster-recovery.md          # Emergency procedures
├── reports/
│   ├── load-test-results.md          # Performance testing
│   └── security-audit.md             # Security assessment
└── meeting-notes/
    └── planning-session-2026-11-03.md
```

## Quick Links

### Live Environments
- **Development**: http://nordvik-coffee-6d9ceed2.s3-website.eu-central-1.amazonaws.com
- **Staging**: TBD (will be staging.yourdomain.com)
- **Production**: TBD (will be yourdomain.com)

### AWS Resources
- **S3 Website Bucket**: nordvik-coffee-6d9ceed2
- **DynamoDB Table**: nordvik-coffee-reviews
- **Lambda Function**: nordvik-coffee-reviews-handler
- **API Gateway**: ldcninwmmj (eu-central-1)
- **Region**: eu-central-1 (Frankfurt)

### Monitoring (Coming Soon)
- CloudWatch Dashboard: TBD
- X-Ray Service Map: TBD
- Cost Explorer: AWS Console

## Getting Started

### For Developers

**Prerequisites**:
- Terraform 1.17.1+
- AWS CLI configured with developer profile
- Git for version control

**Local Setup**:
```powershell
# Clone repository
git clone <repository-url>
cd nordvik-coffee-terraform

# Initialize Terraform
terraform init

# View current state
terraform show

# Make changes
# Edit .tf files

# Preview changes
terraform plan

# Apply changes
terraform apply
```

### For Operators

**Daily Operations**:
1. Check CloudWatch Dashboard (link TBD)
2. Review alarm status
3. Monitor costs in AWS Cost Explorer
4. Check for failed deployments in GitHub Actions

**Common Tasks**:
- Deploy code change: Push to main branch (auto-deploys to staging)
- View logs: CloudWatch Logs → /aws/lambda/nordvik-coffee-reviews-handler
- Check metrics: CloudWatch → Dashboards → nordvik-coffee-operations
- View traces: X-Ray → Service Map

## Architecture Summary

**Current (Development)**:
```
Browser → S3 (HTTP) → API Gateway → Lambda → DynamoDB
```

**Target (Production)**:
```
Browser → Route53 → CloudFront (HTTPS) → WAF
                         ↓
          S3 Origin + API Gateway Origin
                         ↓
              Lambda → DynamoDB (backups)
                         ↓
        CloudWatch + X-Ray + SNS Alerts
```

See [architecture.md](architecture.md) for detailed diagrams and component descriptions.

## Implementation Timeline

**Week 1 - Security Foundation**:
- Task 1-4: Backups, input validation, SSL certificate, WAF

**Week 2 - Performance & Monitoring**:
- Task 5-11: CloudFront, DNS, monitoring, logging

**Week 3 - Cost Control & Staging**:
- Task 12-14: Budgets, cost tracking, staging environment

**Week 4 - Automation & Launch**:
- Task 15-20: CI/CD, tests, documentation, load testing

See [production-readiness-plan.md](production-readiness-plan.md) for complete details.

## Key Technologies

- **Infrastructure**: AWS (S3, CloudFront, API Gateway, Lambda, DynamoDB, WAF, CloudWatch)
- **IaC**: Terraform 1.17.1
- **Runtime**: Python 3.12 (Lambda)
- **Frontend**: Vanilla HTML/CSS/JavaScript
- **CI/CD**: GitHub Actions (planned)
- **Monitoring**: CloudWatch + X-Ray
- **Security**: AWS WAF + IAM

## Team & Contacts

**Project Owner**: TBD
**Technical Lead**: TBD
**DevOps**: TBD
**Support Email**: TBD

**On-Call Rotation**: TBD
**Incident Response**: See disaster-recovery.md

## Support & Troubleshooting

### Getting Help
1. Check runbook: `docs/runbooks/operations-runbook.md`
2. Search CloudWatch Logs Insights
3. Review X-Ray traces for errors
4. Check GitHub Issues
5. Contact team via [support channel]

### Reporting Issues
1. Check if it's a known issue (GitHub Issues)
2. Gather diagnostic info:
   - What were you trying to do?
   - What happened instead?
   - When did it happen? (timestamp)
   - Error messages or screenshots
3. Create GitHub Issue with template
4. For critical issues: Page on-call via PagerDuty

## Contributing

**Code Changes**:
1. Create feature branch from `main`
2. Make changes and test locally
3. Create Pull Request
4. Wait for CI checks to pass
5. Request review from team member
6. Merge after approval

**Documentation Changes**:
1. Edit markdown files in `docs/`
2. Create PR with clear description
3. Merge after review

## Security

**Reporting Vulnerabilities**:
- Email: security@yourdomain.com
- Do NOT create public GitHub issues for security concerns

**Security Practices**:
- All secrets in AWS Secrets Manager or GitHub Secrets
- No hardcoded credentials in code
- Regular security audits
- WAF rules reviewed monthly
- Dependency scanning in CI pipeline

## License

[Add license information]

## Changelog

### 2026-11-03
- ✅ Initial infrastructure deployed (S3, API Gateway, Lambda, DynamoDB)
- ✅ Dynamic review counter implemented
- ✅ Project documentation created
- ✅ Production readiness plan finalized

### 2026-11-02
- ✅ Fixed CORS issues
- ✅ Resolved Lambda permission for API Gateway
- ✅ Terraform state established

### 2026-10-29
- ✅ Initial S3 bucket created
- ✅ Basic website deployed

---

**Last Updated**: November 3, 2026
**Document Version**: 1.0
**Maintained By**: Development Team
