CREATE PROCEDURE dbo.CambiarTablaAux2
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRAN
		BEGIN TRY
			UPDATE Administrador
			SET ["inicioadmin"] = GETDATE()
			WHERE ["idadmin"] = ((abs(checksum(NewId()) % 3)) + 1);
		
			UPDATE Empleado
			SET ["fechaingreso"] =GETDATE()
			WHERE ["estado"] = '"Activo"'
		
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END;
GO


CREATE PROCEDURE dbo.CambiarTablaAux
AS
BEGIN 
	SET NOCOUNT ON
	BEGIN TRAN
		BEGIN TRY
			UPDATE Cliente
			SET ["fechainicio"] = GETDATE()
			WHERE ["idcliente"] = ((abs(checksum(NewId()) % 100)) + 1);

			UPDATE Venta
			SET ["precio"] = STR((abs(checksum(NewId()) % 10000)) + 1000)
			WHERE ["idfactura"] = ((abs(checksum(NewId()) % 2000)) + 1);

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH

		BEGIN TRY
        EXEC dbo.CambiarTablaAux2;
		END TRY
		BEGIN CATCH
			PRINT ERROR_MESSAGE();
		END CATCH
END;
GO


CREATE PROCEDURE dbo.CambiarTabla
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRAN
		BEGIN TRY
			UPDATE Articulo
			SET ["fecharegistro"] = GETDATE()
			WHERE ["idarticulo"] = ((abs(checksum(NewId()) % 10000)) + 1);
			
			UPDATE Factura
			SET ["fechacompra"] = GETDATE()
			WHERE ["idfactura"] = ((abs(checksum(NewId()) % 2000)) + 1)

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH

		BEGIN TRY
        EXEC dbo.CambiarTablaAux;
		END TRY
		BEGIN CATCH
			PRINT ERROR_MESSAGE();
		END CATCH
END;
GO

