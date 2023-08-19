Create procedure [dbo].[cat_Product_InsertUpdate]
    @ProductId                       int out,
	@UserId							bigint,
	@XMLID                         int
as

	begin try

		if @ProductId <= 0
		begin
						
			--Insert mode
			insert into [cat_Product]
					(       
                     [Name]
                    ,[Code] 
                    ,[Signed]
                    ,[ProductTypeId]
                    ,[ProductGroupId]
                    ,[AssigneeId]
                    ,[ProductUnitId]
                    ,[IsDeleted]
                    ,[CreatedDate]
                    ,[CreatedBy]
				    ,[UpdatedDate]
				    ,[UpdatedBy]
					)
			select	             
                      [Name]            =  x. [Name]            
                     ,[Code]            =  x. [Code]            
                     ,[Signed]          =  x. [Signed]          
                     ,[ProductTypeId]   =  x. [ProductTypeId]   
                     ,[ProductGroupId]  =  x. [ProductGroupId]  
                     ,[AssigneeId]      =  x. [AssigneeId]      
                     ,[ProductUnitId]   =  x. [ProductUnitId]   
                     ,[IsDeleted]       =  x. [IsDeleted]       
                     ,[CreatedDate]     =  x. [CreatedDate]     
                     ,[CreatedBy]       =  x. [CreatedBy]       
					 ,[UpdatedDate]		=  x. [UpdatedDate]		
					 ,[UpdatedBy]		=  x. [UpdatedBy]		



			from	openxml(@XMLID, '/Product', 2) 
			with	(
					
					[Name] nvarchar(512) ,
					[Code] nvarchar(50) ,
					[Signed] nvarchar(50) ,
					[ProductTypeId] int ,
					[ProductGroupId] int ,
					[AssigneeId] bigint ,
					[ProductUnitId] int ,
					[IsDeleted] bit ,
					[CreatedDate] datetime ,
					[CreatedBy] bigint ,
					[UpdatedDate] datetime ,
					[UpdatedBy] bigint 
					) x

			set		@ProductId                       = scope_identity()
		end
		else
		begin
			--Update mode
			update	ccl
			set		       
                     [Name]            =  x. [Name]            
                    ,[Code]            =  x. [Code]            
                    ,[Signed]          =  x. [Signed]          
                    ,[ProductTypeId]   =  x. [ProductTypeId]   
                    ,[ProductGroupId]  =  x. [ProductGroupId]  
                    ,[AssigneeId]      =  x. [AssigneeId]      
                    ,[ProductUnitId]   =  x. [ProductUnitId]   
                    ,[IsDeleted]       =  x. [IsDeleted]       
                    ,[CreatedDate]     =  x. [CreatedDate]     
                    ,[CreatedBy]       =  x. [CreatedBy]       
                    ,[UpdatedDate]		=  x. [UpdatedDate]		
					,[UpdatedBy]		=  x. [UpdatedBy]								
			from	openxml(@XMLID, '/Product', 2)				
			with	(
					
					[Name] nvarchar(512) ,
					[Code] nvarchar(50) ,
					[Signed] nvarchar(50) ,
					[ProductTypeId] [int] ,
					[ProductGroupId] [int] ,
					[AssigneeId] [bigint] ,
					[ProductUnitId] [int] ,
					[IsDeleted] [bit] ,
					[CreatedDate] [datetime] ,
					[CreatedBy] [bigint] ,
					[UpdatedDate] [datetime] ,
					[UpdatedBy] [bigint] 
					) x


			inner join [cat_Product] ccl (nolock)
				on ccl.ProductId			= @ProductId
					
			where	
			       isnull(ccl.[Name],'')                  <> isnull(x.[Name],'')          
                or isnull(ccl.[Code],'')                  <> isnull(x.[Code],'')          
                or isnull(ccl.[Signed],'')                <> isnull(x.[Signed],'')        
                or isnull(ccl.[ProductTypeId],0)          <> isnull(x.[ProductTypeId],0)  
                or isnull(ccl.[ProductGroupId],0)         <> isnull(x.[ProductGroupId],0) 
                or isnull(ccl.[AssigneeId],0)             <> isnull(x.[AssigneeId],0)     
                or isnull(ccl.[ProductUnitId],0)          <> isnull(x.[ProductUnitId],0)  
                or isnull(ccl.[IsDeleted], 0)             <> isnull(x.[IsDeleted], 0)     
                or isnull(ccl.[CreatedDate],'')           <> isnull(x.[CreatedDate],'')   
                or isnull(ccl.[CreatedBy], '')            <> isnull(x.[CreatedBy], '')    
                or isnull(ccl.[UpdatedDate], '')          <> isnull(x.[UpdatedDate], '')  
				or isnull(ccl.[UpdatedBy], '')            <> isnull(x.[UpdatedBy], '')    
		end
		
	end try

	begin catch

		declare	@ErrorNum				int,
				@ErrorMsg				nvarchar(200),
				@ErrorProc				varchar(50),
				@SessionID				int,
				@AddlInfo				varchar(max)

		set @ErrorNum					= error_number()
		set @ErrorMsg					= 'cat_Product_InsertUpdate: ' + error_message()
		set @ErrorProc					= error_procedure()
		set @AddlInfo					= '@ClassId=' + convert(nvarchar, @ProductId)

		exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'cat_Product', 'UPD', @SessionID, @AddlInfo

	end catch