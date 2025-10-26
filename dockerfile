FROM python:3.9-slim

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Copiar y instalar dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código
COPY . .

# Crear la base de datos al iniciar
RUN python -c "
import sqlite3
conn = sqlite3.connect('users.db')
conn.close()
print('Database initialized')
"

CMD ["python", "checkerv1.py"]
