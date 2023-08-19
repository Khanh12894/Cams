/*
*****************************************************************************************
	-- Author:			KietNQ
	-- Description:		Insert or Update User
	-- Type:			Internal
	-- Date				PIC					Update record
	-- 2022/11/21		KietNQ				Create new	
*****************************************************************************************
*/

create procedure [dbo].[sec_User_Register_Insert]
    @UserId                        bigint out,
	@XMLID                         int
as

	begin try

						
			--Insert mode
			insert into [sec_User]
					(       
                    [UserName],       
                    [NormalizedUserName],       
                    [Email],       
                    [NormalizedEmail],       
                    [EmailConfirmed],
                    [PasswordHash],       
                    [SecurityStamp],       
                    [ConcurrencyStamp],       
                    [PhoneNumber],       
                    [PhoneNumberConfirmed],       
                    [TwoFactorEnabled],       
                    [LockoutEnd],       
                    [LockoutEnabled],       
                    [AccessFailedCount],       
                    [SubjectId],       
                    [ProviderName],       
                    [ProviderSubjectId])
			select	       
                    [UserName]                    =x.[UserName],       
                    [NormalizedUserName]          =x.[NormalizedUserName],       
                    [Email]                       =x.[Email],       
                    [NormalizedEmail]             =x.[NormalizedEmail],       
                    [EmailConfirmed]              =x.[EmailConfirmed],
                    [PasswordHash]                =x.[PasswordHash],       
                    [SecurityStamp]               =x.[SecurityStamp],       
                    [ConcurrencyStamp]            =x.[ConcurrencyStamp],       
                    [PhoneNumber]                 =x.[PhoneNumber],       
                    [PhoneNumberConfirmed]        =x.[PhoneNumberConfirmed],       
                    [TwoFactorEnabled]            =x.[TwoFactorEnabled],       
                    [LockoutEnd]                  =x.[LockoutEnd],       
                    [LockoutEnabled]              =x.[LockoutEnabled],       
                    [AccessFailedCount]           =x.[AccessFailedCount],       
                    [SubjectId]                   =x.[SubjectId],       
                    [ProviderName]                =x.[ProviderName],       
                    [ProviderSubjectId]           =x.[ProviderSubjectId]

			from	openxml(@XMLID, '/User', 2) 
			with	(
                    [UserName]                    nvarchar(255),
                    [NormalizedUserName]          nvarchar(255),
                    [Email]                       nvarchar(255),
                    [NormalizedEmail]             nvarchar(255),
                    [EmailConfirmed]              bit,
                    [PasswordHash]                nvarchar(max),
                    [SecurityStamp]               nvarchar(255),
                    [ConcurrencyStamp]            nvarchar(255),
                    [PhoneNumber]                 nvarchar(50),
                    [PhoneNumberConfirmed]        bit,
                    [TwoFactorEnabled]            bit,
                    [LockoutEnd]                  datetimeoffset(7),
                    [LockoutEnabled]              bit,
                    [AccessFailedCount]           int,
                    [SubjectId]                   nvarchar(255),
                    [ProviderName]                nvarchar(255),
                    [ProviderSubjectId]           nvarchar(255)
					) x
				
			set		@UserId                        = scope_identity()


			-- insert sec_user_role

			insert into sec_User_Roles (UserId,RoleId) select 
				[UserId]                    =@UserId,       
				[TypeId]					=x.[UserType]
				
			from	openxml(@XMLID, '/User', 2) 
			with	(
                    [UserType]                    int
					)x

		
		
	end try

	begin catch

		declare	@ErrorNum				int,
				@ErrorMsg				nvarchar(200),
				@ErrorProc				varchar(50),
				@SessionID				int,
				@AddlInfo				varchar(max)

		set @ErrorNum					= error_number()
		set @ErrorMsg					= 'sec_User_Register_Insert: ' + error_message()
		set @ErrorProc					= error_procedure()
		set @AddlInfo					= '@UserId=' + convert(nvarchar, @UserId)

		exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User', 'UPD', @SessionID, @AddlInfo

	end catch