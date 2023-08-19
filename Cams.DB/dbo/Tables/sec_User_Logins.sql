CREATE TABLE [dbo].[sec_User_Logins] (
    [UserId]              BIGINT         NOT NULL,
    [LoginProvider]       NVARCHAR (255) NULL,
    [ProviderKey]         NVARCHAR (255) NULL,
    [ProviderDisplayName] NVARCHAR (255) NULL
);

