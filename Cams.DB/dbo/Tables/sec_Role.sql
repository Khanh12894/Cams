CREATE TABLE [dbo].[sec_Role] (
    [RoleId]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (255) NULL,
    [NormalizedName]   NVARCHAR (255) NULL,
    [ConcurrencyStamp] NVARCHAR (255) NULL
);

