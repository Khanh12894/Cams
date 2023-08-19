CREATE TABLE [dbo].[cat_Workshop] (
    [WorkshopId]  INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (255) NULL,
    [Code]        NVARCHAR (50)  NULL,
    [StatusId]    INT            NULL,
    [AssigneeId]  BIGINT         NULL,
    [Note]        NVARCHAR (512) NULL,
    [Address]     NVARCHAR (512) NULL,
    [IsDeleted]   BIT            NULL,
    [CreatedDate] DATETIME       NULL,
    [CreatedBy]   BIGINT         NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   BIGINT         NULL,
    CONSTRAINT [PK_cat_Workshop] PRIMARY KEY CLUSTERED ([WorkshopId] ASC)
);

