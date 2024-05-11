.DEFAULT_GOAL := help
.PHONY: deps-dev deps-build deps build-sdist build-wheel build upload format lint tests cleanup help
MAKEFLAGS += --silent

# Aliases
PIP   = python -m pip
MYPY  = python -m mypy
BUILD = python -m build
ISORT = python -m isort
BLACK = python -m black
PYDOC = python -m pydocstyle
FLAKE = python -m flake8 --max-complexity 10 --max-line-length 100 --ignore D

deps-dev:
	$(PIP) install '.[dev]' --upgrade

deps-build:
	$(PIP) install '.[build]' --upgrade

deps: deps-dev deps-build

build-sdist:
	$(BUILD) --sdist

build-wheel:
	$(BUILD) --wheel

build: build-sdist build-wheel

upload:
	twine upload dist/*

format:
	$(BLACK) --line-length 100 --fast artless/
	$(ISORT) artless/
	$(BLACK) --line-length 100 --fast tests/
	$(ISORT) tests/

lint:
	printf "[flake8]: artless/ checking ... "
	$(FLAKE) --extend-ignore E203,W503 artless && printf "OK\n"
	printf "[flake8]: tests/ checking ... "
	$(FLAKE) --extend-ignore E203,W503,F401 tests && printf "OK\n"
	printf "[mypy]: checking ... "
	$(MYPY) --install-types --non-interactive artless/ && printf "OK\n"
	printf "[pydocstyle]: checking ... "
	$(PYDOC) artless/ && printf "OK\n"

tests:
	python -m coverage run -m unittest && python -m coverage report

tests-cov-html:
	python -m coverage run -m unittest && python -m coverage html

tests-cov-json:
	python -m coverage run -m unittest && python -m coverage json

cleanup:
	rm -rf .mypy_cache/ junit/ build/ dist/ coverage_report/
	find . -not -path 'venv*' -path '*/__pycache__*' -delete
	find . -not -path 'venv*' -path '*/*.egg-info*' -delete

help:
	echo
	echo "Usage:"
	echo "--------------------------------------------------------------------------------"
	echo "help\t\tShow this message."
	echo
	echo "deps-dev\tInstall only development dependencies."
	echo "deps-build\tInstall only build system dependencies."
	echo "deps\t\tInstall all dependencies."
	echo
	echo "build-sdist\tBuild a source distrib."
	echo "build-wheel\tBuild a pure python wheel distrib."
	echo "build\t\tBuild both distribs (source and wheel)."
	echo "upload\t\tUpload built packages to PyPI."
	echo
	echo "tests\t\tRun tests with coverage measure (output to terminal)."
	echo "tests-cov-json\tRun tests with coverage measure (output to json [coverage.json])."
	echo "tests-cov-html\tRun tests with coverage measure (output to html [coverage_report/])."
	echo
	echo "cleanup\t\tClean up python temporary files and caches."
	echo "format\t\tFromat the code (by black and isort)."
	echo "lint\t\tCheck code style, docstring style and types (by flake8, pydocstyle and mypy)."
	echo
