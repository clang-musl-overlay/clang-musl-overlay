FROM gentoo/stage3:nomultilib

COPY .ci/image-builder/files/repos.conf /etc/portage/repos.conf
COPY .ci/image-builder/specs/* ./
COPY * /var/db/repos/clang-musl/

RUN emerge-webrsync \
 && USE="-iso" emerge -v app-arch/pixz dev-util/catalyst \
 && emerge -c \
 && rm -rf /var/db/repos/* \
 && rm -rf /var/cache/binpkgs/* \
 && rm -rf /var/cache/distfiles/* \
 && rm -rf /var/tmp/portage/*

CMD catalyst -f "stage1.spec" \
 && catalyst -f "stage3.spec"
