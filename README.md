
# Integrating Azure OpenAI with Native Vector Support in Azure SQL Databases for Advanced Search Capabilities and Data Insights

## Leveraging Generative AI for Efficient Dataset Querying

### Author: Lawrence Teixeira
### Date: August 24, 2024

---

## Project Overview

This project demonstrates the integration of Azure OpenAI with Native Vector Support in Azure SQL Database to enable advanced search capabilities. By combining vector embeddings with SQL’s traditional query capabilities, you can perform similarity searches, enhance recommendation systems, and integrate semantic understanding into your applications.

Key features include:
- **Vector Embeddings**: Generate and store vector embeddings using Azure OpenAI.
- **Vector Search**: Perform similarity searches within your Azure SQL Database using native vector support.
- **Hybrid Search**: Combine vector search with traditional keyword filtering for enhanced results.

---

## Execute o AutoDoc
Para executar o Vector Search App click neste link: [Vector Search App](https://vectorsupportazuresql.fly.dev/)

## Installation

To get started, ensure that your environment is properly set up. Follow the steps below to install the required dependencies.

### Prerequisites

- Python 3.8 or later
- Azure SQL Database with Native Vector Support enabled
- Azure OpenAI service with API access

### Step 1: Clone the Repository

```bash
git clone https://github.com/LawrenceTeixeira/vectorsupportazuresql.git
cd vectorsupportazuresql
```

### Step 2: Install Dependencies

Make sure to install the necessary Python packages. Run the following command in your terminal:

```bash
pip install -r requirements.txt
```

### Step 3: Configure Environment Variables

Create a `.env` file or set up environment variables directly. You'll need the following variables:

```plaintext
AZURE_API_KEY=<Azure API Key>
AZURE_API_BASE=<Azure API Base>
AZURE_API_VERSION=<Azure API Version>
DB_SERVER=<Azure SQL Database Server>
DB_DATABASE=<Azure SQL Database Name>
DB_UID=<Azure SQL Database user>
DB_PWD=<Azure SQL Database passworkd>
```

## Usage

### 1. Updating Vector Fields

If you need to update or insert vector embeddings in your Azure SQL Database table, modify the `app.py` script. This script performs the following tasks:

- Fetches data from your dataset.
- Generates embeddings using Azure OpenAI.
- Converts the embeddings to binary vectors and stores them in Azure SQL Database.

To execute the script, run:

```bash
python app.py
```

### 2. Running the Streamlit App

The Streamlit app provides an interactive UI to perform searches and view results in real-time. Launch the app with:

```bash
streamlit run search.py
```

## Deploy your app in Fly.io
```sh
flyctl launch
flyctl deploy
```
## Login or Logout at Fly.io
```sh
flyctl auth login
flyctl auth logout
```

## Install fly
```sh
curl -L https://fly.io/install.sh | sh
export PATH=/home/codespace/.fly/bin
```

This will start the Streamlit server. Open your web browser and navigate to `http://localhost:8501` to access the application.

### 3. Example Use Cases

- **Semantic Search**: Enter a query, and the app will search for similar items based on the vector embeddings stored in your database.
- **Recommendation System**: Use vector search to recommend related items based on the semantic similarity of the data.
- **Hybrid Search**: Combine vector search with keyword-based filters to refine your results.

---

## Troubleshooting

If you encounter any issues, consider the following:

- **Dependencies**: Ensure all dependencies are installed by checking the `requirements.txt` file.
- **Database Permissions**: Verify that your Azure SQL user has the required permissions to read, write, and execute stored procedures.
- **Environment Variables**: Double-check that your environment variables are correctly set.

---

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue if you find a bug or have a feature request.

---
Here is your text translated into English:

## License

This project is licensed under the MIT license. See the [LICENSE](LICENSE.md) file for more details.

## Author
- LinkedIn: [Lawrence Teixeira](https://www.linkedin.com/in/lawrenceteixeira/)
- Blog: [Lawrence's Blog](https://lawrence.eti.br) - Follow my blog for more projects and updates.

## Contact

For more information, please contact me via this link: [Contact](https://lawrence.eti.br/contact/)

---
