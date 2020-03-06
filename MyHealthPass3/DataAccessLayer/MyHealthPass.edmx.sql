
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 03/05/2020 22:28:34
-- Generated from EDMX file: C:\Users\Shae Jean-Marie\source\repos\MyHealthPass3\MyHealthPass3\DataAccessLayer\MyHealthPass.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [MyHealthPass];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_UserRole_User]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_User];
GO
IF OBJECT_ID(N'[dbo].[FK_UserRole_Role]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_Role];
GO
IF OBJECT_ID(N'[dbo].[FK_UserPerson]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_UserPerson];
GO
IF OBJECT_ID(N'[dbo].[FK_ClientCorsOriginClient]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ClientCorsOrigins] DROP CONSTRAINT [FK_ClientCorsOriginClient];
GO
IF OBJECT_ID(N'[dbo].[FK_ClientPostLogoutRedirectUriClient]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ClientPostLogoutRedirectUris] DROP CONSTRAINT [FK_ClientPostLogoutRedirectUriClient];
GO
IF OBJECT_ID(N'[dbo].[FK_ClientClientRedirectUri]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ClientRedirectUris] DROP CONSTRAINT [FK_ClientClientRedirectUri];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[People]', 'U') IS NOT NULL
    DROP TABLE [dbo].[People];
GO
IF OBJECT_ID(N'[dbo].[Roles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Roles];
GO
IF OBJECT_ID(N'[dbo].[Clients]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Clients];
GO
IF OBJECT_ID(N'[dbo].[Scopes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Scopes];
GO
IF OBJECT_ID(N'[dbo].[Claims]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Claims];
GO
IF OBJECT_ID(N'[dbo].[ClientScopes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ClientScopes];
GO
IF OBJECT_ID(N'[dbo].[ScopeClaims]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ScopeClaims];
GO
IF OBJECT_ID(N'[dbo].[ClientCorsOrigins]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ClientCorsOrigins];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[ClientRedirectUris]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ClientRedirectUris];
GO
IF OBJECT_ID(N'[dbo].[ClientPostLogoutRedirectUris]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ClientPostLogoutRedirectUris];
GO
IF OBJECT_ID(N'[dbo].[UserRole]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserRole];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'People'
CREATE TABLE [dbo].[People] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(max)  NOT NULL,
    [LastName] nvarchar(max)  NOT NULL,
    [Dob] datetime  NOT NULL,
    [IsDeleted] nvarchar(max)  NOT NULL,
    [DateCreated] datetime  NOT NULL,
    [LastUpdated] datetime  NOT NULL,
    [User_Id] int  NULL
);
GO

-- Creating table 'Roles'
CREATE TABLE [dbo].[Roles] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [IsDeleted] bit  NOT NULL,
    [DateCreated] datetime  NOT NULL,
    [LastUpdated] datetime  NOT NULL
);
GO

-- Creating table 'Clients'
CREATE TABLE [dbo].[Clients] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ClientId] nvarchar(max)  NOT NULL,
    [ClientName] nvarchar(max)  NOT NULL,
    [Enabled] bit  NOT NULL,
    [TokenLifetime] int  NOT NULL,
    [MaxLoginAttemptsLock] smallint  NOT NULL,
    [MaxLoginAttemptsLockout] smallint  NOT NULL,
    [LockoutTimeSpan] int  NOT NULL,
    [PasswordMinLength] smallint  NOT NULL,
    [PasswordRequireCaps] bit  NOT NULL,
    [PasswordRequireDigit] bit  NOT NULL,
    [PasswordRequireSpecialChar] bit  NOT NULL,
    [IsDeleted] bit  NOT NULL,
    [DateCreated] datetime  NOT NULL,
    [LastUpdated] datetime  NOT NULL
);
GO

-- Creating table 'Scopes'
CREATE TABLE [dbo].[Scopes] (
    [Id] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'Claims'
CREATE TABLE [dbo].[Claims] (
    [Id] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'ClientScopes'
CREATE TABLE [dbo].[ClientScopes] (
    [Id] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'ScopeClaims'
CREATE TABLE [dbo].[ScopeClaims] (
    [Id] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'ClientCorsOrigins'
CREATE TABLE [dbo].[ClientCorsOrigins] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Origin] nvarchar(max)  NOT NULL,
    [ClientId] int  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [PasswordHash] varbinary(max)  NOT NULL,
    [IsDeleted] bit  NOT NULL,
    [IsLocked] bit  NOT NULL,
    [LockoutTimeStamp] nvarchar(max)  NULL,
    [IsLockedOut] bit  NOT NULL,
    [LastUpdated] datetime  NOT NULL,
    [DateCreated] datetime  NOT NULL
);
GO

-- Creating table 'ClientRedirectUris'
CREATE TABLE [dbo].[ClientRedirectUris] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Uri] nvarchar(max)  NOT NULL,
    [ClientId] int  NOT NULL
);
GO

-- Creating table 'ClientPostLogoutRedirectUris'
CREATE TABLE [dbo].[ClientPostLogoutRedirectUris] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Uri] nvarchar(max)  NOT NULL,
    [ClientId] int  NOT NULL
);
GO

-- Creating table 'UserRole'
CREATE TABLE [dbo].[UserRole] (
    [Users_Id] int  NOT NULL,
    [Roles_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'People'
ALTER TABLE [dbo].[People]
ADD CONSTRAINT [PK_People]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Roles'
ALTER TABLE [dbo].[Roles]
ADD CONSTRAINT [PK_Roles]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Clients'
ALTER TABLE [dbo].[Clients]
ADD CONSTRAINT [PK_Clients]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Scopes'
ALTER TABLE [dbo].[Scopes]
ADD CONSTRAINT [PK_Scopes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Claims'
ALTER TABLE [dbo].[Claims]
ADD CONSTRAINT [PK_Claims]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ClientScopes'
ALTER TABLE [dbo].[ClientScopes]
ADD CONSTRAINT [PK_ClientScopes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ScopeClaims'
ALTER TABLE [dbo].[ScopeClaims]
ADD CONSTRAINT [PK_ScopeClaims]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ClientCorsOrigins'
ALTER TABLE [dbo].[ClientCorsOrigins]
ADD CONSTRAINT [PK_ClientCorsOrigins]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ClientRedirectUris'
ALTER TABLE [dbo].[ClientRedirectUris]
ADD CONSTRAINT [PK_ClientRedirectUris]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ClientPostLogoutRedirectUris'
ALTER TABLE [dbo].[ClientPostLogoutRedirectUris]
ADD CONSTRAINT [PK_ClientPostLogoutRedirectUris]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Users_Id], [Roles_Id] in table 'UserRole'
ALTER TABLE [dbo].[UserRole]
ADD CONSTRAINT [PK_UserRole]
    PRIMARY KEY CLUSTERED ([Users_Id], [Roles_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Users_Id] in table 'UserRole'
ALTER TABLE [dbo].[UserRole]
ADD CONSTRAINT [FK_UserRole_User]
    FOREIGN KEY ([Users_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Roles_Id] in table 'UserRole'
ALTER TABLE [dbo].[UserRole]
ADD CONSTRAINT [FK_UserRole_Role]
    FOREIGN KEY ([Roles_Id])
    REFERENCES [dbo].[Roles]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserRole_Role'
CREATE INDEX [IX_FK_UserRole_Role]
ON [dbo].[UserRole]
    ([Roles_Id]);
GO

-- Creating foreign key on [User_Id] in table 'People'
ALTER TABLE [dbo].[People]
ADD CONSTRAINT [FK_UserPerson]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserPerson'
CREATE INDEX [IX_FK_UserPerson]
ON [dbo].[People]
    ([User_Id]);
GO

-- Creating foreign key on [ClientId] in table 'ClientCorsOrigins'
ALTER TABLE [dbo].[ClientCorsOrigins]
ADD CONSTRAINT [FK_ClientCorsOriginClient]
    FOREIGN KEY ([ClientId])
    REFERENCES [dbo].[Clients]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ClientCorsOriginClient'
CREATE INDEX [IX_FK_ClientCorsOriginClient]
ON [dbo].[ClientCorsOrigins]
    ([ClientId]);
GO

-- Creating foreign key on [ClientId] in table 'ClientPostLogoutRedirectUris'
ALTER TABLE [dbo].[ClientPostLogoutRedirectUris]
ADD CONSTRAINT [FK_ClientPostLogoutRedirectUriClient]
    FOREIGN KEY ([ClientId])
    REFERENCES [dbo].[Clients]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ClientPostLogoutRedirectUriClient'
CREATE INDEX [IX_FK_ClientPostLogoutRedirectUriClient]
ON [dbo].[ClientPostLogoutRedirectUris]
    ([ClientId]);
GO

-- Creating foreign key on [ClientId] in table 'ClientRedirectUris'
ALTER TABLE [dbo].[ClientRedirectUris]
ADD CONSTRAINT [FK_ClientClientRedirectUri]
    FOREIGN KEY ([ClientId])
    REFERENCES [dbo].[Clients]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ClientClientRedirectUri'
CREATE INDEX [IX_FK_ClientClientRedirectUri]
ON [dbo].[ClientRedirectUris]
    ([ClientId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------