CREATE TABLE [dbo].[cat_CustomerGroup] (
    [CustomerGroupId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (255) NULL,
    [IsDeleted]       BIT            NULL,
    [CreatedDate]     DATETIME       NULL,
    [CreatedBy]       BIGINT         NULL,
    [UpdatedDate]     DATETIME       NULL,
    [UpdatedBy]       BIGINT         NULL,
    CONSTRAINT [PK_cat_CustomerGroup] PRIMARY KEY CLUSTERED ([CustomerGroupId] ASC)
);

