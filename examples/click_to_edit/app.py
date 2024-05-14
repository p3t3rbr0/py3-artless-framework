from typing import Mapping
from dataclasses import asdict, dataclass, replace
from os import getenv
from pathlib import Path
from urllib.parse import parse_qs

from artless import App, ResponseFactory
from artless_template import Template, read_template

TEMPLATES_DIR: Path = Path(__file__).resolve().parent / "templates"


class ContactModel:
    def __init__(self, firstname: str, lastname: str, email: str) -> None:
        self.firstname = firstname
        self.lastname = lastname
        self.email = email

    def update(self, data: Mapping[str, str]) -> None:
        self.firstname = data["firstname"]
        self.lastname = data["lastname"]
        self.email = data["email"]

    def to_dict(self):
        return {
            "firstname": self.firstname,
            "lastname": self.lastname,
            "email": self.email,
        }


model = ContactModel("Фома", "Киняев", "foma.kinyaev@gmail.com")


def show_index(request):
    return ResponseFactory.html(
        read_template(TEMPLATES_DIR / "base_layout.html").render(
            main=read_template(TEMPLATES_DIR / "index.html").render()
        )
    )


def get_contact(request):
    return ResponseFactory.html(
        read_template(TEMPLATES_DIR / "contact.html").render(**model.to_dict())
    )


def get_edit_form(request):
    return ResponseFactory.html(
        read_template(TEMPLATES_DIR / "contact_form.html").render(**model.to_dict())
    )


def put_contact(request):
    model.update(request.body)

    return ResponseFactory.html(
        read_template(TEMPLATES_DIR / "contact.html").render(**model.to_dict())
    )


def create_application(config) -> App:
    app = App(config)
    app.set_routes(
        (
            ("GET", "/", show_index),
            ("GET", "/contact/1", get_contact),
            ("GET", "/contact/1/edit", get_edit_form),
            ("PUT", "/contact/1", put_contact),
        )
    )
    return app

config = {
    "DEBUG": True,
}

application = create_application(config)

if __name__ == "__main__":
    from wsgiref.simple_server import make_server

    host = getenv("HOST", "127.0.0.1")
    port = getenv("PORT", 8000)

    with make_server(host, port, application) as httpd:
        print(f"Started WSGI server on {host}:{port}")
        httpd.serve_forever()
