Create procedure [dbo].[cat_Product_Delete]
	@ProductId                       int,
	@StatusID                      int out
as

	begin try
		
		set		@ProductId                       = isnull(@ProductId, 0)

		set		@StatusID		= 0
		if exists (	select 1 
					from	[cat_Product] ccl (nolock)
					where	ccl.ProductId		= @ProductId
				)
		begin

			update	[cat_Product] 
			set     IsDeleted = 1
			where	ProductId			= @ProductId
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
		set @ErrorMsg					= 'cat_Product_Delete: ' + error_message()
		set @ErrorProc					= error_procedure()
		set	@AddlInfo					= '@ProductId=' + convert(varchar,@ProductId)
		
		--exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_Classes_Delete', 'DEL', @SessionID, @AddlInfo

	end catch