
# Do not remove this block. It is used by the 'help' rule when
# constructing the help output.
# help:
# help: iformats help
# help:

.PHONY: help
# help: help				- Please use "make <target>" where <target> is one of
help:
	@grep "^# help\:" Makefile | sed 's/\# help\: //' | sed 's/\# help\://'

.PHONY: build
# help: build 				- Build the image
build:
	@docker build -t iformats .

.PHONY: formats
# help: formats 			- Formats a codebase e.g. make formats c=mypy|flake8|isort|black
formats:
	@docker run --rm --volume "$(pwd):/src" --workdir /src \
	iformats bash -c "black . && isort . --profile black"

	@docker run --rm --volume "$(pwd):/src" --workdir /src iformats mypy .
	@docker run --rm --volume "$(pwd):/src" --workdir /src iformats flake8 .
