.PHONY: setup install freeze

PROJECT=sd-template

all:
	@echo "make [setup|install|freeze]"

setup:
	@if [ -d ${PWD}/.${PROJECT} ]; then\
		echo ${PROJECT} project venv directory already exists;\
		exit 2; fi
	python3 -m venv .${PROJECT}
	@echo "Update ~/.sd-venv-init.sh and PS1 in .${PROJECT}/bin/activate"

install:
	@if [ "${VIRTUAL_ENV}" = "" ]; then echo Not inside venv; exit 2; fi
	-@[ ! -f requirements.txt ] && echo "pylint\npytest" > requirements.txt
	@cat requirements.txt
	@pip install --upgrade pip
	@pip install -r requirements.txt

freeze:
	@if [ "${VIRTUAL_ENV}" = "" ]; then echo Not inside venv; exit 2; fi
	@if [ ! -f requirements.txt ]; then\
		echo "requirements.txt should exists";\
		exit 2; fi
	@pip install --upgrade pip
	@pip freeze | sort | tee requirements.txt
