CREATE TABLE [dbo].[cat_ProductionTeam] (
    [ProductionTeamId] BIGINT          IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (255)  NULL,
    [Code]             NVARCHAR (255)  NULL,
    [TotalLabor]       DECIMAL (18, 2) NULL,
    [AssigneeId]       BIGINT          NULL,
    [IsDeleted]        BIT             NULL,
    [CreatedDate]      DATETIME        NULL,
    [CreatedBy]        BIGINT          NULL,
    [UpdatedDate]      DATETIME        NULL,
    [UpdatedBy]        BIGINT          NULL,
    CONSTRAINT [PK_cat_ProductionTeam] PRIMARY KEY CLUSTERED ([ProductionTeamId] ASC)
);

