Create procedure [dbo].[cat_Product_GetList]
    

    @Keyword                          nvarchar(255),
    @PageIndex                       int,
    @PageSize                         int,
    @TotalRecord                      bigint out,
    @Sort                            nvarchar(100),
	@Direction                         nvarchar(100),
	@ProductTypeId int,
	@ProductCode nvarchar(50)
as	

begin try
set @ProductTypeId=ISNULL(@ProductTypeId,0)
set @ProductCode=ISNULL(@ProductCode,'')
	select 

		   [Name]            =ccl. [Name]            
		  ,[Code]            =ccl. [Code]            
		  ,[Signed]          =ccl. [Signed]          
		  ,[ProductTypeId]   =ccl. [ProductTypeId]   
		  ,[ProductGroupId]  =ccl. [ProductGroupId]  
		  ,[AssigneeId]      =ccl. [AssigneeId]      
		  ,[ProductUnitId]   =ccl. [ProductUnitId]   
		  ,[IsDeleted]       =ccl. [IsDeleted]       
		  ,[CreatedDate]     =ccl. [CreatedDate]     
		  ,[CreatedBy]       =ccl. [CreatedBy]       
		 ,[UpdatedDate]		= ccl.[UpdatedDate]		
		 ,[UpdatedBy]		= ccl.[UpdatedBy]		
	from  [dbo].[cat_Product] ccl (nolock)	
    where
        ccl.[Name] like Concat('%',@Keyword,'%')
		and isNull(ccl.IsDeleted,0)=0
		and (@ProductTypeId=0 or ccl.ProductTypeId=@ProductTypeId)
		and (@ProductCode=0 or ccl.Code=@ProductCode)
    order by 
        CASE WHEN @Sort = 'ProductId' AND  @Direction = 'asc' THEN ccl.ProductId END ASC,
        CASE WHEN @Sort = 'Name' AND  @Direction = 'asc' THEN ccl.Name END ASC,
        CASE WHEN @Sort = 'Signed' AND  @Direction = 'asc' THEN ccl.Signed END ASC,
        CASE WHEN @Sort = 'ProductGroupId' AND  @Direction = 'asc' THEN ccl.ProductGroupId END ASC,
        CASE WHEN @Sort = 'ProductTypeId' AND  @Direction = 'asc' THEN ccl.ProductTypeId END ASC,
        --CASE WHEN @Sort = 'DeleteAt' AND  @Direction = 'asc' THEN ccl.DeleteAt END ASC,
        CASE WHEN @Sort = 'CreatedDate' AND  @Direction = 'asc' THEN ccl.CreatedDate END ASC,
        CASE WHEN @Sort = 'UpdatedDate' AND  @Direction = 'asc' THEN ccl.UpdatedDate END ASC,
        CASE WHEN @Sort = 'AssigneeId' AND  @Direction = 'asc' THEN ccl.AssigneeId END ASC,
        CASE WHEN @Sort = 'IsDeleted' AND  @Direction = 'asc' THEN ccl.IsDeleted END ASC,
        CASE WHEN @Sort = 'Code' AND  @Direction = 'asc' THEN ccl.Code END ASC

    offset @PageSize * (@PageIndex - 1) ROWS
        fetch next @PageSize ROWS ONLY;
    select
        @TotalRecord                  = count(ProductId)
    from
        [cat_Product] ccl (nolock)
    where
        isnull(ccl.IsDeleted,0) = 0
        and ccl.[Name] like Concat('%',@Keyword,'%')
		and (@ProductTypeId=0 or ccl.ProductTypeId=@ProductTypeId)
		and (@ProductCode=0 or ccl.Code=@ProductCode)
    
end try

begin catch

	declare	@ErrorNum                 int,
			@ErrorMsg                 varchar(200),
			@ErrorProc                varchar(50),
			@AddlInfo                 varchar(500)

	set @ErrorNum                     = error_number()
	set @ErrorMsg                     = 'cat_Product_GetList: ' + error_message()
	set @ErrorProc                    = error_procedure()
	set	@AddlInfo                     = '@Keyword=' + convert(nvarchar, @Keyword) + '@PageIndex=' + convert(nvarchar, @PageIndex) + '@PageSize=' + convert(nvarchar, @PageSize) + '@TotalRecord=' + convert(nvarchar, @TotalRecord)

	exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_Product_GetList', 'GET', null, @AddlInfo

end catch