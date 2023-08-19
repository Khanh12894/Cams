CREATE TABLE [dbo].[sec_User_Tokens] (
    [UserId]        BIGINT         NOT NULL,
    [LoginProvider] NVARCHAR (255) NULL,
    [Name]          NVARCHAR (255) NULL,
    [Value]         NVARCHAR (255) NULL
);

