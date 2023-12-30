# Stage 1: Build stage
FROM python:3.9-buster as builder

WORKDIR /app

# Copy only the requirements file to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Stage 2: Final image
FROM gcr.io/distroless/python3:latest

WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /app /app

# Set the environment variables
ENV FLASK_APP=your_app_name
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Expose the port on which the app will run
EXPOSE 5000

# Command to run the application
CMD ["flask", "run"]
