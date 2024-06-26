-- ********************************************************************************
-- This script creates the database users and grants them the necessary permissions
-- ********************************************************************************

CREATE USER aquarius_aquatics_owner
WITH PASSWORD 'aquariusaquatics';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO aquarius_aquatics_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO aquarius_aquatics_owner;

CREATE USER aquarius_aquatics_appuser
WITH PASSWORD 'aquariusaquatics';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO aquarius_aquatics_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO aquarius_aquatics_appuser;
