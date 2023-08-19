CREATE TABLE [dbo].[cat_Customer] (
    [CustomerId]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (255) NULL,
    [Code]            NVARCHAR (50)  NULL,
    [Telephone]       NVARCHAR (50)  NULL,
    [Email]           NVARCHAR (255) NULL,
    [Address]         NVARCHAR (512) NULL,
    [CustomerGroupId] INT            NULL,
    [Note]            NVARCHAR (512) NULL,
    [IsActive]        BIT            NULL,
    [IsDeleted]       BIT            NULL,
    [CreatedDate]     DATETIME       NULL,
    [CreatedBy]       BIGINT         NULL,
    [UpdatedDate]     DATETIME       NULL,
    [UpdatedBy]       BIGINT         NULL,
    CONSTRAINT [PK_cat_Customer] PRIMARY KEY CLUSTERED ([CustomerId] ASC)
);

