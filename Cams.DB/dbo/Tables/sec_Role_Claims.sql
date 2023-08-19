CREATE TABLE [dbo].[sec_Role_Claims] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [RoleId]     INT            NULL,
    [ClaimType]  NVARCHAR (255) NULL,
    [ClaimValue] NVARCHAR (255) NULL
);

