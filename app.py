from litellm import embedding
import pyodbc  # or another SQL connection library
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Set up OpenAI credentials
# Set up OpenAI credentials from environment variables
#os.environ['AZURE_API_KEY'] =os.getenv('AZURE_API_KEY')
#os.environ['AZURE_API_BASE'] = os.getenv('AZURE_API_BASE')
#os.environ['AZURE_API_VERSION'] = os.getenv('AZURE_API_VERSION')
os.environ['OPENAI_API_KEY'] = os.getenv('OPENAI_API_KEY')

# Connect to your Azure SQL database
conn = pyodbc.connect(f'DRIVER={{ODBC Driver 17 for SQL Server}};'
                      f'SERVER={os.getenv("DB_SERVER")};'
                      f'DATABASE={os.getenv("DB_DATABASE")};'
                      f'UID={os.getenv("DB_UID")};'
                      f'PWD={os.getenv("DB_PWD")}')

def get_embeddings(text):
    # Truncate the text to 8191 characters bacause of the text-embedding-3-small OpenAI API Embedding model limit
    truncated_text = text[:8191]

    response = embedding(
        #model="azure/text-embedding-3-small",
        model="text-embedding-3-small",
        input=truncated_text,
        #api_key=os.getenv('AZURE_API_KEY'),
        #api_base=os.getenv('AZURE_API_BASE'),
        #api_version=os.getenv('AZURE_API_VERSION')
        )
        
    embeddings = response['data'][0]['embedding']
    return embeddings


def update_database(article_id, title_vector, content_vector):
    cursor = conn.cursor()

    # Convert vectors to strings
    title_vector_str = str(title_vector)
    content_vector_str = str(content_vector)

    # Update the SQL query to use the string representations
    cursor.execute("""
        UPDATE newsvector
        SET title_vector = ?, content_vector = ?
        WHERE article_id = ?
    """, (title_vector_str, content_vector_str, article_id))
    conn.commit()


def embed_and_update():
    cursor = conn.cursor()
    cursor.execute("SELECT article_id, title, full_content FROM newsvector where title_vector is null and full_content is not null and title is not null order by published asc")
    
    title_vector = ""
    content_vector = ""
    
    for row in cursor.fetchall():
        article_id, title, full_content = row
        
        print(f"Embedding article {article_id} - {title}")
        
        title_vector = get_embeddings(title)
        content_vector = get_embeddings(full_content)
        
        update_database(article_id, title_vector, content_vector)

embed_and_update()
