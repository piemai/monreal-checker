FROM python:3.10-slim

# Install system dependencies required for Playwright / Chromium
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
# --prefer-binary forces pip to use pre-compiled wheels and prevents source builds
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

# Install Playwright browser binary and OS dependencies
RUN playwright install chromium
RUN playwright install-deps chromium

COPY . .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "10000"]
