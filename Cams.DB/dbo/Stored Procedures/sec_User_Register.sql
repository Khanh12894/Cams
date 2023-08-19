CREATE PROCEDURE [dbo].[sec_User_Register]

    @UserId                        bigint output,
	@XML                           nvarchar(max)
as

	begin try

		declare	@XMLID             int
			
		set @UserId                = isnull(@UserId,0)
				
		set	@XML                   = dbo.ufn_Replace_XmlChars(@XML)
			
		exec sp_xml_preparedocument	@XMLID out, @XML
		 
		exec sec_User_Register_Insert @UserId output, @XMLID

		exec sp_xml_removedocument @XMLID
		
	end try

	begin catch

		declare	@ErrorNum				int,
				@ErrorMsg				nvarchar(200),
				@ErrorProc				varchar(50),
				@SessionID				int,
				@AddlInfo				varchar(max)

		set @ErrorNum					= error_number()
		set @ErrorMsg					= 'sec_User_Register: ' + error_message()
		set @ErrorProc					= error_procedure()
		set @AddlInfo					= '@UserId=' + convert(nvarchar, @UserId)

		exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User', 'UPD', @SessionID, @AddlInfo

	end catch