# aws-build

A lightweight Python-based Docker image for AWS development and deployment workflows.

## What it includes

- Python 3.14.2 slim base
- AWS CLI for cloud operations
- kubectl for Kubernetes management
- Essential build tools (curl, ca-certificates, make)
- Your custom Python requirements

## Usage

```bash
# Build the image
docker build -t aws-build .

# Run interactively
docker run -it --rm aws-build /bin/bash

# Run with AWS credentials
docker run -it --rm -v ~/.aws:/root/.aws aws-build

# Use in CI/CD pipelines
docker run --rm -v $(pwd):/workspace aws-build python your-script.py
```

## Requirements

Ensure you have a `requirements.txt` file in your project root with your Python dependencies.
