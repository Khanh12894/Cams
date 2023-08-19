﻿CREATE TABLE [dbo].[cat_ProductGroup] (
    [ProductGroupId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (255) NULL,
    [SortOrder]      INT            NULL,
    [IsDeleted]      BIT            NULL,
    [CreatedDate]    DATETIME       NULL,
    [CreatedBy]      BIGINT         NULL,
    [UpdatedDate]    DATETIME       NULL,
    [UpdatedBy]      BIGINT         NULL,
    CONSTRAINT [PK_cat_ProductGroup] PRIMARY KEY CLUSTERED ([ProductGroupId] ASC)
);
