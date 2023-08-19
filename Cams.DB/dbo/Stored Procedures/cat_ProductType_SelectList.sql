Create procedure [dbo].[cat_ProductType_SelectList]
as	

begin try
	select 
		   [ProductTypeId]       =ccl. [ProductTypeId]
		  ,[Name]            =ccl. [Name]            
		  
	from  [dbo].[cat_ProductType] ccl (nolock)	
    where
		 ccl.IsDeleted = 0
    
end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'cat_ProductType_SelectList: ' + error_message()
	set @ErrorProc                    = error_procedure()

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_ProductType_SelectList', 'GET', null, @AddlInfo

end catch