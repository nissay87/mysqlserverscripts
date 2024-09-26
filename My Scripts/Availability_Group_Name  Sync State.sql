select db.name as [Database_Name],ag.name as [Availability_Group_Name],ar.replica_server_name as [Replica_Name],rp.secondary_lag_seconds,db.log_reuse_wait_desc,db.log_reuse_wait
,rp.synchronization_state_desc,rp.synchronization_health_desc,ISNULL(rp.database_state_desc,'')as database_state_desc, ISNULL(rp.suspend_reason_desc,'')as [suspend_reason_desc]
,rp.last_sent_time,rp.last_received_time,rp.last_commit_time,rp.last_hardened_time,rp.last_redone_time
--,rp.* 
from sys.dm_hadr_database_replica_states rp 
inner join Sys.databases db on rp.database_id=db.database_id
inner join sys.availability_groups ag on rp.group_id=ag.group_id
inner join sys.availability_replicas ar on rp.replica_id=ar.replica_id
order by rp.secondary_lag_seconds desc
