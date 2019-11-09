USE Bodega;

CREATE PROCEDURE dbo.InsertarClienteEmpBodega
		@Cedula INT,
		@Nombre VARCHAR(50),
		@Apellido VARCHAR(50),
		@Telefono VARCHAR(50),
		@Email VARCHAR(50),
		@DetalleDireccion VARCHAR(50),
		@FechaNacimiento VARCHAR(50),
		@CodigoEmpleado VARCHAR(50),
		@Puesto VARCHAR(50),
		@Salario VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO Usuario 
			VALUES
			(@Cedula, @Nombre, @Apellido, GETDATE(), @Telefono, @Email, @DetalleDireccion, @FechaNacimiento, (abs(checksum(NewId()) % 82)) + 1);

			INSERT INTO Empleado (["cedula"], ["codigoempleado"], ["estado"], ["fechaingreso"], ["numventas"], ["puesto"] ,["salario"])
			VALUES
			(@Cedula, @CodigoEmpleado, 'Activo', GETDATE(), '0', @Puesto, @Salario);

			DECLARE @idEmp int
            SET @idEmp = SCOPE_IDENTITY()

			INSERT INTO EmpleadoBodega (IdEmpleado)
			VALUES
			(@idEmp)

			INSERT INTO Cliente(["cedula"], ["puntos"], ["fechainicio"], ["fechaexpiracion"])
			VALUES
			(@Cedula, '0', GETDATE(), GETDATE())

			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
    END CATCH
END
GO


EXEC dbo.InsertarClienteEmpBodega
			@Cedula = 323245332,
			@Nombre = 'Jorge',
			@Apellido = 'Piedra',
			@Telefono = '24536575',
			@Email = 'jorgepiedra@gmail.com',
			@DetalleDireccion = 'A la par de la iglesia',
			@FechaNacimiento = '14 Nov 98',
			@CodigoEmpleado = 'RTE-3443',
			@Puesto = 'Empleado de la bodega',
			@Salario = '70000';
GO

