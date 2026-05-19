-- Minimal model for the Cube Cloud dbt-pull E2E.
--
-- dbt-postgres computes the manifest node's `relation_name` from the active
-- profile: target.database = "ecom" (CUBEJS_DB_NAME), target.schema =
-- "public" (DBT_DEFAULT_SCHEMA), alias = name = "users". That produces
-- `relation_name = "ecom"."public"."users"` — which happens to be the actual
-- demo-db table path. The generated cube's `sql_table` therefore points at
-- the real `public.users` (700 rows) without us ever materialising the
-- model. `dbt compile` is enough.
--
-- We read directly from public.users rather than via {{ source(...) }} so
-- there's one fewer file to keep in sync; dbt compile is offline for plain
-- SELECTs, so no connection is required.
select id, created_at
from public.users
