# aws-build

A lightweight Python-based Docker image for AWS development and deployment workflows.

## What it includes

- Python 3.14.2 slim base
- AWS CLI for cloud operations
- kubectl for Kubernetes management
- Essential build tools (curl, ca-certificates, taskfile, make, gettext-base)
- Custom Python requirements

## Usage

```bash
# Build the image
docker build -t xcelerateit/aws-build:latest .
docker build --platform linux/amd64 -t xcelerateit/aws-build:latest .

# Tag existing local image
docker tag xcelerateit/aws-build:latest xcelerateit/aws-build:v0.1

# Push the versioned tag and latest
docker push xcelerateit/aws-build:v0.1
docker push xcelerateit/aws-build:latest

# Run interactively
docker run -it --rm xcelerateit/aws-build bash

# Run with AWS credentials
docker run -it --rm -v ~/.aws:/root/.aws xcelerateit/aws-build bash

# Use in CI/CD pipelines
docker run --rm -v $(pwd):/workspace xcelerateit/aws-build python your-script.py
```

## Requirements

Ensure you have a `requirements.txt` file in your project root with your Python dependencies.
