Create procedure [dbo].[cat_Product_Save]

    @ProductId                       int output,
	@UserId							bigint,
	@XML                           nvarchar(max)
as

	begin try

		declare	@XMLID             int
			
		set @ProductId               = isnull(@ProductId,0)
				
		set	@XML                   = dbo.ufn_Replace_XmlChars(@XML)
			
		exec sp_xml_preparedocument	@XMLID out, @XML
		 
		exec cat_Product_InsertUpdate @ProductId output,@UserId, @XMLID

		exec sp_xml_removedocument @XMLID
		
	end try

	begin catch

		declare	@ErrorNum				int,
				@ErrorMsg				nvarchar(200),
				@ErrorProc				varchar(50),
				@SessionID				int,
				@AddlInfo				varchar(max)

		set @ErrorNum					= error_number()
		set @ErrorMsg					= 'cat_Product_Save: ' + error_message()
		set @ErrorProc					= error_procedure()
		set @AddlInfo					= '@ProductId=' + convert(nvarchar, @ProductId)

		exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_Product', 'UPD', @SessionID, @AddlInfo

	end catch