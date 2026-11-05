# Nordvik Coffee - Production Readiness Plan

**Project**: Nordvik Coffee Website
**Timeline**: 2-4 weeks
**Priority**: Security → Performance → Operational Excellence
**Status**: Planning Complete, Ready for Implementation

---

## Executive Summary

This plan transforms the Nordvik Coffee website from a development prototype into a production-ready application with:
- Custom domain with HTTPS via CloudFront + ACM
- WAF protection against OWASP Top 10
- Comprehensive monitoring and alerting
- Automated backups and disaster recovery
- CI/CD pipeline for safe deployments
- Staging environment for testing
- Cost controls and optimization

**Estimated Monthly Cost**: $35-75/month
**Target SLA**: 99.9% uptime
**Target Performance**: <500ms API response (p95), <100ms TTFB

---

## Current Architecture

```
User Browser → S3 Static Website (HTTP) → API Gateway (HTTPS) → Lambda → DynamoDB
```

**Current State**:
- ✅ Core functionality working (reviews, static site, API)
- ✅ Infrastructure as Code with Terraform
- ✅ Dynamic review counter from DynamoDB
- ❌ No HTTPS on website
- ❌ No WAF or rate limiting
- ❌ No monitoring or alarms
- ❌ No backups
- ❌ Manual deployment

---

## Target Architecture

```
User Browser → Route53 → CloudFront (HTTPS) → WAF
                              ↓
                    S3 Origin + API Gateway Origin
                              ↓
                    Lambda → DynamoDB (with backups)
                              ↓
                    CloudWatch + X-Ray + SNS Alerts
```

---

## Implementation Plan - 20 Tasks

### Phase 1: Security Foundation (Week 1)

#### Task 1: Enable DynamoDB Backups
- Enable Point-in-Time Recovery (35 days)
- Configure AWS Backup for long-term retention
- Test restore procedures
- **Deliverable**: Protected review data

#### Task 2: Implement Application-Level Security
- Add strict input validation in Lambda
- Implement rate limiting (per-IP)
- Sanitize all user input
- Log all security events
- **Deliverable**: Abuse-resistant API

#### Task 3: Create ACM Certificate
- Request certificate for custom domain
- Add DNS validation records to Route 53
- Wait for validation (5-30 minutes)
- **Deliverable**: Free SSL/TLS certificate

#### Task 4: Deploy AWS WAF
- Create WAF Web ACL with:
  - AWS Core Rule Set (OWASP Top 10)
  - Known Bad Inputs rule set
  - Rate-based rule (2000 req/5min per IP)
- Enable WAF logging
- **Deliverable**: Protected against common attacks

---

### Phase 2: Performance & Delivery (Week 2)

#### Task 5: Deploy CloudFront Distribution
- Configure S3 and API Gateway origins
- Set up cache behaviors
- Enable compression (Brotli/Gzip)
- Attach WAF Web ACL
- Configure SSL certificate
- **Deliverable**: Global CDN with HTTPS

#### Task 6: Configure Custom Domain DNS
- Create Route 53 A records (apex + www)
- Point to CloudFront distribution
- Wait for DNS propagation
- **Deliverable**: https://yourdomain.com live

#### Task 7: Optimize Caching Strategy
- Configure cache policies for static assets
- Set appropriate TTLs
- Enable Origin Shield (optional)
- Add Cache-Control headers to S3 objects
- **Deliverable**: 80%+ cache hit ratio

---

### Phase 3: Monitoring & Observability (Week 2-3)

#### Task 8: Enable X-Ray Tracing
- Enable X-Ray on Lambda and API Gateway
- Add X-Ray SDK to Lambda code
- Create custom segments
- **Deliverable**: End-to-end request tracing

#### Task 9: Create CloudWatch Alarms
- Lambda errors alarm
- API Gateway 5xx errors alarm
- DynamoDB throttling alarm
- Lambda slow response alarm
- Configure SNS email notifications
- **Deliverable**: Automated alerting

#### Task 10: Build Operations Dashboard
- Create CloudWatch dashboard with:
  - API Gateway metrics
  - Lambda performance
  - DynamoDB usage
  - CloudFront traffic
  - WAF activity
- **Deliverable**: Single pane of glass monitoring

#### Task 11: Implement Structured Logging
- Convert Lambda logs to JSON format
- Create CloudWatch Logs Insights queries
- Document common queries
- Set log retention to 30 days
- **Deliverable**: Searchable, analyzable logs

---

### Phase 4: Cost Management (Week 3)

#### Task 12: Configure Budget Alerts
- Create AWS Budget ($50-100/month limit)
- Set notifications at 80%, 100%, 120%
- Configure forecasted spend alerts
- **Deliverable**: Cost overrun protection

#### Task 13: Enable Cost Allocation Tags
- Add consistent tags to all resources
- Enable Cost Allocation Tags in billing
- Create Cost Explorer reports
- Set up weekly cost emails
- **Deliverable**: Cost visibility by component

---

### Phase 5: Staging Environment (Week 3)

#### Task 14: Create Staging Environment
- Duplicate infrastructure with separate resources
- Configure staging.yourdomain.com subdomain
- Set lower resource limits for staging
- Separate state files and configurations
- **Deliverable**: Safe testing environment

---

### Phase 6: CI/CD Pipeline (Week 4)

#### Task 15: GitHub Actions for Infrastructure
- Create Terraform workflow
- Auto-deploy to staging on merge
- Require manual approval for production
- Add plan output to PR comments
- **Deliverable**: Automated infrastructure deployment

#### Task 16: GitHub Actions for Lambda Code
- Create Lambda deployment workflow
- Run tests before deployment
- Deploy to staging, then production with approval
- Add integration tests
- **Deliverable**: Automated code deployment

#### Task 17: Create Automated Tests
- Write unit tests for Lambda functions
- Mock DynamoDB with moto
- Test input validation and error handling
- Achieve 80%+ code coverage
- **Deliverable**: Regression prevention

---

### Phase 7: Final Launch (Week 4)

#### Task 18: Operations Documentation
- Create comprehensive runbook
- Document common issues and solutions
- Emergency procedures
- Architecture documentation
- **Deliverable**: Team can operate independently

#### Task 19: S3 Website Versioning
- Enable versioning on website bucket
- Configure lifecycle policies
- Document rollback procedures
- **Deliverable**: Website file protection

#### Task 20: Load Testing & Launch
- Run load test (200 concurrent users)
- Validate performance under load
- Complete production readiness checklist
- Final go/no-go decision
- **Deliverable**: Production launch

---

## Success Criteria

After implementation, the system will:
- ✅ Serve 99.9% of requests successfully
- ✅ Respond within 500ms (p95 latency)
- ✅ Handle 200+ concurrent users
- ✅ Block malicious traffic automatically
- ✅ Alert on issues within 5 minutes
- ✅ Deploy changes without downtime
- ✅ Recover from any failure within 1 hour
- ✅ Cost less than $100/month

---

## Risk Assessment

**High Risk**:
- DNS propagation delays (mitigated: plan for 24-48 hours)
- Certificate validation issues (mitigated: verify domain ownership first)
- Production deployment breaks site (mitigated: staging environment + approvals)

**Medium Risk**:
- Cost overruns (mitigated: budget alerts + reserved capacity)
- WAF false positives (mitigated: test thoroughly in staging)
- CloudFront cache invalidation needed (mitigated: versioned file names)

**Low Risk**:
- GitHub Actions workflow failures (mitigated: local testing first)
- Team training needs (mitigated: comprehensive runbook)

---

## Next Steps

1. **Approve this plan** - Review and confirm scope
2. **Provide domain name** - For ACM certificate and Route 53
3. **Provide alert email** - For CloudWatch and budget alerts
4. **Begin Task 1** - Start with DynamoDB backups (lowest risk)
5. **Weekly check-ins** - Review progress, adjust as needed

---

## Appendix: Technology Decisions

### Why CloudFront over API Gateway Custom Domain?
- Provides CDN caching for better performance
- Integrates with WAF for security
- Single domain for both static and API content
- Better global latency

### Why AWS Managed WAF Rules?
- Maintained by AWS security team
- Updated automatically for new threats
- Lower cost than building custom rules
- Covers OWASP Top 10

### Why GitHub Actions over CodePipeline?
- More familiar to developers
- Better integration with GitHub PRs
- Easier to debug and customize
- No additional AWS costs

### Why Separate Staging Environment?
- True isolation for testing
- Can test destructive changes safely
- Team can demo features before production
- Matches production architecture exactly

---

**Document Version**: 1.0
**Last Updated**: November 3, 2026
**Author**: Kiro AI Agent
**Status**: Ready for Implementation
