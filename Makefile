PYTHON_FILES := $(shell find . -type f -name "*.py")

lint: $(PYTHON_FILES)
	@black --check --target-version py37 $?

black: $(PYTHON_FILES)
	@black --target-version py37 $?

install:
	pip install black poetry
	poetry install

build:
	poetry run python -m saltdocker
	poetry run python -m saltdocker --push --dryrun
	pytest

push:
	docker login --username $(HUB_USERNAME) --password $(HUB_PASSWORD)
	poetry run python -m saltdocker --push
