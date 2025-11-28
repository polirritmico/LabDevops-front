#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
from unittest.mock import patch

import pytest
from django.http import HttpResponse
from django.test import Client
from django.urls import reverse


def test_index_page_has_the_correct_content(client: Client) -> None:
    case: str = "/"
    expected: str = "Este texto debería aparecer en pantalla"

    response: HttpResponse = client.get(case)
    assert 200 == response.status_code

    output = response.content.decode("utf-8")
    assert expected in output


@pytest.mark.django_db
@patch("requests.get")
def test_loop_start_and_stop(mock_get, client):
    mock_get.return_value.status_code = 200
    mock_get.return_value.json.return_value = {"data": "ignored"}

    url = reverse("index")

    # Start loop
    response = client.post(
        url, {"loop_start": "1", "loop_duration": "1", "loop_pause": "1"}
    )
    assert response.status_code == 200
    assert "Loop CPU-burn iniciado" in response.content.decode()

    # Give thread a moment to start
    time.sleep(0.1)

    # Stop loop
    response = client.post(url, {"loop_stop": "1"})
    assert response.status_code == 200
    assert "Loop CPU-burn detenido" in response.content.decode()
