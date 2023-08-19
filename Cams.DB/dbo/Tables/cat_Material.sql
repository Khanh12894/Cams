CREATE TABLE [dbo].[cat_Material] (
    [MaterialId]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (255) NULL,
    [Code]        NVARCHAR (50)  NULL,
    [IsActive]    BIT            NULL,
    [Note]        NVARCHAR (512) NULL,
    [IsDeleted]   BIT            NULL,
    [CreatedDate] DATETIME       NULL,
    [CreatedBy]   BIGINT         NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   BIGINT         NULL,
    CONSTRAINT [PK_cat_Material] PRIMARY KEY CLUSTERED ([MaterialId] ASC)
);

