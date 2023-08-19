CREATE PROCEDURE [dbo].[sec_User_Get]
    @UserId                           bigint	
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
        [AccessFailedCount]           = uus.[AccessFailedCount]
	from  [dbo].[sec_User] uus (nolock)		 
	where UserId                      = @UserId	

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'ec_User_Get: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserId=' + convert(nvarchar, @UserId)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User_Get', 'GET', null, @AddlInfo

end catch