import streamlit as st
import pandas as pd
import pyodbc
from litellm import embedding
import os
import time
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Set up OpenAI credentials from environment variables
os.environ['AZURE_API_KEY'] =os.getenv('AZURE_API_KEY')
os.environ['AZURE_API_BASE'] = os.getenv('AZURE_API_BASE')
os.environ['AZURE_API_VERSION'] = os.getenv('AZURE_API_VERSION')
# or from sqlalchemy import create_engine

# Function to connect to the database
def get_connection():
    with st.spinner('I am trying to connect to the database. This operation may take a few seconds if the database is paused. Please wait a moment...'):
        while True:
            try:
                cnxn = pyodbc.connect(
                    f'DRIVER={{ODBC Driver 17 for SQL Server}};'
                    f'SERVER={os.getenv("DB_SERVER")};'
                    f'DATABASE={os.getenv("DB_DATABASE")};'
                    f'UID={os.getenv("DB_UID")};'
                    f'PWD={os.getenv("DB_PWD")}',
                    timeout=5
                )
                return cnxn
            except pyodbc.OperationalError:
                print("Connection failed, retrying in 2 seconds...")
                time.sleep(2)

def get_embeddings(text):
    # Truncate the text to 8000 characters
    truncated_text = text[:8000]

    response = embedding(
        model="azure/text-embedding-3-small",
        input=truncated_text,
        api_key=os.getenv('AZURE_API_KEY'),
        api_base=os.getenv('AZURE_API_BASE'),
        api_version=os.getenv('AZURE_API_VERSION')
        )
    
    embeddings = response['data'][0]['embedding']
    return embeddings

# Streamlit app
def main():
    
    st.set_page_config(
        page_title="Integrating Azure OpenAI with Native Vector Support in Azure SQL Databases for Advanced Search Capabilities and Data Insights",
        page_icon="🧊",
        layout="wide",
        initial_sidebar_state="expanded",
    )


    with st.sidebar:
        st.image("https://i.pinimg.com/736x/b8/4b/3a/b84b3a2604e591c53777cd190576ba55--image-search.jpg")   
        ""
        "[Integrating Azure OpenAI with Native Vector Support in Azure SQL Databases for Advanced Search Capabilities and Data Insights]()"
        "Vector databases are gaining quite a lot of interest lately. Using text embeddings and vector operations makes extremely easy to find similar “things”. Things can be articles, photos, products…everything. As one can easily imagine, this ability is great to easily implement suggestions in applications. From providing suggestions on similar articles or other products that may be of interest, to quickly finding and grouping similar items, the applications are many."
        ""
        ""
        "Source: [Global News Dataset](https://www.kaggle.com/datasets/everydaycodings/global-news-dataset/)" 
        ""
        "Created by [Lawrence Teixeira](https://www.linkedin.com/in/lawrenceteixeira/)"
        ""
        "Please remember, this is merely a sample to illustrate the outcomes of a Native Vector Support in Azure SQL search, as detailed in the preceding article."    
    
    st.title("Native Vector Support in Azure SQL for Advanced Search Capabilities")

    # Text input for search query
    search_query = st.text_input("Type here your search:", placeholder="e.g., 'Generative AI: The Future Unveiled'")

    if st.button("Search"):
        # Connection to the database
        cnxn = get_connection()
        
        #vector = get_embeddings(search_query)
        
        # Definir a stored procedure e a consulta SQL
        stored_procedure = f"EXEC dbo.SearchNewsVector '{search_query}'"

        # Executar a stored procedure
        cnxn.execute(stored_procedure)
        
        query = "SELECT r.cosine_distance, r.published, r.category, r.title, r.author, r.full_content, r.url FROM result R order by r.cosine_distance DESC"

        # Executing the query
        with st.spinner('Executing the search...'):
            df = pd.read_sql(query, cnxn)

        # Displaying results
        if not df.empty:
            st.write("Search Results:")
            st.dataframe(df)
        else:
            st.write("No results found.")

if __name__ == "__main__":
    main()
