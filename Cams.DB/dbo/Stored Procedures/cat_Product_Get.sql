Create procedure [dbo].[cat_Product_Get]
    @ProductId                          int,
    @UserId                       bigint
    
as	

begin try

	select 
		  [ProductId]	    =  ccl. [ProductId]     
		 , [Name]            =  ccl. [Name]            
		 ,[Code]            =  ccl. [Code]            
		 ,[Signed]          =  ccl. [Signed]          
		 ,[ProductTypeId]   =  ccl. [ProductTypeId]   
		 ,[ProductGroupId]  =  ccl. [ProductGroupId]  
		 ,[AssigneeId]      =  ccl. [AssigneeId]      
		 ,[ProductUnitId]   =  ccl. [ProductUnitId]   
		 ,[IsDeleted]       =  ccl. [IsDeleted]       
		 ,[CreatedDate]     =  ccl. [CreatedDate]     
		 ,[CreatedBy]       =  ccl. [CreatedBy]       
		 ,[UpdatedDate]		=  ccl. [UpdatedDate]		
		 ,[UpdatedBy]		=  ccl. [UpdatedBy]		

	from  [dbo].[cat_Product] ccl (nolock)		 
	where ProductId                     = @ProductId	

end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'cat_Classes_Get: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@ClassId=' + convert(nvarchar, @ProductId)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_Product_Get', 'GET', null, @AddlInfo

end catch