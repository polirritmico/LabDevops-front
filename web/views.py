import random
import threading
import time

import requests
from django.conf import settings
from django.shortcuts import render

# Control global del loop
loop_running = False  # booleano directo


def cpu_burn(seconds: int):
    inside_circle = 0
    total = 0
    end = time.time() + seconds

    while time.time() < end:
        x, y = random.random(), random.random()
        if x * x + y * y <= 1:
            inside_circle += 1
        total += 1
    pi_estimate = 4 * inside_circle / total if total else 0

    return pi_estimate


def cpu_burn_loop(duration: int, pause: int):
    global loop_running

    while loop_running:
        pi = cpu_burn(duration)
        print(f"CPU-burn finalizado. Pi: {pi}")
        time.sleep(pause)


def index(request):
    global loop_running
    try:
        res = requests.get(f"{settings.BACKEND_API_URL}/")
        res.raise_for_status()
        content = res.json().get("data")
    except requests.RequestException as err:
        content = f"Error: {err}"

    if request.method == "POST":
        if "cpu_burn" in request.POST:
            try:
                duration = int(request.POST.get("duration", 5))
            except ValueError:
                duration = 5
            pi = cpu_burn(duration)
            content = f"CPU-burn finalizado ({duration}s). π ≈ {pi}"

        elif "loop_start" in request.POST:
            try:
                duration = int(request.POST.get("loop_duration", 5))
                pause = int(request.POST.get("loop_pause", 2))
            except ValueError:
                duration, pause = 5, 2
            loop_running = True
            threading.Thread(
                target=cpu_burn_loop, args=(duration, pause), daemon=True
            ).start()
            content = f"Loop CPU-burn iniciado ({duration}s) con pausa {pause}s."

        elif "loop_stop" in request.POST:
            loop_running = False
            content = "Loop CPU-burn detenido."

    return render(
        request, "index.html", {"titulo": "Ejemplo DEVOPS", "content": content}
    )
