# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/clang-musl-overlay/llvm-conf.git"
	inherit git-r3
else
	SRC_URI="https://github.com/clang-musl-overlay/llvm-conf/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="amd64"
fi

DESCRIPTION="Utility to manage llvm profiles"
HOMEPAGE="https://github.com/clang-musl-overlay/llvm-conf.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="+binutils-wrappers +clang-wrappers +native-symlinks"

RDEPEND="
	>=sys-apps/gentoo-functions-0.10
	sys-devel/llvm
	clang-wrappers? ( sys-devel/clang )
"

_emake() {
	emake \
		PV="${PVR}" \
		SUBLIBDIR="$(get_libdir)" \
		USE_CLANG_WRAPPERS="$(usex clang-wrappers)" \
		USE_BINUTILS_WRAPPERS="$(usex binutils-wrappers)" \
		USE_NATIVE_LINKS="$(usex native-symlinks)" \
		TOOLCHAIN_PREFIX="${CHOST}-" \
		"$@"
}

src_compile() {
	_emake
}

src_install() {
	_emake DESTDIR="${D}" install
}

pkg_postinst() {
	# Do we have a valid setup ?
	if ! llvm-conf -C -c >/dev/null 2>&1  ; then
		llvm-conf latest
	fi
}
