CREATE PROCEDURE [dbo].[sec_User_InsertUpdate]
    @UserId                        bigint out,
	@XMLID                         int
as

	begin try

		if @UserId <= 0
		begin
						
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
                    [ProviderSubjectId]           nvarchar(255)) x
				
			set		@UserId                        = scope_identity()

		end
		else
		begin
			--Update mode
			update	uus
			set		       
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
                    [ProviderSubjectId]           nvarchar(255)) x

			inner join [sec_User] uus (nolock)
				on uus.UserId			= @UserId
					
			where	
                   isnull(uus.[UserName],'')                   <>isnull(x.[UserName],'')
                or isnull(uus.[NormalizedUserName],'')         <>isnull(x.[NormalizedUserName],'')
                or isnull(uus.[Email],'')                      <>isnull(x.[Email],'')
                or isnull(uus.[NormalizedEmail],'')            <>isnull(x.[NormalizedEmail],'')
                or isnull(uus.[EmailConfirmed],'')             <>isnull(x.[EmailConfirmed],'')
                or isnull(uus.[PasswordHash],'')               <>isnull(x.[PasswordHash],'')
                or isnull(uus.[SecurityStamp],'')              <>isnull(x.[SecurityStamp],'')
                or isnull(uus.[ConcurrencyStamp],'')           <>isnull(x.[ConcurrencyStamp],'')
                or isnull(uus.[PhoneNumber],'')                <>isnull(x.[PhoneNumber],'')
                or isnull(uus.[PhoneNumberConfirmed],'')       <>isnull(x.[PhoneNumberConfirmed],'')
                or isnull(uus.[TwoFactorEnabled],'')           <>isnull(x.[TwoFactorEnabled],'')
                or isnull(uus.[LockoutEnd],'')                 <>isnull(x.[LockoutEnd],'')
                or isnull(uus.[LockoutEnabled],'')             <>isnull(x.[LockoutEnabled],'')
                or isnull(uus.[AccessFailedCount], 0)          <>isnull(x.[AccessFailedCount], 0)
                or isnull(uus.[SubjectId],'')                  <>isnull(x.[SubjectId],'')
                or isnull(uus.[ProviderName],'')               <>isnull(x.[ProviderName],'')
                or isnull(uus.[ProviderSubjectId],'')          <>isnull(x.[ProviderSubjectId],'')
		end
		
	end try

	begin catch

		declare	@ErrorNum				int,
				@ErrorMsg				nvarchar(200),
				@ErrorProc				varchar(50),
				@SessionID				int,
				@AddlInfo				varchar(max)

		set @ErrorNum					= error_number()
		set @ErrorMsg					= 'sec_User_InsertUpdate: ' + error_message()
		set @ErrorProc					= error_procedure()
		set @AddlInfo					= '@UserId=' + convert(nvarchar, @UserId)

		exec utl_Insert_ErrorLog @ErrorNum, @ErrorMsg, @ErrorProc, 'sec_User', 'UPD', @SessionID, @AddlInfo

	end catch