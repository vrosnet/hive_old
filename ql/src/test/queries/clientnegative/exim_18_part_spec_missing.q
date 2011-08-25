set hive.test.mode=true;
set hive.test.mode.prefix=;

create table exim_employee ( emp_id int comment "employee id") 	
	comment "employee table"
	partitioned by (emp_country string comment "two char iso code", emp_state string comment "free text")
	stored as textfile	
	tblproperties("creator"="krishna");
load data local inpath "../data/files/test.dat" 
	into table exim_employee partition (emp_country="in", emp_state="tn");	
load data local inpath "../data/files/test.dat" 
	into table exim_employee partition (emp_country="in", emp_state="ka");	
load data local inpath "../data/files/test.dat" 
	into table exim_employee partition (emp_country="us", emp_state="tn");	
load data local inpath "../data/files/test.dat" 
	into table exim_employee partition (emp_country="us", emp_state="ka");		
!rm -rf ../build/ql/test/data/exports/exim_employee;
export table exim_employee to 'ql/test/data/exports/exim_employee';
drop table exim_employee;

create database importer;
use importer;
import table exim_employee partition (emp_country="us", emp_state="kl") from 'ql/test/data/exports/exim_employee';
describe extended exim_employee;
select * from exim_employee;
drop table exim_employee;
!rm -rf ../build/ql/test/data/exports/exim_employee;

drop database importer;