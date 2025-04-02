DROP extension IF EXISTS pg_cron;
DROP schema IF EXISTS cron;
CREATE extension pg_cron WITH schema extensions;

GRANT usage ON schema cron TO postgres;
GRANT all privileges ON all tables IN schema cron TO postgres;