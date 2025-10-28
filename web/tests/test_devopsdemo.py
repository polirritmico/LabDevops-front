#!/usr/bin/env python
# -*- coding: utf-8 -*-

from django.http import HttpResponse
from django.test import Client


def test_index_page_has_the_correct_content(client: Client) -> None:
    case: str = "/"
    expected: str = "Este texto debería aparecer en pantalla"

    response: HttpResponse = client.get(case)
    assert 200 == response.status_code

    output = response.content.decode("utf-8")
    assert expected in output
