FROM python:3.14.2-slim

# Make pip a bit nicer + ensure local bin is on PATH
ENV PIP_NO_CACHE_DIR=1 \
    PATH="/root/.local/bin:${PATH}"

# Install base packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        make && \
    rm -rf /var/lib/apt/lists/*

# --- Install Python requirements ---
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

# --- Install kubectl (latest stable) ---
RUN KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)" && \
    curl -L "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# --- Install Taskfile ---
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d && \
    install -m 0755 bin/task /usr/local/bin/task && \
    rm -rf bin

WORKDIR /workspace

# Default command (override in CI as needed)
CMD ["python3", "--version"]
