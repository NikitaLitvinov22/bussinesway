# 🔒 SECURITY.md - BusinessWay Security Guidelines

## 🚨 Reporting Security Issues

**DO NOT** open public GitHub issues for security vulnerabilities.

Email: `security@businessway.local` with:
- Vulnerability description
- Steps to reproduce
- Potential impact
- Suggested fix (optional)

Response time: 48 hours max

---

## 🏥 Healthcare Data Protection

This project handles **HIPAA-sensitive healthcare data**.

### Security Requirements

#### 1. Data in Transit
- ✅ TLS 1.3+ mandatory
- ✅ Certificate pinning for APIs
- ✅ HSTS headers enforced
- ✅ No unencrypted HTTP

#### 2. Data at Rest
- ✅ AES-256-GCM encryption for PII/PHI
- ✅ Per-patient encryption keys
- ✅ Encrypted database backups
- ✅ Key rotation every 90 days

#### 3. Access Control
- ✅ Role-Based Access Control (RBAC)
- ✅ Multi-Factor Authentication for admins
- ✅ Audit logging for all data access
- ✅ 3+ year retention for access logs

#### 4. API Security
- ✅ Rate limiting per endpoint
- ✅ Input validation & sanitization
- ✅ Parameterized queries (SQL injection prevention)
- ✅ CORS properly configured

#### 5. Secrets Management
- ✅ **NEVER** commit `.env` files
- ✅ Use GitHub Secrets for CI/CD
- ✅ Use external vaults in production (HashiCorp Vault, AWS Secrets Manager)
- ✅ Rotate API keys every 30 days
- ✅ Implement secret versioning

#### 6. Logging & Monitoring
- ✅ All authentication attempts logged
- ✅ Failed logins trigger alerts
- ✅ Immutable data access logs
- ✅ Real-time anomaly detection

---

## 🛡️ Development Checklist

### Before Every Commit
```bash
# 1. Scan staged changes for secrets
git diff --cached | grep -i "password\|api_key\|secret\|token"

# 2. Verify .env files excluded
git status | grep ".env"

# 3. Run pre-commit hooks (if installed)
pre-commit run --all-files
```

### Local Environment Setup
```bash
# Copy template
cp server.env.example server.env

# Edit with your values (NEVER commit this)
# Ensure it's in .gitignore (already done)
```

### Webhook Security
- ✅ Use `Authorization: Bearer <token>` headers (not URL params)
- ✅ Validate webhook signatures (HMAC-SHA256)
- ✅ Reject unsigned webhooks
- ✅ IP whitelist when possible

---

## 🔐 GitHub Secrets Setup

Required for CI/CD pipelines:

| Secret | Purpose |
|--------|---------|
| `DEPLOY_TOKEN` | Production deployment authorization |
| `DB_PASSWORD` | Database connection |
| `CRM_AUTH_TOKEN` | CRM integration |
| `CALLTOUCH_AUTH_TOKEN` | Calltouch integration |
| `DATA_ENCRYPTION_KEY` | Patient data encryption |

**Setup:** Settings → Secrets and variables → Actions → New repository secret

---

## 📋 Compliance Checklist

- [ ] HIPAA compliance audit scheduled
- [ ] GDPR Data Processing Agreement signed
- [ ] Russian data localization verified
- [ ] Encryption keys generated and stored safely
- [ ] Security patches applied
- [ ] Penetration testing scheduled
- [ ] Incident response plan documented
- [ ] Team security training completed

---

## 🚨 Incident Response Protocol

If a breach occurs:

1. **Immediate (0-1 hour)**
   - Revoke compromised credentials
   - Take affected systems offline if needed
   - Preserve logs and evidence

2. **Investigation (1-24 hours)**
   - Determine breach scope
   - Identify affected data/patients
   - Root cause analysis

3. **Notification (within 72 hours)**
   - Notify affected individuals (GDPR required)
   - File incident reports
   - Notify health authorities if required

4. **Recovery (24+ hours)**
   - Deploy security patches
   - Restore from clean backups
   - Verify system integrity
   - Document lessons learned

---

## 📚 References

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [HIPAA Security Rule](https://www.hhs.gov/hipaa/)
- [GDPR Compliance](https://gdpr-info.eu/)
- [Russian Federal Law 152-FZ](https://digital.gov.ru/en/legislation/laws/)

---

**Last Updated:** August 21, 2026
