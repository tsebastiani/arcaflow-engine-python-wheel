# Makefile for pkg_name python wheel

# PKG_NAME and VERSION should match what is in setup.py
PKG_NAME=arcaflowengine
VERSION=0.1.0

# Shouldn't need to change anything below here

# determine the target wheel file
WHEEL_TARGET=dist/${PKG_NAME}-${VERSION}-py2.py3-none-any.whl

# help
help:
	@echo "Usage: make <setup|build|install|uninstall|clean>"

# install packaging utilities (only run this once)
setup: 
	pip3.9 install wheel setuptools

# build the wheel
build: ${WHEEL_TARGET}

# install to local python environment
install: ${WHEEL_TARGET}
	pip3.9 install ${WHEEL_TARGET}

# uninstall from local python environment
uninstall:
	pip3.9 uninstall ${PKG_NAME}

# remove all build artifacts
clean:
	@rm -rf build dist ${PKG_NAME}.egg-info
	@find . -name __pycache__ -exec rm -rf {} \; 2>/dev/null

# build the wheel
${WHEEL_TARGET}: setup.py ${PKG_NAME}/__init__.py ${PKG_NAME}/arcaflowengine.py ${PKG_NAME}/bin/arcaflowengine
	python3.9 setup.py bdist_wheel --universal

	