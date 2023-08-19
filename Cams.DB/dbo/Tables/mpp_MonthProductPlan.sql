CREATE TABLE [dbo].[mpp_MonthProductPlan] (
    [MonthProductionPanId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]                 NVARCHAR (255) NULL,
    [Code]                 NVARCHAR (50)  NULL,
    [Month]                INT            NULL,
    [Year]                 INT            NULL,
    [AdjustCount]          INT            NULL,
    [IsDeleted]            BIT            NULL,
    [CreatedDate]          DATETIME       NULL,
    [CreatedBy]            BIGINT         NULL,
    [UpdatedDate]          DATETIME       NULL,
    [UpdatedBy]            BIGINT         NULL,
    CONSTRAINT [PK_mpp_MonthProductPlan] PRIMARY KEY CLUSTERED ([MonthProductionPanId] ASC)
);

