# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Patches to fix issues related to the clang-musl overlay"
HOMEPAGE="https://github.com/leonardohn/gentoo-patchset"
SRC_URI="https://github.com/leonardohn/gentoo-patchset/archive/refs/heads/main.zip"

S="${WORKDIR}"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~amd64"

pkg_setup() {
        fetch ${SRC_URI}
}

src_unpack() {
        unpack main.zip
}

src_install() {
        insinto /etc/portage/patches/
        doins -r gentoo-patchset-main/*
}
