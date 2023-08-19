CREATE TABLE [dbo].[cat_Machine] (
    [MachineId]     BIGINT          IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (512)  NULL,
    [Code]          NVARCHAR (50)   NULL,
    [Wattage]       DECIMAL (18, 2) NULL,
    [MachineTypeId] INT             NULL,
    [DepartmentId]  INT             NULL,
    [StatusId]      INT             NULL,
    [WorkShopId]    BIGINT          NULL,
    [ImageUrl]      NVARCHAR (255)  NULL,
    [IsActive]      BIT             NULL,
    [IsDeleted]     BIT             NULL,
    [CreatedDate]   DATETIME        NULL,
    [CreatedBy]     BIGINT          NULL,
    [UpdatedDate]   DATETIME        NULL,
    [UpdatedBy]     BIGINT          NULL,
    CONSTRAINT [PK_cat_Machine] PRIMARY KEY CLUSTERED ([MachineId] ASC)
);

