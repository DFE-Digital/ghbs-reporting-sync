GRANT CONNECT ON DATABASE __PG_DATABASE__ TO __USERNAME__;
GRANT USAGE ON SCHEMA public TO __USERNAME__;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO __USERNAME__;
REVOKE SELECT ON support_emails FROM __USERNAME__;
REVOKE SELECT ON support_email_attachments FROM __USERNAME__;