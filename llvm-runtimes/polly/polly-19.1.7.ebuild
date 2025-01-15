# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit cmake linux-info llvm llvm.org python-single-r1

DESCRIPTION="Polyhedral optimizations for LLVM"
HOMEPAGE="https://llvm.org/"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA"
SLOT="$(ver_cut 1)"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

PDEPEND="llvm-core/llvm:${SLOT}="
BDEPEND="
	${PYTHON_DEPS}
	>=dev-build/cmake-3.16
	test? ( >=dev-python/lit-9.0.1 )
"

LLVM_COMPONENTS=( polly cmake )
llvm.org_set_globals

pkg_setup() {
	LLVM_MAX_SLOT=${SLOT} llvm_pkg_setup
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_BUILD_TESTS=$(usex test)
		-DPython3_EXECUTABLE="${PYTHON}"
		-DLLVM_POLLY_LINK_INTO_TOOLS=OFF
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/${SLOT}"
		-DCMAKE_PREFIX_PATH="${EPREFIX}/usr/lib/llvm/${SLOT}/$(get_libdir)/cmake/llvm"
	)
	use test && mycmakeargs+=(
		-DLLVM_LIT_ARGS="$(get_lit_flags)"
		-DLLVM_EXTERNAL_LIT="${EPREFIX}/usr/bin/lit"
	)

	cmake_src_configure
}

src_test() {
	local -x LIT_PRESERVES_TMP=1
	cmake_build check-polly
}
