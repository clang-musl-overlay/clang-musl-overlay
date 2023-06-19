# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Locale program for musl libc"
HOMEPAGE="https://git.adelielinux.org/adelie/musl-locales"
EGIT_REPO_URI="https://git.adelielinux.org/adelie/musl-locales.git"

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!sys-libs/glibc"

src_configure() {
	local mycmakeargs=(
		-DLOCALE_PROFILE=OFF
	)
	cmake_src_configure
}
