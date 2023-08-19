CREATE PROCEDURE [dbo].[sec_User_GetByProvider]
	@ProviderName								nvarchar(255),
    @ProviderSubjectId                          nvarchar(255)	
as	

begin try

	select 
        [UserId]                      = uus.[UserId],
        [UserName]                    = uus.[UserName],
        [NormalizedUserName]          = uus.[NormalizedUserName],
        [Email]                       = uus.[Email],
        [NormalizedEmail]             = uus.[NormalizedEmail],
        [EmailConfirmed]              = uus.[EmailConfirmed],
        [PasswordHash]                = uus.[PasswordHash],
        [SecurityStamp]               = uus.[SecurityStamp],
        [ConcurrencyStamp]            = uus.[ConcurrencyStamp],
        [PhoneNumber]                 = uus.[PhoneNumber],
        [PhoneNumberConfirmed]        = uus.[PhoneNumberConfirmed],
        [TwoFactorEnabled]            = uus.[TwoFactorEnabled],
        [LockoutEnd]                  = uus.[LockoutEnd],
        [LockoutEnabled]              = uus.[LockoutEnabled],
        [AccessFailedCount]           = uus.[AccessFailedCount],
        [SubjectId]                   = uus.[SubjectId],
        [ProviderName]                = uus.[ProviderName],
        [ProviderSubjectId]           = uus.[ProviderSubjectId]
	from  [dbo].[sec_User] uus (nolock)		 
	where 
		uus.ProviderName                    = @ProviderName	
		and uus.ProviderSubjectId           = @ProviderSubjectId	

		
	--get user claims
	select 
        [Id]                          = uuc.[Id],
        [UserId]                      = uuc.[UserId],
        [Type]						  = uuc.[Type],
        [Value]						  = uuc.[Value],
        [Issuer]                      = uuc.[Issuer],
        [OriginalIssuer]              = uuc.[OriginalIssuer],
        [Subject]                     = uuc.[Subject],
        [ValueType]                   = uuc.[ValueType]
	from  [dbo].[sec_User_Claims] uuc (nolock)		
	left join  [dbo].[sec_User] uus (nolock) on uus.UserId = uuc.UserId		
	where uus.ProviderName                  = @ProviderName	
		and uus.ProviderSubjectId           = @ProviderSubjectId		

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_User_GetByProvider: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@ProviderName=' + convert(nvarchar, @ProviderName) + ', @ProviderSubjectId=' + convert(nvarchar, @ProviderSubjectId)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User_GetByProvider', 'GET', null, @AddlInfo

end catch