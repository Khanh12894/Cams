CREATE TABLE [dbo].[cat_Product_Workshop_Xref] (
    [ProductWorkshopId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [ProductId]         BIGINT   NULL,
    [WorkshopId]        BIGINT   NULL,
    [CreatedDate]       DATETIME NULL,
    [CreatedBy]         BIGINT   NULL,
    [UpdatedDate]       DATETIME NULL,
    [UpdatedBy]         BIGINT   NULL,
    CONSTRAINT [PK_cat_Product_Workshop_Xref] PRIMARY KEY CLUSTERED ([ProductWorkshopId] ASC)
);

