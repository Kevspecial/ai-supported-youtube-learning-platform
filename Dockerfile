FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create offload folder for large model loading
RUN mkdir -p /tmp/offload_folder

# Copy application code
COPY src/ ./
COPY SpecsAgents/ ./SpecsAgents/

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    FLASK_APP=main.py \
    FLASK_ENV=production

# Expose port
EXPOSE 5000

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "300", "--graceful-timeout", "30", "--workers", "1", "main:app"]
