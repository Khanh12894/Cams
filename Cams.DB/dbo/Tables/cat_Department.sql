CREATE TABLE [dbo].[cat_Department] (
    [DepartmentId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (255) NULL,
    [Code]         NVARCHAR (50)  NULL,
    [IsDeleted]    BIT            NULL,
    [CreatedDate]  DATETIME       NULL,
    [CreatedBy]    BIGINT         NULL,
    [UpdatedDate]  DATETIME       NULL,
    [UpdatedBy]    BIGINT         NULL,
    CONSTRAINT [PK_cat_Department] PRIMARY KEY CLUSTERED ([DepartmentId] ASC)
);

