CREATE PROCEDURE [dbo].[sec_User_Delete]
	@UserId                        bigint,
	@StatusID                      int out
as

	begin try
		
		set		@UserId                        = isnull(@UserId, 0)

		set		@StatusID		= 0
		if exists (	select 1 
					from	[sec_User] uus (nolock)
					where	uus.UserId		= @UserId
				)
		begin

			delete	uus
			from	[sec_User] uus (nolock)
			where	uus.UserId			= @UserId
			set		@StatusID = 1
		end

	end try
	begin catch

		declare	@ErrorNum				int,
				@ErrorMsg				varchar(200),
				@ErrorProc				varchar(50),
				@AddlInfo				varchar(500),
				@SessionID				int

		set @ErrorNum					= error_number()
		set @ErrorMsg					= 'sec_User_Delete: ' + error_message()
		set @ErrorProc					= error_procedure()
		set	@AddlInfo					= '@UserId=' + convert(varchar,@UserId)
		
		exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User_Delete', 'DEL', @SessionID, @AddlInfo

	end catch