#!/bin/bash

# Launch script for MyPortfolio website in WSL
# This script starts a simple HTTP server and opens the website in Windows browser

PORT=8080
HOST="localhost"

echo "Starting local server for MyPortfolio..."
echo "Server will be available at: http://$HOST:$PORT"

# Check if Python 3 is available
if command -v python3 &> /dev/null; then
    echo "Using Python 3 HTTP server..."
    # Start Python HTTP server in background
    python3 -m http.server $PORT &
    SERVER_PID=$!
elif command -v python &> /dev/null; then
    echo "Using Python 2 HTTP server..."
    # Start Python 2 HTTP server in background
    python -m SimpleHTTPServer $PORT &
    SERVER_PID=$!
else
    echo "Error: Python not found. Please install Python to run the local server."
    exit 1
fi

# Wait a moment for server to start
sleep 2

# Open in Windows browser from WSL
echo "Opening website in Windows browser..."
/mnt/c/Windows/System32/cmd.exe /c start http://$HOST:$PORT

echo ""
echo "Website is now running at: http://$HOST:$PORT"
echo "Press Ctrl+C to stop the server"

# Wait for user to stop the server
trap "echo 'Stopping server...'; kill $SERVER_PID; exit" INT
wait $SERVER_PID