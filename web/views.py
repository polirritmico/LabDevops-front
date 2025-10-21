import requests
from django.conf import settings
from django.shortcuts import render


def index(request):
    try:
        res = requests.get(f"{settings.BACKEND_API_URL}/")
        res.raise_for_status()
        content = res.json().get("data")
    except requests.RequestException as err:
        content = f"Error: {err}"

    return render(
        request,
        "index.html",
        {
            "titulo": "Ejemplo DEVOPS",
            "content": content,
        },
    )
