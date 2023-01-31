SOURCE_PATH=${CURDIR}/source/arcaflow-engine
BIN_PATH=${CURDIR}/arcaflowengine/bin

build_darwin_arm64 : GOOS = darwin
build_darwin_arm64 : GOARCH = arm64
build_darwin_arm64 : PLAT_NAME = macosx_11_0_arm64

build_linux_arm64 : GOOS = linux
build_linux_arm64 : GOARCH = arm64
build_linux_arm64 : PLAT_NAME = manylinux2014_aarch64

build_darwin_amd64 : GOOS = darwin
build_darwin_amd64 : GOARCH = amd64
build_darwin_amd64 : PLAT_NAME = macosx_10_9_x86_64

build_linux_amd64 : GOOS = linux
build_linux_amd64 : GOARCH = amd64
build_linux_amd64 : PLAT_NAME = manylinux2014_x86_64


# help
help:
	@echo "Usage: make setup && make <build_linux_amd64|build_linux_arm64|build_darwin_amd64|build_darwin_arm64>"

# install packaging utilities (only run this once)
setup: 
	pip3.9 install wheel setuptools twine 

checkout:
	rm -rf ${SOURCE_PATH}
	git clone https://github.com/arcalot/arcaflow-engine.git ${SOURCE_PATH}


build_linux_amd64:  checkout build_go_bin build_wheel
build_linux_arm64: checkout build_go_bin build_wheel
build_darwin_amd64:  checkout build_go_bin build_wheel
build_darwin_arm64: checkout build_go_bin build_wheel

build_go_bin:
	 cd ${SOURCE_PATH} && GOOS=${GOOS} GOARCH=${GOARCH} go build -o ${BIN_PATH}/arcaflowengine cmd/arcaflow/main.go


# remove all build artifacts
clean:
	@rm -rf arcaflowengine/bin/* build dist ${PKG_NAME}.egg-info
	@find . -name __pycache__ -exec rm -rf {} \; 2>/dev/null


build_wheel:
	python3.9 setup.py bdist_wheel --plat-name ${PLAT_NAME}


	