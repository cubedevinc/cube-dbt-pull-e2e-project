-- Minimal model for the Cube Cloud dbt-pull E2E.
--
-- dbt-postgres computes this model's relation_name from the active profile:
--   target.database = "ecom"    (CUBEJS_DB_NAME)
--   target.schema   = "public"  (DBT_DEFAULT_SCHEMA)
--   alias = name    = "users"
-- producing relation_name = "ecom"."public"."users" — which happens to be
-- the real demo-db table path. The generated cube's sql_table therefore
-- points at the actual public.users (700 rows) without us ever
-- materialising this model. dbt compile is enough.
--
-- IMPORTANT: do not write Jinja delimiters ({{, {%, {#) anywhere in this
-- file — even inside SQL comments. dbt runs Jinja before SQL, so a single
-- "{{ source(...) }}" in a comment compiles and errors with
-- "Compilation Error ... unexpected '.'" because "..." is a literal token
-- the Jinja parser then tries to evaluate.
select id, created_at
from public.users
