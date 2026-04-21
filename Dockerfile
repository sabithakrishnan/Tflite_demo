# Use a lightweight Python base image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file first to leverage Docker's cache
COPY requirements.txt .

# Install dependencies
# tflite-runtime is preferred over full tensorflow for smaller images
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code and the model
COPY . .

# Cloud Run expects the service to listen on the port defined by the PORT env var
# Default is usually 8080
EXPOSE 8080

# Command to run the application using uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
