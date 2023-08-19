CREATE TABLE [dbo].[sec_User_Claims] (
    [Id]             BIGINT         NOT NULL,
    [UserId]         BIGINT         NULL,
    [Type]           NVARCHAR (255) NULL,
    [Value]          NVARCHAR (255) NULL,
    [Issuer]         NVARCHAR (512) NULL,
    [OriginalIssuer] NVARCHAR (512) NULL,
    [Subject]        NVARCHAR (512) NULL,
    [ValueType]      NVARCHAR (512) NULL
);

