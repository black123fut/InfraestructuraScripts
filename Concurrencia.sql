set transaction isolation level read committed
select ["salario"] from Empleado where ["idempleado"]=1





begin tran
update Empleado set ["salario"]=999 where ["idempleado"]=1
waitfor delay '00:00:15'
rollback

set transaction isolation level read uncommitted
select ["salario"] from Emplado where ["idempleado"]=1





set transaction isolation level repeatable read
begin tran
select * from Empleado where ["idempleado"] in(1,2)
waitfor delay '00:00:15'
select * from Emplado where ["idempleado"] in (1,2)
rollback

update Empleado set ["salario"]=999 where ID=1






 set transaction isolation level serializable
 begin tran
 select * from dbo.Empleado
 waitfor delay '00:00:15'
 select * from dbo.Empleado
 rollback

 insert into Empleado(["idempleado"],Name,Salary)
 values( 11,'Stewart',11000)