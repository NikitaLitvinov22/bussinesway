# 🔒 Security Policy

## Reporting Security Vulnerabilities

If you discover a security vulnerability in BusinessWay, please **DO NOT** create a public GitHub issue.

Instead, please email: `security@businessway.local` with:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Your recommended fix (if any)

We will acknowledge receipt within 48 hours and work on a fix promptly.

---

## 🏥 Healthcare Data Protection

This project handles sensitive healthcare data (HIPAA, GDPR, Russian Federal Law 152-FZ compliance required).

### Security Requirements

#### 1. **Data in Transit**
- ✅ TLS 1.3+ for all communications
- ✅ Certificate pinning for critical endpoints
- ✅ HSTS headers required
- ✅ No unencrypted HTTP allowed

#### 2. **Data at Rest**
- ✅ AES-256-GCM encryption for PII/PHI
- ✅ Separate encryption keys per patient
- ✅ Encrypted database backups
- ✅ Key rotation every 90 days

#### 3. **Access Control**
- ✅ Role-based access control (RBAC)
- ✅ Multi-factor authentication (MFA) for admins
- ✅ Audit logging for all data access
- ✅ Data access logs retained for 3+ years

#### 4. **API Security**
- ✅ Rate limiting per endpoint
- ✅ Input validation and sanitization
- ✅ SQL injection prevention (parameterized queries)
- ✅ CORS properly configured

#### 5. **Secrets Management**
- ✅ **Never** commit `.env` files
- ✅ Use GitHub Secrets for CI/CD
- ✅ Use external vaults (HashiCorp Vault, AWS Secrets Manager) in production
- ✅ Rotate API keys every 30 days
- ✅ Implement secret versioning

#### 6. **Logging & Monitoring**
- ✅ All authentication attempts logged
- ✅ Failed login attempts trigger alerts
- ✅ Data access logs immutable
- ✅ Real-time alerting for suspicious activity

---

## 🛡️ Development Best Practices

### Before Committing
```bash
# 1. Scan for secrets
git diff --cached | grep -i "password\|api_key\|secret\|token"

# 2. Verify .env files are not staged
git status | grep ".env"

# 3. Run security checks locally
npm run security:check  # or your language equivalent
```

### Environment Setup
```bash
# 1. Copy example template
cp server.env.example server.env

# 2. Fill in YOUR values (never commit this file)
# 3. Add to .gitignore (already done)
```

### Webhook Security
- ✅ Always use `Authorization: Bearer <token>` headers
- ✅ Validate webhook signatures (HMAC-SHA256)
- ✅ Reject unsigned webhooks
- ✅ Implement webhook IP whitelisting when possible

---

## 🔐 GitHub Secrets Setup

Required secrets for CI/CD pipelines:

```
DEPLOY_TOKEN              # For deployment endpoint
DB_PASSWORD               # Database password
DATA_ENCRYPTION_KEY       # Patient data encryption key
CRM_AUTH_TOKEN           # CRM integration token
CALLTOUCH_AUTH_TOKEN     # Calltouch integration token
GITGUARDIAN_API_KEY      # For security scanning
```

**To set up secrets:**
1. Go to: Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add each variable above

---

## 📋 Compliance Checklist

- [ ] HIPAA compliance audit completed
- [ ] GDPR Data Processing Agreement signed
- [ ] Russian data localization verified
- [ ] Encryption keys rotated
- [ ] Security patch updates applied
- [ ] Penetration testing scheduled
- [ ] Incident response plan documented
- [ ] Security training completed by team

---

## 🚨 Incident Response

If a security incident occurs:

1. **Immediate Actions:**
   - Revoke compromised credentials
   - Take affected systems offline if necessary
   - Preserve evidence and logs

2. **Investigation:**
   - Determine scope of breach
   - Identify affected data/users
   - Root cause analysis

3. **Notification:**
   - Notify affected parties within 72 hours (GDPR requirement)
   - File incident report
   - Notify healthcare authorities if required

4. **Recovery:**
   - Deploy patches
   - Restore from clean backups
   - Verify system integrity
   - Update incident documentation

---

## 📚 Additional Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [HIPAA Security Rule](https://www.hhs.gov/hipaa/for-professionals/security/index.html)
- [GDPR Compliance](https://gdpr-info.eu/)
- [Russian Federal Law 152-FZ](https://digital.gov.ru/en/legislation/laws/)

---

**Last Updated:** August 21, 2026
