# Dockerfile

# Use an official Python runtime as a base image
FROM python:3.9-alpine3.13

# Set environment variable
ENV PYTHONUNBUFFERED=1

# Copy requirements file
COPY requirements.txt /tmp/requirements.txt

COPY requirements.dev.txt /tmp/requirements.dev.txt

# Copy application code
COPY app /app

# Set the working directory
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user