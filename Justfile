image_name := "pragmatic-debian-packages:latest"

default: image-build image-run

# Build the Debian package builder image.
image-build:
    podman build -t {{ image_name }} {{ justfile_directory() }}

# Get a shell inside a container for the Debian package builder image.
image-run:
    podman run --rm -it -v {{ justfile_directory() }}:/repo {{ image_name }} /bin/bash

execute-dpkg-buildpackage dir:
    cd {{ justfile_directory() }}/{{ dir }} \
        && dpkg-buildpackage -us -uc -b

execute-dpkg-buildpackage-all: (execute-dpkg-buildpackage "golang") (execute-dpkg-buildpackage "kiwiirc") (execute-dpkg-buildpackage "puppetboard") (execute-dpkg-buildpackage "riemann")
