# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Patches to fix issues related to the clang-musl overlay"
HOMEPAGE="https://github.com/clang-musl-overlay/gentoo-patchset"
HASH_COMMIT="90f2471dc53127d58e4c70c4385ec121aaee4494"
SRC_URI="https://github.com/clang-musl-overlay/gentoo-patchset/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 amd64"

src_install() {
        insinto `portageq get_repo_path / gentoo`
        doins -r gentoo-patchset-${HASH_COMMIT}/*
}
