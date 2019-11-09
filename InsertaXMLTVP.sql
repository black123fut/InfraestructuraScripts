USE Bodega;

-- <?xml version="1.0" standalone="yes"?>
-- <Proveedor>
-- <nombre>TuttosSA</nombre>
-- <telefono>2555123</telefono>
-- <juridica>332232154</juridica>
-- <detalledireccion>A la par de la iglesia</detalledireccion>
-- <idcanton>5Tva</idcanton>
-- </Proveedor>

CREATE PROCEDURE dbo.InsertarRegistroXML
			@Info XML
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO Proveedor(["idproveedor"], ["nombre"], ["telefono"], ["cedulajuridica"], ["detalledireccion"], ["idcanton"])
	SELECT
	6,
		prove.value('(nombre)[1]', 'VARCHAR(50)') as ["nombre"],
		prove.value('(telefono)[1]', 'VARCHAR(50)') as ["telefono"],
		prove.value('(juridica)[1]', 'VARCHAR(50)') as ["cedulajuridica"],
		prove.value('(detalledireccion)[1]', 'VARCHAR(50)') as ["detalledireccion"],
		prove.value('(idcanton)[1]', 'VARCHAR(50)') as ["idcanton"]
	FROM @Info.nodes('/Proveedor') as TEMPTABLE(prove)
END 
GO

EXEC dbo.InsertarRegistroXML
		@Info = N'<?xml version="1.0" standalone="yes"?><Proveedor><nombre>TuttosSA</nombre><telefono>2555123</telefono><juridica>332232154</juridica><detalledireccion>A la par de la iglesia</detalledireccion><idcanton>5</idcanton></Proveedor>';


CREATE TYPE PaisType AS TABLE(
	Nombre VARCHAR(50)
);
GO

CREATE PROCEDURE InsertarRegistroTVP
		@Info PaisType READONLY
	AS
	SET NOCOUNT ON
	INSERT INTO Pais(["idpais"], ["nombre"])
	SELECT 3, Nombre FROM @Info;
GO

DECLARE @PaisTVP AS PaisType;
INSERT INTO @PaisTVP (Nombre)
VALUES ('USA');

EXECUTE InsertarRegistroTVP
		@PaisTVP;

SELECT * FROM Pais;