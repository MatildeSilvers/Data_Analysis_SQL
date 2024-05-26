--1)¿Qué producto tiene el precio más alto? Devuelva una sola fila

select DISTINCT PRO.Nombre, det.Precio
from DETALLEPEDIDO DET INNER JOIN PRODUCTO PRO
ON DET.Producto=PRO.Codigo
and det.Precio=(select max((Precio/Totalfun)) from DETALLEPEDIDO)


--2)¿Qué cliente ha realizado más pedidos?

select TOP 1 Razon_Social AS Cliente , TotalComprado
from (
	Select cli.Razon_Social, COUNT(Cliente) AS TotalComprado
	from PEDIDOS PED
	inner join CLIENTE cli
	on PED.Cliente=cli.Codigo
	GROUP BY CLI.Razon_Social
	) AS TotalPorCliente
ORDER BY TotalComprado DESC;


--3) Encuentra el día con mayores ingresos.

SELECT TOP 1 Fechaemi AS Dia
FROM (
    SELECT Fechaemi, count(Fechaemi) AS Totaldias
    FROM PEDIDOS
    GROUP BY Fechaemi
) AS TotalPordia
ORDER BY Totaldias DESC;


--4)Encuentre el primer pedido (por fecha) para cada cliente.

SELECT  DISTINCT PED.Fechaemi as Fecha, Razon_Social as Nombre
FROM PEDIDOS PED
JOIN (
    SELECT Cliente, MIN(Fechaemi) AS PrimerFechaPedido, Razon_Social
    FROM PEDIDOS cab
	inner join CLIENTE cli
	on cab.Cliente=cli.Codigo
    GROUP BY Cliente, Razon_Social
) as min_p
ON PED.Cliente = min_p.Cliente AND PED.Fechaemi = min_p.PrimerFechaPedido;


--5)¿Qué producto se ha comprado menos en cantidad?

SELECT TOP 1 PRO.Nombre, SUM(DET.Totalfun) AS TotalVendido
FROM DETALLEPEDIDO DET
INNER JOIN PRODUCTO PRO ON DET.Producto = PRO.Codigo
GROUP BY DET.Producto, PRO.Nombre
ORDER BY TotalVendido ASC;

--6)Para cada pedido, determine si fue "Caro" (en total más de 300), "Asequible" (en total más de 100) o "Barato"
select DET.Codigo AS Pedido, sum(DET.Neto) as Precio,
CASE WHEN SUM(DET.Neto)>300 THEN 'Caro'
	 WHEN SUM(DET.Neto)>100 AND SUM(DET.Neto)<=300 THEN 'Asequible'
		ELSE 'Barato' END AS Segmentacion
from DETALLEPEDIDO DET
	WHERE EXISTS (
		SELECT 1
			FROM PEDIDOS PED
			WHERE DET.Codigo=PED.Codigo)
GROUP BY DET.Codigo, DET.Precio

--7)Encuentre clientes que hayan pedido el producto con el precio más alto.

SELECT CLI.Razon_Social, INV.Nombre ,DET.Precio
FROM DETALLEPEDIDO DET
INNER JOIN PEDIDOS PED
ON DET.Codigo=PED.Codigo
INNER JOIN CLIENTE CLI
ON PED.Cliente=CLI.Codigo
INNER JOIN PRODUCTO INV
ON DET.Producto=INV.Codigo
WHERE DET.Precio=(SELECT MAX(Precio) FROM DETALLEPEDIDO)
