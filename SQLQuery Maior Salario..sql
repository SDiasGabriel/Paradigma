/** Script para ciração da tabela Colaboradores **/

	USE [Paradigma]
	GO

	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Colaboradores](
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[Nome] [nchar](20) NOT NULL,
		[Salario] [int] NOT NULL,
		[DeptId] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	GO

	ALTER TABLE [dbo].[Colaboradores]  WITH CHECK ADD  CONSTRAINT [FK_Colaboradores_Departamento] FOREIGN KEY([DeptId])
	REFERENCES [dbo].[Departamento] ([ID])
	GO

	ALTER TABLE [dbo].[Colaboradores] CHECK CONSTRAINT [FK_Colaboradores_Departamento]
	GO

/******************************************************/

/** Sript para ciração da Tabela Departamento **/

	USE [Paradigma]
	GO

	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO

	CREATE TABLE [dbo].[Departamento](
		[Nome] [nchar](20) NOT NULL,
		[ID] [int] IDENTITY(1,1) NOT NULL,
	 CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	GO

/****************************************************/

/** Insert de Registro na tabela Colaboradores **/

	USE [Paradigma]
	GO

	INSERT INTO [dbo].[Colaboradores]
			   ([Nome]
			   ,[Salario]
			   ,[DeptId])
		 VALUES
			   ('Joe' ,70000 ,1),
			   ('Henry' ,80000 ,2),
			   ('Sam' ,60000 ,2),
			   ('Max' ,90000 ,1)
	GO

/*****************************************************/


/** Insert de Registro na tabela [Departamento] **/

	USE [Paradigma]
	GO

	INSERT INTO [dbo].[Departamento]
			   (Nome)
		 VALUES
			   ('Vendas'),
			   ('TI')
	GO
	

/******************************************************/


Select D.Nome as Departamento, C.Nome as Pessoa, C.Salario from Colaboradores as C
	left join Departamento as D on (D.Id = C.DeptId) 
where C.Salario = (Select MAX(c2.Salario) From Colaboradores as c2 where c2.DeptId = C.DeptId)



WITH MaiorSalario as (
	Select 
		D.Nome as Departamento, 
		C.Nome as Pessoa, 
		C.Salario,
		RANK() OVER (PARTITION BY  D.Nome ORDER BY C.Salario DESC) as Posicao 		
	from Colaboradores as C
		left join Departamento as D on (D.Id = C.DeptId) 
	)
Select Departamento, Pessoa, Salario from MaiorSalario where (Posicao = 1) 