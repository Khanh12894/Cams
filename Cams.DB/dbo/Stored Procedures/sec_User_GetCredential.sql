CREATE PROCEDURE [dbo].[sec_User_GetCredential]
    @UserName                           nvarchar(255)	
as	

begin try

	select 
        [PasswordSalt]                = uus.[PasswordSalt],
        [PasswordHash]                = uus.[PasswordHash]
	from  [dbo].[sec_User] uus (nolock)		 
	where UserName                    = @UserName	

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'sec_User_GetCredential: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@UserName=' + convert(nvarchar, @UserName)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User_GetCredential', 'GET', null, @AddlInfo

end catch