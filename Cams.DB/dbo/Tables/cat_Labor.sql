CREATE TABLE [dbo].[cat_Labor] (
    [LaborId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (255) NULL,
    [Code]         NVARCHAR (50)  NULL,
    [Gender]       BIT            NULL,
    [BirthDate]    DATETIME2 (7)  NULL,
    [Telephone]    NVARCHAR (50)  NULL,
    [Email]        NVARCHAR (255) NULL,
    [Address]      NVARCHAR (512) NULL,
    [ImageUrl]     NVARCHAR (255) NULL,
    [DepartmentId] INT            NULL,
    [IsDeleted]    BIT            NULL,
    [CreatedDate]  DATETIME       NULL,
    [CreatedBy]    BIGINT         NULL,
    [UpdatedDate]  DATETIME       NULL,
    [UpdatedBy]    BIGINT         NULL,
    CONSTRAINT [PK_cat_Labor] PRIMARY KEY CLUSTERED ([LaborId] ASC)
);

