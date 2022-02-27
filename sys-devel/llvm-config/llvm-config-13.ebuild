# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility to use clang compiler system-wide"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64"

RDEPEND="sys-devel/llvm:${PV}"

src_unpack() {
	mkdir ${S}
}

src_install() {
	dosym ${EPREFIX}/usr/bin/lld							${EPREFIX}/usr/bin/ld
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-addr2line	${EPREFIX}/usr/bin/addr2line
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-ar			${EPREFIX}/usr/bin/ar
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-cxxfilt	${EPREFIX}/usr/bin/c++filt
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-dlltool	${EPREFIX}/usr/bin/dlltool
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-dwp		${EPREFIX}/usr/bin/dwp
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-mc			${EPREFIX}/usr/bin/as
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-mt			${EPREFIX}/usr/bin/mt
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-nm			${EPREFIX}/usr/bin/nm
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-objcopy	${EPREFIX}/usr/bin/objcopy
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-objdump	${EPREFIX}/usr/bin/objdump
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-ranlib		${EPREFIX}/usr/bin/ranlib
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-readelf	${EPREFIX}/usr/bin/readelf
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-size		${EPREFIX}/usr/bin/size
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-strings	${EPREFIX}/usr/bin/strings
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-strip		${EPREFIX}/usr/bin/strip

	dosym ${EPREFIX}/usr/bin/lld							${EPREFIX}/usr/bin/${CHOST}-ld
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-addr2line	${EPREFIX}/usr/bin/${CHOST}-addr2line
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-ar			${EPREFIX}/usr/bin/${CHOST}-ar
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-cxxfilt	${EPREFIX}/usr/bin/${CHOST}-c++filt
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-dlltool	${EPREFIX}/usr/bin/${CHOST}-dlltool
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-dwp		${EPREFIX}/usr/bin/${CHOST}-dwp
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-mc			${EPREFIX}/usr/bin/${CHOST}-as
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-mt			${EPREFIX}/usr/bin/${CHOST}-mt
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-nm			${EPREFIX}/usr/bin/${CHOST}-nm
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-objcopy	${EPREFIX}/usr/bin/${CHOST}-objcopy
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-objdump	${EPREFIX}/usr/bin/${CHOST}-objdump
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-ranlib		${EPREFIX}/usr/bin/${CHOST}-ranlib
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-readelf	${EPREFIX}/usr/bin/${CHOST}-readelf
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-size		${EPREFIX}/usr/bin/${CHOST}-size
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-strings	${EPREFIX}/usr/bin/${CHOST}-strings
	dosym ${EPREFIX}/usr/lib/llvm/${PV}/bin/llvm-strip		${EPREFIX}/usr/bin/${CHOST}-strip
}

pkg_postrm() {
	if [ -x /usr/bin/binutils-config ]; then
		einfo "Restoring old gnu binutils..."
		binutils-config $(binutils-config -c)
	else
		ewarn "binutils-config missing! You must manually fix the symlinks"
	fi
}
