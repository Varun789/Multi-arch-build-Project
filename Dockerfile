#build
FROM --platform=$BUILDPLATFORM python:3.12-slim AS builder

ARG TARGETOS 
ARG TARGETARCH 
ARG BUILDPLATFORM

WORKDIR /build

#runtime
FROM --platform=$TARGETPLATFORM python:3.12-slim AS runtime

ARG TARGETOS
ARG TARGETARCH


WORKDIR /app

COPY app.py .

RUN groupadd --system appgroup && \ 
    useradd --system --gid appgroup appuser && \ 
    chown -R appuser:appgroup /app

USER appuser

# Application configuration 
ENV PYTHONDONTWRITEBYTECODE=1 \ 
    PYTHONUNBUFFERED=1 \ 
    PORT=8080

EXPOSE 8080

# Container health check 
HEALTHCHECK --interval=30s \ 
            --timeout=5s \ 
            --start-period=5s \
            --retries=3 \ 
            CMD python -c \ 
            "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/health')"

CMD ["python", "app.py"]