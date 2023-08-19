CREATE TABLE [dbo].[cat_Warehouse] (
    [WarehouseId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (255) NULL,
    [Code]        NVARCHAR (50)  NULL,
    [Address]     NVARCHAR (512) NULL,
    [DistrictId]  INT            NULL,
    [ProvinceId]  INT            NULL,
    [Note]        NVARCHAR (512) NULL,
    [IsDeleted]   BIT            NULL,
    [CreatedDate] DATETIME       NULL,
    [CreatedBy]   BIGINT         NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   BIGINT         NULL,
    CONSTRAINT [PK_cat_Warehouse] PRIMARY KEY CLUSTERED ([WarehouseId] ASC)
);

