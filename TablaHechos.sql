create view HechosOrdenes 
as
select
c.CustomerID,
e.EmployeeID,
s.ShipperID,
Orderdate,
count(distinct o.OrderID) as Cantidad,
round(sum(((od.UnitPrice * od.Quantity)-(od.unitPrice * od.Quantity * od.Discount))* 0.15),2)
as impuesto,
round(sum(od.UnitPrice * od.Quantity * od.Discount),2) as Descuento,
o.Freight as [Cargo Envio],
round(sum(od.UnitPrice * od.Quantity),2) as [Sub Total sin Impuesto],
round(sum(((od.UnitPrice * od.Quantity)-(od.UnitPrice * od.Quantity * od.Discount))* 1.15),2)
as Total
from [Order Details] od
inner join Orders o
on o.OrderID = od.OrderID
inner join Employees e
on e.EmployeeID = o.EmployeeID
inner join Customers c
on c.CustomerID = o.CustomerID
inner join Shippers s
on s.ShipperID =o.ShipVia
group by o.Freight, o.OrderId, c.CustomerID,
e.EmployeeID,
s.ShipperID,
Orderdate
select * from HechosOrdenes