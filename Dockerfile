FROM python:3.10-slim

# Install curl + UV
RUN apt-get update && apt-get install -y curl && \
    curl -Ls https://astral.sh/uv/install.sh | bash

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app
COPY . .

# Create venv & install deps
RUN uv venv && \
    . .venv/bin/activate && \
    uv pip install -r requirements.txt

EXPOSE 8000

CMD [".venv/bin/gunicorn", "thingsx_project.wsgi:application", "--bind", "0.0.0.0:8000"]
