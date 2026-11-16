# Nordvik Coffee ☕ - AWS Cloud Infrastructure

A production-ready serverless website with review functionality, deployed on AWS using Infrastructure as Code (Terraform) and automated CI/CD pipeline.

## 🌐 Live Demo

- **Website**: https://nordvik-coffee.click (custom domain with HTTPS)
- **API Endpoint**: https://ldcninwmmj.execute-api.eu-central-1.amazonaws.com/reviews
- **Documentation Hub**: https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/index.html

## 📋 Project Overview

This project demonstrates a complete cloud infrastructure setup for a coffee shop website with customer review functionality. It showcases modern DevOps practices including:

- **Infrastructure as Code (IaC)** using Terraform
- **Serverless Architecture** on AWS
- **CI/CD Pipeline** with GitHub Actions
- **Security Best Practices** (OIDC authentication, least privilege IAM)
- **Cost Management** with AWS Budgets
- **Disaster Recovery** with automated backups

## 🏗️ Architecture

### Core Components

```
┌─────────────┐
│   User      │
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Route53 DNS                            │
│  - nordvik-coffee.click                 │
│  - www.nordvik-coffee.click             │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  CloudFront Distribution (CDN)          │
│  - HTTPS/TLS 1.2                        │
│  - Global edge locations                │
│  - ACM SSL Certificate                  │
│  - DDoS protection (Shield)             │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  S3 Bucket (Private)                    │
│  - HTML/CSS/JavaScript                  │
│  - Origin Access Control (OAC)          │
└──────┬──────────────────────────────────┘
       │
       │ (Reviews Feature)
       ▼
┌─────────────────────────────────────────┐
│  API Gateway (HTTP API)                 │
│  - POST /reviews (submit review)        │
│  - GET /reviews (fetch stats)           │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  Lambda Function (Python)               │
│  - Process reviews                      │
│  - Calculate statistics                 │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  DynamoDB Table                         │
│  - Store reviews                        │
│  - Point-in-Time Recovery enabled       │
└─────────────────────────────────────────┘
```

### CI/CD Pipeline

```
┌─────────────┐
│  Developer  │
│  (git push) │
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  GitHub Repository                      │
│  - Terraform configuration              │
│  - Lambda source code                   │
└──────┬──────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────┐
│  GitHub Actions Workflow                │
│  - Terraform validation                 │
│  - Terraform plan                       │
│  - Terraform apply                      │
└──────┬──────────────────────────────────┘
       │
       ▼ (OIDC Authentication)
┌─────────────────────────────────────────┐
│  AWS Account                            │
│  - IAM Role assumption                  │
│  - Infrastructure deployment            │
└─────────────────────────────────────────┘
```

## 🛠️ Technology Stack

- **Cloud Provider**: AWS (Amazon Web Services)
- **Infrastructure as Code**: Terraform (v1.5.0+)
- **Programming Language**: Python 3.12 (Lambda)
- **Frontend**: HTML, CSS, JavaScript
- **CI/CD**: GitHub Actions
- **Authentication**: AWS OIDC (OpenID Connect)
- **Region**: eu-central-1 (Frankfurt)

## 📁 Project Structure

```
nordvik-coffee-terraform/
├── .github/
│   └── workflows/
│       └── terraform.yml          # GitHub Actions CI/CD workflow
├── docs/                          # Project documentation
│   ├── index.html                 # Documentation hub
│   ├── README.md                  # Main documentation
│   ├── architecture.md            # Architecture details
│   └── production-readiness-plan.md
├── lambda_src/
│   └── lambda_function.py         # Lambda function code
├── website/
│   └── index.html.tpl             # Website template
├── acm.tf                         # ACM SSL certificate
├── apigateway.tf                  # API Gateway configuration
├── budgets.tf                     # AWS Budget alerts
├── cloudfront.tf                  # CloudFront CDN distribution
├── documentation.tf               # Documentation S3 bucket
├── dynamodb.tf                    # DynamoDB table
├── github-oidc.tf                 # GitHub OIDC integration
├── iam.tf                         # IAM roles and policies
├── lambda.tf                      # Lambda function
├── locals.tf                      # Local variables
├── outputs.tf                     # Terraform outputs
├── route53.tf                     # DNS configuration
├── s3.tf                          # S3 website bucket
├── variables.tf                   # Input variables
├── versions.tf                    # Provider versions
└── README.md                      # This file
```

## 🚀 Quick Start

### Prerequisites

- AWS Account with appropriate permissions
- AWS CLI configured (`aws login`)
- Terraform >= 1.5.0 installed
- Git installed

### Local Deployment

1. **Clone the repository**
   ```bash
   git clone https://github.com/TanjaNY/nordvik-coffee-terraform.git
   cd nordvik-coffee-terraform
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review the plan**
   ```bash
   terraform plan
   ```

4. **Apply the infrastructure**
   ```bash
   terraform apply
   ```

5. **Get the website URL**
   ```bash
   terraform output website_url
   ```

### Automated Deployment (CI/CD)

Every push to the `main` branch automatically:
1. ✅ Validates Terraform configuration
2. ✅ Runs `terraform plan`
3. ✅ Applies changes to AWS infrastructure

**No manual intervention required!**

## 🔐 Security Features

### HTTPS/TLS
- SSL certificate from AWS Certificate Manager (ACM)
- TLS 1.2 minimum (modern security standards)
- Automatic HTTP to HTTPS redirect
- Custom domain with secure DNS (DNSSEC-ready)

### CloudFront Security
- Origin Access Control (OAC) - S3 bucket is private
- AWS Shield Standard (DDoS protection) included
- WAF-ready (Web Application Firewall can be added)
- Geo-restriction capabilities

### OIDC Authentication
- GitHub Actions uses OIDC (OpenID Connect) to authenticate with AWS
- No long-lived AWS credentials stored in GitHub
- Temporary credentials generated per workflow run
- Credentials automatically expire after use

### IAM Least Privilege
- Separate IAM roles for different services
- Lambda has minimal permissions (DynamoDB access only)
- GitHub Actions role limited to infrastructure management

### Data Protection
- DynamoDB Point-in-Time Recovery (35 days)
- S3 versioning enabled for documentation
- Encryption at rest for all data

## 💰 Cost Management

### Current Monthly Budget: $75 USD

**Alerts configured at:**
- 80% ($60) - Warning
- 100% ($75) - Budget exceeded
- 120% ($90) - Critical
- 80% forecasted - Early warning

**Current spend:** ~$3.57/month  
**Forecasted spend:** ~$19/month

### Cost Breakdown (Estimated)
- CloudFront: ~$1.00/month (data transfer)
- S3: ~$0.50/month
- Lambda: ~$0.20/month (within free tier)
- DynamoDB: ~$0.00 (within free tier)
- API Gateway: ~$1.00/month
- Route53: ~$0.50/month (hosted zone)
- ACM Certificate: Free

## 📊 Monitoring & Operations

### AWS Resources Created

| Resource | Name/ID | Purpose |
|----------|---------|---------|
| Route53 Hosted Zone | `nordvik-coffee.click` | DNS management |
| CloudFront Distribution | (Auto-generated) | CDN and HTTPS |
| ACM Certificate | `*.nordvik-coffee.click` | SSL/TLS certificate |
| S3 Bucket (Website) | `nordvik-coffee-6d9ceed2` | Static website hosting |
| S3 Bucket (Docs) | `nordvik-coffee-project-docs` | Documentation storage |
| DynamoDB Table | `nordvik-coffee-reviews` | Review data storage |
| Lambda Function | `nordvik-coffee-reviews-handler` | API logic |
| API Gateway | `ldcninwmmj` | REST API endpoint |
| IAM Role (Lambda) | `nordvik-coffee-reviews-lambda-role` | Lambda execution |
| IAM Role (GitHub) | `nordvik-coffee-github-actions-role` | CI/CD authentication |
| Budget | `nordvik-coffee-monthly-budget` | Cost monitoring |

### Health Checks

```bash
# Check website is accessible (HTTPS)
curl -I https://nordvik-coffee.click

# Check CloudFront distribution
aws cloudfront list-distributions --query "DistributionList.Items[?contains(Aliases.Items, 'nordvik-coffee.click')].{Id:Id,Status:Status,DomainName:DomainName}"

# Check API is working
curl https://ldcninwmmj.execute-api.eu-central-1.amazonaws.com/reviews

# Check Lambda logs
aws logs tail /aws/lambda/nordvik-coffee-reviews-handler --follow

# Check DynamoDB table status
aws dynamodb describe-table --table-name nordvik-coffee-reviews

# Check SSL certificate status
aws acm list-certificates --region us-east-1 --query "CertificateSummaryList[?DomainName=='nordvik-coffee.click']"
```

## 🔄 Making Changes

### Modify Infrastructure

1. Edit the relevant `.tf` file
2. Commit and push to GitHub:
   ```bash
   git add .
   git commit -m "Description of changes"
   git push
   ```
3. GitHub Actions automatically applies changes

### Update Lambda Function

1. Edit `lambda_src/lambda_function.py`
2. Commit and push - automatic deployment via CI/CD

### Update Website

1. Edit `website/index.html.tpl`
2. Commit and push - automatic deployment via CI/CD

## 🐛 Troubleshooting

### Common Issues

**Problem**: GitHub Actions fails with "Not authorized to perform sts:AssumeRoleWithWebIdentity"
- **Solution**: Check that the IAM role trust policy includes your GitHub repository

**Problem**: CloudFront distribution shows old content
- **Solution**: Invalidate CloudFront cache: `aws cloudfront create-invalidation --distribution-id <ID> --paths "/*"`

**Problem**: SSL certificate not validating
- **Solution**: Check Route53 CNAME records for certificate validation

**Problem**: Website returns 403 Forbidden
- **Solution**: Verify S3 bucket policy allows CloudFront OAC access

**Problem**: Lambda function fails
- **Solution**: Check CloudWatch Logs: `/aws/lambda/nordvik-coffee-reviews-handler`

**Problem**: DynamoDB access denied
- **Solution**: Verify Lambda IAM role has `dynamodb:PutItem` and `dynamodb:Scan` permissions

### Getting Help

1. Check CloudWatch Logs for Lambda errors
2. Review GitHub Actions workflow logs
3. Use AWS CloudFormation drift detection
4. Check Terraform state: `terraform show`

## 📚 Learning Resources

- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AWS Lambda Best Practices](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)

## 🎓 For Students

This project is designed as an educational example of:
- Modern cloud architecture patterns
- Infrastructure as Code best practices
- DevOps and CI/CD pipelines
- AWS serverless technologies
- Security and cost optimization

### Learning Objectives

1. **Understand serverless architecture** - See how S3, Lambda, API Gateway, and DynamoDB work together
2. **Learn Infrastructure as Code** - Study Terraform configuration and best practices
3. **Practice DevOps** - Explore CI/CD pipelines with GitHub Actions
4. **Security awareness** - Examine IAM roles, OIDC authentication, and least privilege
5. **Cost management** - Understand AWS billing and budget monitoring

## 📝 License

Educational project for demonstration purposes.

## 👥 Contributors

- Tanja Nyberg (@TanjaNY) - Project Owner
- Kiro AI - Development Assistant

## 🔗 Additional Resources

- **Full Documentation**: https://nordvik-coffee-project-docs.s3.eu-central-1.amazonaws.com/docs/index.html
- **Architecture Details**: See `docs/architecture.md`
- **Production Readiness Plan**: See `docs/production-readiness-plan.md`
- **Setup Guide**: See `SETUP.md`

---

**Last Updated**: November 2026  
**Region**: eu-central-1 (Frankfurt)
