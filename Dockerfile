FROM python:3.13-slim AS base
LABEL maintainer="Eduardo Bray <ed.bray@duocuc.cl>"

ARG USER=devops

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
    && useradd -m $USER \
    && install -d -o $USER -g $USER /app \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --chown=$USER:$USER requirements*.txt .
RUN pip install --no-cache-dir -r requirements.txt
ENV PATH="/home/$USER/.local/bin:$PATH"
USER $USER:$USER


FROM base AS develop
RUN pip install --no-cache-dir -r requirements-dev.txt
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


FROM base AS production
ENV PYTHONDONTWRITEBYTECODE=true
ENV PYTHONUNBUFFERED=true
ENV DJANGO_SETTINGS_MODULE=devopsdemo.settings
ENV ALLOWED_HOSTS=*
EXPOSE 8000
CMD ["gunicorn", "-b", "0.0.0.0:8000", "devopsdemo.wsgi:application", "--workers", "2"]
