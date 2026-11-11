# python:3.12-slim
FROM python:3.12-slim@sha256:aa943ce411423c7582288f18707ff66eddcbaeb510502d747a72aeb34f30d159
RUN apt-get update && apt-get upgrade --yes && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY app/main.py .
USER 65534
CMD ["python", "main.py"]
