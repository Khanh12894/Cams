CREATE TABLE [dbo].[cat_Product] (
    [ProductId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (512) NULL,
    [Code]           NVARCHAR (50)  NULL,
    [Signed]         NVARCHAR (50)  NULL,
    [ProductTypeId]  INT            NULL,
    [ProductGroupId] INT            NULL,
    [AssigneeId]     BIGINT         NULL,
    [ProductUnitId]  INT            NULL,
    [IsDeleted]      BIT            NULL,
    [CreatedDate]    DATETIME       NULL,
    [CreatedBy]      BIGINT         NULL,
    [UpdatedDate]    DATETIME       NULL,
    [UpdatedBy]      BIGINT         NULL,
    CONSTRAINT [PK_cat_Product] PRIMARY KEY CLUSTERED ([ProductId] ASC)
);



