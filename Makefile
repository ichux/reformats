
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
# help: formats 			- Formats a codebase
formats:
	@docker run --rm --volume "$(PWD):/src" \
	iformats bash -c "black . && isort . --profile black"

	@docker run --rm --volume "$(PWD):/src" iformats mypy .
	@docker run --rm --volume "$(PWD):/src" iformats flake8 .

.PHONY: a
# help: a				- Remove ununsed imports e.g. make a f=filename, make a f=./hyper
a:
	@docker run --rm --volume "$(PWD):/src" iformats bash -c \
	"autoflake --in-place --remove-all-unused-imports $(f).py"

# docker run -it iformats /bin/bash
