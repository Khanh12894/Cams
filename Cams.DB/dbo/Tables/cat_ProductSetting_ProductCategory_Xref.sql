CREATE TABLE [dbo].[cat_ProductSetting_ProductCategory_Xref] (
    [ProductSettingProductCategoryId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [ProductSettingId]                BIGINT   NULL,
    [ProductCategoryId]               INT      NULL,
    [SortOrder]                       INT      NULL,
    [CreatedDate]                     DATETIME NULL,
    [CreatedBy]                       BIGINT   NULL,
    [UpdatedDate]                     DATETIME NULL,
    [UpdatedBy]                       BIGINT   NULL,
    CONSTRAINT [PK_cat_ProductSetting_ProductCategory_Xref] PRIMARY KEY CLUSTERED ([ProductSettingProductCategoryId] ASC)
);

