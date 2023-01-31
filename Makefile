SOURCE_PATH=${CURDIR}/source/arcaflow-engine
BIN_PATH=${CURDIR}/arcaflowengine/bin

build_darwin_arm64 : OS = darwin
build_darwin_arm64 : ARCH = arm64
build_darwin_arm64 : PLAT_NAME = macosx_11_0_arm64

build_linux_arm64 : OS = linux
build_linux_arm64 : ARCH = arm64
build_linux_arm64 : PLAT_NAME = manylinux2014_aarch64

build_darwin_amd64 : OS = darwin
build_darwin_amd64 : ARCH = amd64
build_darwin_amd64 : PLAT_NAME = macosx_10_9_x86_64


build_linux_amd64 : OS = linux
build_linux_amd64 : ARCH = amd64
build_linux_amd64 : PLAT_NAME = manylinux2014_x86_64

build_windows_amd64 : OS = windows
build_windows_amd64 : ARCH = amd64
build_windows_amd64 : PLAT_NAME = win_amd64


# help
help:
	@echo "Usage: make setup && make <build_linux_amd64|build_linux_arm64|build_darwin_amd64|build_darwin_arm64|build_windows_amd64> export RELEASE_VERSION variable"

# install packaging utilities (only run this once)
setup: 
	pip3.9 install wheel setuptools twine

checkout:
	@if [ -z ${RELEASE_VERSION} ]; then echo "[ERR] RELEASE_VERSION variable not found"; exit 1; fi
	rm -rf ${ARCH}_${OS}
	mkdir ${ARCH}_${OS}

	@if [ ${PLAT_NAME} == "win_amd64" ]; then\
			curl -L --fail https://github.com/arcalot/arcaflow-engine/releases/download/$${RELEASE_VERSION}/arcaflow_$${RELEASE_VERSION/v/}_${OS}_${ARCH}.zip --output ${ARCH}_${OS}/arcaflow.zip; \
			unzip ${ARCH}_${OS}/arcaflow.zip -d ${ARCH}_${OS}/; \
			cp ${ARCH}_${OS}/arcaflow.exe ${BIN_PATH}/; \
	else \
			curl -L --fail https://github.com/arcalot/arcaflow-engine/releases/download/$${RELEASE_VERSION}/arcaflow_$${RELEASE_VERSION/v/}_${OS}_${ARCH}.tar.gz --output ${ARCH}_${OS}/arcaflow.tar.gz; \
			tar xfvz ${ARCH}_${OS}/arcaflow.tar.gz -C ${ARCH}_${OS}/; \
			cp ${ARCH}_${OS}/arcaflow ${BIN_PATH}/; \
	fi

build_linux_amd64: checkout build_wheel
build_linux_arm64:  checkout build_wheel
build_darwin_amd64:   checkout build_wheel
build_darwin_arm64:  checkout build_wheel
build_windows_amd64:  checkout build_wheel


# remove all build artifacts
clean:
	@rm -rf arcaflowengine/bin/* build dist ${PKG_NAME}.egg-info
	@find . -name __pycache__ -exec rm -rf {} \; 2>/dev/null


build_wheel:
	python3.9 setup.py bdist_wheel --plat-name ${PLAT_NAME}


	