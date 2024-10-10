/*
    This script creates a table named [newsvector] in the [dbo] schema.    The table has the following columns:
    - [article_id]: an integer column that stores the ID of the article (required)    - [source_id]: a nullable nvarchar(50) column that stores the ID of the news source
    - [source_name]: a nullable nvarchar(max) column that stores the name of the news source    - [author]: a nullable nvarchar(max) column that stores the author of the article
    - [title]: a nullable nvarchar(max) column that stores the title of the article    - [description]: a nullable nvarchar(300) column that stores the description of the article
    - [url]: a nullable nvarchar(max) column that stores the URL of the article    - [url_to_image]: a nullable nvarchar(max) column that stores the URL of the article's image
    - [content]: a nullable nvarchar(250) column that stores the content of the article    - [category]: a nullable nvarchar(50) column that stores the category of the article
    - [full_content]: a nullable nvarchar(max) column that stores the full content of the article    - [title_vector]: a nullable varchar(max) column that stores the vector representation of the article's title
    - [content_vector]: a nullable varchar(max) column that stores the vector representation of the article's content    - [published]: a nullable datetime column that stores the publication date of the article
    - [VectorBinary]: a nullable varbinary(8000) column that stores the binary representation of the article's vector
    The table is created on the [PRIMARY] filegroup with the TEXTIMAGE_ON [PRIMARY] option.*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[newsvector](
	[article_id] [int] NOT NULL,
	[source_id] [nvarchar](50) NULL,
	[source_name] [nvarchar](max) NULL,
	[author] [nvarchar](max) NULL,
	[title] [nvarchar](max) NULL,
	[description] [nvarchar](300) NULL,
	[url] [nvarchar](max) NULL,
	[url_to_image] [nvarchar](max) NULL,
	[content] [nvarchar](250) NULL,
	[category] [nvarchar](50) NULL,
	[full_content] [nvarchar](max) NULL,
	[title_vector] [varchar](max) NULL,
	[content_vector] [varchar](max) NULL,
	[published] [smalldatetime] NULL,
	[id] [int] NULL,
	[VectorBinary_title] [varbinary](8000) NULL,
	[VectorBinary_content] [varbinary](8000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_id] ON [dbo].[newsvector]
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


