# artless-framework

![Build Status](https://github.com/p3t3rbr0/py3-artless-framework/actions/workflows/ci.yaml/badge.svg?branch=master)
![PyPI - Python Version](https://img.shields.io/pypi/pyversions/artless-framework)
![PyPI Version](https://img.shields.io/pypi/v/artless-framework)
[![Code Coverage](https://codecov.io/gh/p3t3rbr0/py3-artless-framework/graph/badge.svg?token=N7J33ZOKVO)](https://codecov.io/gh/p3t3rbr0/py3-artless-framework)
[![Maintainability](https://api.codeclimate.com/v1/badges/76cc047808f3dc53de01/maintainability)](https://codeclimate.com/github/p3t3rbr0/py3-artless-framework/maintainability)

The artless and minimalistic web framework without dependencies, working over WSGI.

## Main principles

1. Artless, fast and small (less then 500 LOC) WSGI-framework.
2. No third party dependencies (standart library only).
3. Support only modern versions of Python (>=3.10).
4. Integrated with most popular WSGI-servers.
5. Mostly pure functions without side effects.
6. Interfaces with type annotations.
7. Comprehensive documentation with examples of use.
8. Full test coverage.

## Limitations

* No built-in logic for working with `Cookies`.
* Requests with `multipart/form-data` content-type are not supported.
* No built-in protection, such as: CSRF, XSS, clickjacking and other attack techniques.

## Usages

...

## Benchmarks

...

## Examples

...

## Roadmap

- [ ] Async interface.
- [ ] Add plugin support.
- [ ] Support requests with `multipart/form-data` content-type.
