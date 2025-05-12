FROM python:3.12-slim

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy the application into the container.
COPY . /app

# Install the application dependencies.
WORKDIR /app
RUN uv sync --frozen --no-cache

EXPOSE 80

CMD ["uv","run", "gunicorn", "thingsx_project.wsgi:application", "-b", "0.0.0.0:80"]
