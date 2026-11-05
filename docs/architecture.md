# Nordvik Coffee - Architecture Documentation

## Current Architecture (Development)

```
┌─────────────┐
│   Browser   │
└──────┬──────┘
       │ HTTP
       ▼
┌─────────────────────┐
│  S3 Static Website  │
│  (Public HTTP)      │
└─────────────────────┘
       │
       │ Fetch API calls
       ▼
┌─────────────────────┐
│   API Gateway       │
│   (HTTPS)           │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Lambda Function    │
│  (Python 3.12)      │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│    DynamoDB         │
│  (Reviews Table)    │
└─────────────────────┘
```

**Issues**:
- ❌ No HTTPS on website
- ❌ S3 website URL not user-friendly
- ❌ No caching or CDN
- ❌ No security (WAF, rate limiting)
- ❌ No monitoring

---

## Target Architecture (Production)

```
                    ┌─────────────┐
                    │   Browser   │
                    └──────┬──────┘
                           │
                    DNS Query (HTTPS)
                           │
                           ▼
                    ┌─────────────┐
                    │  Route 53   │
                    │  DNS Hosted │
                    │     Zone    │
                    └──────┬──────┘
                           │
                    CNAME to CloudFront
                           │
                           ▼
        ┌──────────────────────────────────────┐
        │         CloudFront CDN               │
        │  ┌─────────────────────────────┐    │
        │  │  ACM Certificate (*.domain) │    │
        │  └─────────────────────────────┘    │
        │                                      │
        │  Edge Locations: Global              │
        │  Cache: Static assets (1hr TTL)      │
        │  Compression: Brotli + Gzip          │
        └──────────┬───────────────────────────┘
                   │
            Protected by
                   │
                   ▼
        ┌──────────────────────┐
        │      AWS WAF         │
        │  ┌────────────────┐  │
        │  │ Core Rule Set  │  │
        │  │ Rate Limiting  │  │
        │  │ Bad Inputs     │  │
        │  └────────────────┘  │
        └──────────┬───────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
   Static Content        API Requests
        │                     │
        ▼                     ▼
┌──────────────┐      ┌──────────────┐
│  S3 Bucket   │      │ API Gateway  │
│  (Private)   │      │  REST API    │
│              │      │              │
│ - index.html │      │ GET /reviews │
│ - assets/    │      │ POST/reviews │
└──────────────┘      └──────┬───────┘
                             │
                      Invoke Lambda
                             │
                             ▼
                    ┌─────────────────┐
                    │ Lambda Function │
                    │  (Python 3.12)  │
                    │                 │
                    │ - Validation    │
                    │ - Rate limiting │
                    │ - Business logic│
                    └────────┬────────┘
                             │
                      Read/Write
                             │
                             ▼
                    ┌─────────────────┐
                    │   DynamoDB      │
                    │ Reviews Table   │
                    │                 │
                    │ - PITR Enabled  │
                    │ - Daily Backups │
                    └─────────────────┘

        ┌───────────────────────────────────┐
        │    Observability & Monitoring     │
        │                                   │
        │  ┌─────────────┐  ┌────────────┐ │
        │  │  X-Ray      │  │ CloudWatch │ │
        │  │  Tracing    │  │  Metrics   │ │
        │  └─────────────┘  └────────────┘ │
        │                                   │
        │  ┌─────────────┐  ┌────────────┐ │
        │  │ CloudWatch  │  │    SNS     │ │
        │  │    Logs     │  │   Alarms   │ │
        │  └─────────────┘  └────────────┘ │
        └───────────────────────────────────┘
```

---

## Component Details

### CloudFront Distribution
**Purpose**: Global content delivery network
**Features**:
- TLS 1.2+ encryption
- HTTP/2 and HTTP/3 support
- Automatic compression
- Edge caching (220+ locations)
- Origin Shield (optional)

**Cache Behaviors**:
1. **Default (/**)**: S3 origin, 1 hour TTL
2. **/reviews**: API Gateway origin, no cache

### AWS WAF (Web Application Firewall)
**Purpose**: Protect against web attacks
**Rules**:
1. **Rate-based**: Max 2000 requests per 5 minutes per IP
2. **Core Rule Set**: SQL injection, XSS, RCE protection
3. **Known Bad Inputs**: Malicious patterns, suspicious user agents

**Actions**:
- Block: Rate limited or malicious requests
- Count: Track but allow (for testing)
- Allow: Legitimate traffic

### Lambda Function
**Runtime**: Python 3.12
**Memory**: 128 MB
**Timeout**: 10 seconds
**Concurrency**: Auto-scaling (max 1000)

**Handlers**:
- `handle_get()`: Fetch all reviews with count and average rating
- `handle_post()`: Validate and save new review

**Environment Variables**:
- `TABLE_NAME`: DynamoDB table name

### DynamoDB Table
**Name**: `nordvik-coffee-reviews`
**Billing**: On-demand (pay per request)
**Key Schema**: `reviewId` (String, partition key)

**Attributes**:
- `reviewId`: UUID
- `name`: String (max 60 chars)
- `comment`: String (max 600 chars)
- `rating`: Number (1-5)
- `createdAt`: ISO 8601 timestamp

**Backup**:
- Point-in-Time Recovery: 35 days
- On-demand backups: 30 day retention

### Monitoring Stack
**CloudWatch Metrics**:
- Lambda: Invocations, Errors, Duration, Throttles
- API Gateway: Count, 4XX, 5XX, Latency
- DynamoDB: Consumed capacity, User errors
- CloudFront: Requests, Bytes, Error rates
- WAF: Blocked/allowed requests

**Alarms**:
1. Lambda errors > 5 in 2 minutes
2. API 5XX errors > 10 in 5 minutes
3. DynamoDB throttles > 5 in 1 minute
4. Lambda p95 duration > 3000ms

**X-Ray Tracing**:
- End-to-end request traces
- Service map visualization
- Performance bottleneck identification

---

## Data Flow

### Website Load (Static Content)
1. User navigates to `https://yourdomain.com`
2. Browser resolves DNS via Route 53
3. Request routed to nearest CloudFront edge
4. CloudFront checks cache
5. If cache miss: Fetch from S3 origin
6. CloudFront caches and returns to user
7. Subsequent requests served from edge cache

**Performance**: <100ms TTFB globally

### Load Reviews (API GET)
1. Browser JavaScript calls `GET /reviews`
2. Request goes through CloudFront to API Gateway
3. WAF checks rate limit and threat patterns
4. API Gateway invokes Lambda
5. Lambda scans DynamoDB table
6. Lambda calculates count and average
7. Returns JSON response
8. X-Ray records trace

**Performance**: <300ms average, <500ms p95

### Submit Review (API POST)
1. User fills form, submits review
2. Browser POSTs to `/reviews`
3. CloudFront forwards to API Gateway (no cache)
4. WAF rate limit check
5. API Gateway invokes Lambda
6. Lambda validates input:
   - Check required fields
   - Validate rating range (1-5)
   - Sanitize for XSS/SQL injection
   - Check length limits
7. If valid: Save to DynamoDB with UUID
8. Return 201 Created with review details
9. Browser refreshes review list

**Performance**: <400ms average, <600ms p95

---

## Security Architecture

### Defense in Depth Layers

**Layer 1: Edge Security (CloudFront + WAF)**
- TLS encryption in transit
- Rate limiting (per-IP)
- OWASP Top 10 protection
- Geographic filtering (optional)

**Layer 2: Network Security**
- S3 bucket: Private, no public access
- API Gateway: HTTPS only
- Lambda: VPC optional (not required for this app)

**Layer 3: Application Security (Lambda)**
- Input validation and sanitization
- HTML tag stripping
- SQL injection pattern detection
- Length limits enforced
- Rate limiting state tracking

**Layer 4: Data Security (DynamoDB)**
- Encryption at rest (AES-256)
- Encryption in transit (TLS)
- IAM role-based access only
- Point-in-time recovery enabled
- Automated backups

**Layer 5: Access Control (IAM)**
- Lambda execution role: Minimal permissions
- DynamoDB: PutItem and Scan only
- CloudWatch Logs: Write only
- Principle of least privilege

---

## High Availability & Disaster Recovery

### Availability
- **CloudFront**: 100% SLA (multi-region edge)
- **API Gateway**: 99.95% SLA (multi-AZ)
- **Lambda**: 99.95% SLA (multi-AZ automatic)
- **DynamoDB**: 99.99% SLA (multi-AZ replication)

**Overall Target**: 99.9% uptime (8.76 hours downtime/year)

### Disaster Recovery Strategies

**RTO (Recovery Time Objective)**: 1 hour
**RPO (Recovery Point Objective)**: 35 days (PITR)

**Failure Scenarios**:

1. **Lambda Function Failure**
   - Detection: CloudWatch alarm (2 min)
   - Response: Auto-rollback via Terraform
   - Recovery: 5-10 minutes

2. **DynamoDB Data Loss**
   - Detection: Data corruption reported
   - Response: Restore from PITR
   - Recovery: 15-30 minutes

3. **S3 Website Corruption**
   - Detection: Website broken or defaced
   - Response: Restore previous version
   - Recovery: 5 minutes

4. **Complete Region Failure**
   - Detection: All alarms firing
   - Response: Manual failover to backup region
   - Recovery: 1-2 hours (requires regional setup)

5. **DDoS Attack**
   - Detection: WAF blocked requests spike
   - Response: AWS Shield Standard (automatic)
   - Recovery: Immediate (automatic scaling)

---

## Scalability

### Current Capacity
- **Requests per second**: ~1000 RPS sustained
- **Concurrent users**: 200-500
- **Storage**: Unlimited (DynamoDB and S3)
- **Geographic**: Global (CloudFront)

### Scaling Characteristics

**Lambda**:
- Auto-scales to 1000 concurrent executions
- Burst capacity: 3000 executions
- Cold start: ~500ms first request
- Warm: ~50ms subsequent requests

**DynamoDB**:
- On-demand mode: Auto-scales infinitely
- Write: 40,000 WCU per table
- Read: 40,000 RCU per table
- Adaptive capacity: Handles hot partitions

**CloudFront**:
- Automatic scaling (AWS managed)
- 220+ edge locations
- Handles traffic spikes automatically

**API Gateway**:
- Default: 10,000 RPS per region
- Burst: 5,000 RPS
- Can request increase via support

### Scaling Triggers
- Lambda: Concurrent execution count
- DynamoDB: Consumed capacity > 80%
- CloudFront: Automatic (no trigger needed)

---

## Cost Breakdown (Monthly Estimates)

**Assumptions**: 100,000 page views, 10,000 reviews submitted

### Compute
- Lambda: $0.20 (0.5M invocations, 128MB, 200ms avg)
- API Gateway: $3.50 (1M requests)

### Storage
- S3 Website: $0.50 (1GB, 50GB transfer)
- DynamoDB: $2.50 (1GB data, on-demand)
- DynamoDB Backups: $0.20 (1GB PITR)

### Networking
- CloudFront: $15.00 (50GB data transfer, US/EU)
- Data transfer out: $4.00 (API Gateway to Lambda)

### Security
- WAF: $5.00 (base) + $1.00 (1M requests)
- ACM Certificate: $0.00 (free)

### Monitoring
- CloudWatch Logs: $1.00 (1GB ingested)
- CloudWatch Alarms: $0.50 (5 alarms)
- X-Ray: $1.00 (0.1M traces)

### Other
- Route 53: $0.50 (1 hosted zone)

**Total**: ~$35/month (light traffic)
**Scaled**: ~$75/month (moderate traffic)

---

**Document Version**: 1.0
**Last Updated**: November 3, 2026
**Author**: Kiro AI Agent
