-- -----------------------------------------------------------------------------------
-- File Name    : https://oracle-base.com/dba/monitoring/users.sql
-- Author       : Tim Hall
-- Description  : Displays information about all database users.
-- Requirements : Access to the dba_users view.
-- Call Syntax  : @users [ username | % (for all)]
-- Last Modified: 21-FEB-2005
-- -----------------------------------------------------------------------------------
SET ECHO        OFF
SET FEEDBACK    6
SET HEADING     ON
SET LINESIZE    180
SET PAGESIZE    50000
SET TERMOUT     ON
SET TIMING      OFF
SET TRIMOUT     ON
SET TRIMSPOOL   ON
SET VERIFY      OFF

SET ECHO        OFF
SET FEEDBACK    6
SET HEADING     ON
SET LINESIZE    180
SET PAGESIZE    50000
SET TERMOUT     ON
SET TIMING      OFF
SET TRIMOUT     ON
SET TRIMSPOOL   ON
SET VERIFY      OFF

COLUMN username                    FORMAT A20
COLUMN account_status              FORMAT A16
COLUMN lock_date                   FORMAT A16
COLUMN expiry_date                 FORMAT A16
COLUMN default_tbs                 FORMAT A18
COLUMN temp_tbs                    FORMAT A13
COLUMN created                     FORMAT A16
COLUMN profile                     FORMAT A19
COLUMN consumer_group              FORMAT A20

SELECT username,
       account_status,
       TO_CHAR(lock_date, 'DD/MM/YYYY HH24:MI') AS lock_date,
       TO_CHAR(expiry_date, 'DD/MM/YYYY HH24:MI') AS expiry_date,
       default_tablespace   as default_tbs,
       temporary_tablespace as temp_tbs,
       TO_CHAR(created, 'DD/MM/YYYY HH24:MI') AS created,
       profile,
       SUBSTR(initial_rsrc_consumer_group,1,20) AS consumer_group
FROM   dba_users
ORDER BY account_status, username;

SET VERIFY ON
