FROM python:3.14.2-slim

# Keep pip from caching packages (smaller image)
ENV PIP_NO_CACHE_DIR=1

# Install base packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        curl \
        ca-certificates \
        make \
        gettext-base \
        git && \
    rm -rf /var/lib/apt/lists/*

# Install Docker CLI (use host Docker daemon via mounted socket)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" \
        > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# --- Install Python requirements ---
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

# --- Install kubectl (latest stable) ---
RUN KUBECTL_VERSION="$(curl -fsSL https://dl.k8s.io/release/stable.txt)" && \
    curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
      -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# --- Install Taskfile ---
RUN sh -c "$(curl --location --fail https://taskfile.dev/install.sh)" -- -d && \
    install -m 0755 bin/task /usr/local/bin/task

WORKDIR /workspace

# Default command (override in CI as needed)
CMD ["python3", "--version"]