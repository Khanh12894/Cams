CREATE TABLE [dbo].[sec_User] (
    [UserId]               BIGINT             IDENTITY (1, 1) NOT NULL,
    [UserName]             NVARCHAR (255)     NULL,
    [NormalizedUserName]   NVARCHAR (255)     NULL,
    [Email]                NVARCHAR (255)     NULL,
    [NormalizedEmail]      NVARCHAR (255)     NULL,
    [EmailConfirmed]       BIT                NULL,
    [PasswordHash]         NVARCHAR (MAX)     NULL,
    [PasswordSalt]         NVARCHAR (255)     NULL,
    [SecurityStamp]        NVARCHAR (255)     NULL,
    [ConcurrencyStamp]     NVARCHAR (255)     NULL,
    [PhoneNumber]          NVARCHAR (50)      NULL,
    [PhoneNumberConfirmed] BIT                NULL,
    [TwoFactorEnabled]     BIT                NULL,
    [LockoutEnd]           DATETIMEOFFSET (7) NULL,
    [LockoutEnabled]       BIT                NULL,
    [AccessFailedCount]    INT                NULL,
    [SubjectId]            NVARCHAR (255)     NULL,
    [ProviderName]         NVARCHAR (255)     NULL,
    [ProviderSubjectId]    NVARCHAR (255)     NULL
);

