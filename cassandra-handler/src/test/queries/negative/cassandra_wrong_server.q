SET hive.support.concurrency=false;

DROP TABLE IF EXISTS cassandra_hive_table;

CREATE EXTERNAL TABLE
cassandra_hive_table(key int, value string)
STORED BY 'org.apache.hadoop.hive.cassandra.CassandraStorageHandler'
WITH SERDEPROPERTIES ("cassandra.cf.name" = "Table" , "cassandra.host" = "127.0.0.2" , "cassandra.port" = "9160", "cassandra.partitioner" = "org.apache.cassandra.dht.RandomPartitioner" )
TBLPROPERTIES ("cassandra.ks.name" = "Hive", "cassandra.ks.repfactor" = "1", "cassandra.ks.strategy" = "org.apache.cassandra.locator.SimpleStrategy");
