set hive.stats.dbclass=fs;
set hive.fetch.task.conversion=none;

-- EXCLUDE_OS_WINDOWS
-- SORT_QUERY_RESULTS

-- test automatic use of index on table with partitions
CREATE INDEX src_part_index ON TABLE srcpart(key) as 'BITMAP' WITH DEFERRED REBUILD;
ALTER INDEX src_part_index ON srcpart REBUILD;

SET hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;
SET hive.optimize.index.filter=true;

EXPLAIN SELECT key, value FROM srcpart WHERE key=86 AND ds='2008-04-09';
SELECT key, value FROM srcpart WHERE key=86 AND ds='2008-04-09';

DROP INDEX src_part_index ON srcpart;
