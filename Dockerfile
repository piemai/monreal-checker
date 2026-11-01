FROM mcr.microsoft.com/playwright/python:v1.40.0-jammy

# Force Playwright to use the global Microsoft path
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Download the exact browser version matching your installed Python package
RUN playwright install chromium

COPY . .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "10000"]
