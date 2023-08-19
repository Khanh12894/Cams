CREATE TABLE [dbo].[cat_ProductSetting] (
    [ProductSettingId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [ProductId]        BIGINT          NULL,
    [ProductRefId]     BIGINT          NULL,
    [UnitId]           INT             NULL,
    [MaterialId]       BIGINT          NULL,
    [WorkflowId]       BIGINT          NULL,
    [MachineId]        BIGINT          NULL,
    [Quantity]         DECIMAL (18, 2) NULL,
    [ProductionTeamId] BIGINT          NULL,
    [MoldChangeTime]   DECIMAL (18, 2) NULL,
    [ParentId]         BIGINT          NULL,
    [IsDeleted]        BIT             NULL,
    [CreatedDate]      DATETIME        NULL,
    [CreatedBy]        BIGINT          NULL,
    [UpdatedDate]      DATETIME        NULL,
    [UpdatedBy]        BIGINT          NULL,
    CONSTRAINT [PK_cat_ProductSetting] PRIMARY KEY CLUSTERED ([ProductSettingId] ASC)
);





