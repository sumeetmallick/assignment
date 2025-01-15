import logging
import functions_framework
from flask import jsonify

# Configure logging
logging.basicConfig(level=logging.INFO)

@functions_framework.http
def hello_world(request):
    """HTTP Cloud Function to handle incoming requests."""
    path = request.path

    # Define a specific path for health checks
    if path == "/healthz":
        logging.info("Health check passed.")
        return jsonify({"status": "healthy"}), 200

    # Default response for other requests
    logging.info("Processing request.")
    return "Hello, World!"
