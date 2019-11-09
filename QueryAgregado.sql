USE Bodega;

SELECT	CONVERT(VARCHAR(50), MIN(A.["idarticulo"])) IdArticulo, 
		MAX(F.["montototal"]) MontoTotal,
		MAX(F.FechaCompra) FechaCompra
FROM dbo.Venta V
INNER JOIN (
			SELECT ["idarticulo"], P.["idproducto"], P.["nombre"], P.["categoriaactivo"], P.["precio"] 
			FROM Articulo A
			INNER JOIN Producto P ON P.["idproducto"] = A.["idproducto"]
			) 
			A ON A.["idarticulo"] = V.["idarticulo"]
INNER JOIN (
			SELECT FA.["idfactura"], U.["nombre"], U.["apellido"], FA.["montototal"], FA.["metodopago"], 
					REPLACE(FA.["fechacompra"], '"', '') AS FechaCompra
			FROM Cliente C
			INNER JOIN (
						SELECT US.["cedula"], US.["nombre"], US.["apellido"] 
						FROM Usuario US
						INNER JOIN Canton CA ON CA.["idcanton"] = US.["idcanton"]
			) 
			U ON U.["cedula"] = C.["cedula"]
			INNER JOIN Factura FA ON FA.["idcliente"] = C.["idcliente"]
			) 
			F ON F.["idfactura"] = V.["idfactura"]
ORDER BY 
(CASE
	WHEN COUNT(F.["idfactura"]) > 100 THEN 'Que buenas ventas!'
	ELSE 'Vamos a quebar!'
END) DESC;
GO