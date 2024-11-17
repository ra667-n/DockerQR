# Use the official Python image from the Python
FROM python:3.12-slim-bullseye

# Set the working directory to /app in the container
WORKDIR /app

# Create a non-root user named 'myuser' with a home directory
RUN useradd -m myuser

# Copy the requirements.txt file to the container to install Python dependencies
COPY requirements.txt ./

# Install the Python packages specified in requirements.txt
RUN pip install -r requirements.txt

# Create the logs and qr_codes directories and set ownership for the non-root user
RUN mkdir -p /app/logs /app/qr_codes && chown -R myuser:myuser /app/logs /app/qr_codes

# Copy the rest of the application's source code into the container, setting ownership to 'myuser'
COPY --chown=myuser:myuser . .

# Switch to the 'myuser' user to run the application
USER myuser

# Use the Python interpreter as the entrypoint and the script as the first argument
# Set the entry point for the container
ENTRYPOINT ["python", "main.py"]
# This sets a default argument, which can be overridden from the terminal
CMD ["--url", "http://github.com/ra667-n"]
