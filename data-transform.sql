ALTER TABLE support_emails ADD COLUMN IF NOT EXISTS cleaned_unique_body text;

UPDATE support_emails
SET cleaned_unique_body = regexp_replace(
    regexp_replace(
      regexp_replace(
        unique_body,
        '\s*(<[^>]+>|<script.+?<\/script>|<style.+?<\/style>)\s*',' ','gi'),
        '\&[a-z|A-Z|0-9]+\;', ' ', 'gi'),
        '\s+', ' ', 'gi') -- remove excess spaces after above replacements
WHERE cleaned_unique_body IS NULL
