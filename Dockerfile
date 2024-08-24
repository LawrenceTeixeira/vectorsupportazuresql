# Start by pulling a base image with Python 3.11.3
FROM laudio/pyodbc:2.1.0

WORKDIR /app

COPY requirements.txt /app/

RUN pip install -r requirements.txt

COPY . /app

EXPOSE 8501

ENTRYPOINT ["streamlit", "run", "search.py", "--server.port=8501", "--server.address=0.0.0.0"]
