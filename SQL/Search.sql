/*
    PROCEDURE: [dbo].[GET_EMBEDDINGS]
    DESCRIPTION:    This stored procedure is used to retrieve embeddings for a given text using the specified model. It makes use of an external REST endpoint to generate the embeddings.
    PARAMETERS:
    - @model: VARCHAR(MAX) - The name of the model to use for generating embeddings.    - @text: NVARCHAR(MAX) - The input text for which embeddings need to be generated.
    - @embedding: VARBINARY(8000) OUTPUT - The output parameter to store the generated embeddings.
    RETURNS:    None
    EXAMPLE USAGE:
    DECLARE @model VARCHAR(MAX) = '<model_name>';    DECLARE @text NVARCHAR(MAX) = '<input_text>';
    DECLARE @embedding VARBINARY(8000);    EXEC [dbo].[GET_EMBEDDINGS] @model, @text, @embedding OUTPUT;
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GET_EMBEDDINGS]
(
    @model VARCHAR(MAX),
    @text NVARCHAR(MAX),
    @embedding VARBINARY(8000) OUTPUT
)
AS
BEGIN
    DECLARE @retval INT, @response NVARCHAR(MAX);
    DECLARE @url VARCHAR(MAX);
    DECLARE @payload NVARCHAR(MAX) = JSON_OBJECT('input': @text);

    -- Set the @url variable with proper concatenation before the EXEC statement
    SET @url = 'https://<Your App>.openai.azure.com/openai/deployments/' + @model + '/embeddings?api-version=2024-02-15-preview';

    EXEC dbo.sp_invoke_external_rest_endpoint 
        @url = @url,
        @method = 'POST',   
        @payload = @payload,   
        @headers = '{"Content-Type":"application/json", "api-key":"<Your Azure Open AI API Key"}', 
        @response = @response OUTPUT;

    -- Use JSON_QUERY to extract the embedding array directly
    DECLARE @jsonArray NVARCHAR(MAX) = JSON_QUERY(@response, '$.result.data[0].embedding');

    
    SET @embedding = JSON_ARRAY_TO_VECTOR(@jsonArray);
END
