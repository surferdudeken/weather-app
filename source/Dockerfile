# Interpreter
FROM python:3.9

# Set the working directory in the Docker container
WORKDIR /app

# Copy the content of the local src directory to the working directory
COPY . .

# Install Python dependencies
RUN pip3.9 install --no-cache-dir -r requirements.txt

# Expose port 5000
EXPOSE 5000

CMD ["python3.9", "app.py"]
