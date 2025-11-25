# Use official Python image
FROM python:3.10-slim

# Set work directory
WORKDIR /app

# Prevent Python buffering
ENV PYTHONUNBUFFERED=1

# Install system packages (for MySQL client, Ansible optional)
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev gcc \
    ansible \
    && rm -rf /var/lib/apt/lists/*

# Copy requirement file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose Django port
EXPOSE 8000

# Run migrations + start server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
