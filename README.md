# 🚀 LabDevOps Frontend

A sample project demostrating the usage of [git](https://git-scm.com/),
[Github](https://github.com),
[Github Actions](https://github.com/features/actions) and other best development
practices.

The backend repository could be found
[here](https://github.com/polirritmico/LabDevops-back).

## Demo project

The demo projects consists of a simple static page built with the following
technologies:

- Django
- pytest
- Docker
- Docker Compose

## Run & Build

1. Clone the repo

```bash
git clone git@github.com:polirritmico/LabDevops-front.git
```

2. 🐳 Use Docker Compose:

#### a. Using the production image from Docker Hub

Just run the production service with docker compose:

```bash
docker compose up web-production -d
```

This would download both backend and frontend builded images from DockerHub and
run both containers.

3. Check the site at: `http://localhost:8000`.

#### As an alternative you could build the image locally:

```bash
docker compose up web -d
```

Then clone and follow the
[backend's](https://github.com/polirritmico/LabDevops-back) instructions.

### Manual build & Run

```bash
docker build -t lab-devops:latest .
docker run lab-devops
```

### Enter into the container env

```bash
docker run -it lab-devops bash
```

## 🛠️ Makefile

There is a convenient Makefile provided for common development tasks. Check
detailed instructions with:

```bash
make help
```

By default it executes **pytest** with **coverage**.

> [!NOTE]
>
> Some distros do not include `make` command by default. Try installing
> `build-essential`, `make`, `base-devel` or a similar package. Check your
> distro documentation for the correct package name.

---

## 🏗️ Development workflow

The project follows a trunk-based workflow on the `develop` branch, aligning
with modern CI/CD practices.

This decision aims to encourage the following practices:

- **Faster feedback:** Developers quickly learn if their code works through
  diferent layers of tests allowing rapid fixes while the "code context" is
  still fresh.
- **Frequent merges:** Keeping code in sync with `develop` reduces the chance of
  conflicts and duplicated work.
- **Early detection of issues:** Problems and design conflicts are identified
  sooner, preventing long-term technical debt.
- **Transparent codebase:** Regular merges and shared visibility allow more eyes
  to review and audit changes, improving overall code and design quality.

> [!NOTE]
>
> For newcomers, there is still a confidence issue from the project's side. For
> their first PRs, a more branch-oriented workflow is required, allowing safe
> contributions before merging into `develop`.
>
> Check [CONTRIBUTING](CONTRIBUTING.md) for more details.

## 🏭 Pipeline

### Github Actions

> [!IMPORTANT]
>
> For them complete details of the workflow read the backend repository
> [README](https://github.com/polirritmico/LabDevops-back/blob/main/README.md).

Currently, there is a `Push to Docker Hub` action in the GitHub workflow scripts
that after building the Docker image push it to the Docker hub. The action is
trigger by any validated push into the `main` branch.

You could find the builded Docker image here:
[Docker Hub](https://hub.docker.com/repository/docker/polirritmico/demo-django-devops/general).

To use that automatically generated production build image check the **Run &
Build** section.

## Project directory organization

The project has the following directories structure:

```
LabDevops-front
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── coverage.xml
├── db.sqlite3
├── devopsdemo
│   ├── asgi.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── docker-compose.yml
├── Dockerfile
├── LICENSE
├── Makefile
├── manage.py
├── pyproject.toml
├── README.md
├── uv.lock
└── web
    ├── admin.py
    ├── apps.py
    ├── migrations
    ├── models.py
    ├── templates
    │   └── index.html
    ├── tests
    │   └── test_devopsdemo.py
    └── views.py
```
