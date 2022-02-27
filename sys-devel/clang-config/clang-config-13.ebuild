# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility to use clang compiler system-wide"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64"

RDEPEND="sys-devel/clang:${PV}"

src_unpack() {
	mkdir ${S}
}

src_install() {
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/clang-${PV}		${EPREFIX}/usr/bin/cc
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/clang++-${PV}	${EPREFIX}/usr/bin/c++
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/clang-cpp-${PV}	${EPREFIX}/usr/bin/cpp

	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/clang-${PV}		${EPREFIX}/usr/bin/${CHOST}-cc
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/clang++-${PV}	${EPREFIX}/usr/bin/${CHOST}-c++
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/clang-cpp-${PV}	${EPREFIX}/usr/bin/${CHOST}-cpp
}

pkg_postrm() {
	if [ -x /usr/bin/gcc-config ]; then
		elog "Restoring old symlinks using gcc-config..."
		gcc-config -O
	else 
		ewarn "gcc-config not found! You must fix the symlinks manually"
	fi
}
