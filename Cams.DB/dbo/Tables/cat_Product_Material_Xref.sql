CREATE TABLE [dbo].[cat_Product_Material_Xref] (
    [ProductMaterialId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [ProductId]         BIGINT   NULL,
    [MaterialId]        BIGINT   NULL,
    [CreatedDate]       DATETIME NULL,
    [CreatedBy]         BIGINT   NULL,
    [UpdatedDate]       DATETIME NULL,
    [UpdatedBy]         BIGINT   NULL,
    CONSTRAINT [PK_cat_Product_Material_Xref] PRIMARY KEY CLUSTERED ([ProductMaterialId] ASC)
);

