/*    PROCEDURE: [dbo].[SearchNewsVector]
    DESCRIPTION: This stored procedure searches the SimilarNewsContentArticles table using the provided input text. It retrieves the top 10 articles based on the cosine distance between the input text's embedding and the embeddings of the articles' titles and contents.    PARAMETERS:
        - @inputText (NVARCHAR(MAX)): The input text to search for.    RETURNS: None
*/
/****** Object:  StoredProcedure [dbo].[SearchNewsVector]    Script Date: 8/24/2024 3:12:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SearchNewsVectorContent] 
    @inputText NVARCHAR(MAX)
AS
BEGIN
    -- Query the SimilarNewsContentArticles table using the response
    IF OBJECT_ID('dbo.result', 'U') IS NOT NULL
        DROP TABLE dbo.result;

	--Assuming you have a stored procedure to get embeddings for a given text
	DECLARE @e VARBINARY(8000);
	EXEC dbo.GET_EMBEDDINGS @model = 'text-embedding-3-small', @text = @inputText, @embedding = @e OUTPUT;

	SELECT TOP(10) 
       [article_id]
      ,[source_id]
      ,[source_name]
      ,[author]
      ,[title]
      ,[description]
      ,[url]
      ,[url_to_image]
      ,[content]
      ,[category]
      ,[full_content]
      ,[title_vector]
      ,[content_vector]
      ,[published]
      ,VECTOR_DISTANCE('cosine', @e, VectorBinary_content) AS cosine_distance
	into result
	FROM newsvector
	ORDER BY cosine_distance;
END