-- **************************************************************
-- This script destroys the database and associated users
-- **************************************************************

-- The following line terminates any active connections to the database so that it can be destroyed
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'aquarius_aquatics';

DROP DATABASE aquarius_aquatics;

DROP USER aquarius_aquatics_owner;
DROP USER aquarius_aquatics_appuser;
