#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -o errexit

echo "=== Render Build Script Starting ==="
echo "Current directory: $(pwd)"
echo "Python version: $(python3 --version)"

# Set environment variable to indicate deployment
export RENDER=True

# Upgrade pip and install dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Ensure required directories exist
mkdir -p staticfiles
mkdir -p media
mkdir -p logs

# Optional: create log files (not required for Render logging)
touch logs/django.log logs/security.log logs/access.log

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --no-input

# Apply database migrations
echo "Applying database migrations..."
python3 manage.py migrate

# Optional: Check Gunicorn installation
if command -v gunicorn >/dev/null 2>&1; then
  echo "Gunicorn is installed at $(which gunicorn)"
else
  echo "Gunicorn not found, installing..."
  pip install gunicorn
fi

echo "=== Build completed successfully ==="
