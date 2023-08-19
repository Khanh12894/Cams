CREATE PROCEDURE [dbo].[sec_User_GetByEmail]
    @Email                            nvarchar(255)	
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
	where Email						  = @Email	

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_User_GetByEmail: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@Email=' + convert(nvarchar, @Email)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User_GetByEmail', 'GET', null, @AddlInfo

end catch