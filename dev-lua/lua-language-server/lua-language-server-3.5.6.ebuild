# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua-single ninja-utils toolchain-funcs

DESCRIPTION="Lua Language Server written in Lua"
HOMEPAGE="https://github.com/sumneko/${PN}"
if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
	BDEPEND="dev-build/ninja"
else
	SRC_URI="${HOMEPAGE}/releases/download/${PV}/${P}-submodules.zip"
	KEYWORDS="amd64 x86"
	BDEPEND="
		app-arch/unzip
		dev-build/ninja
	"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RESTRICT="strip !test? ( test )"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-copy_binary.patch" )

S="${WORKDIR}"

src_prepare() {
	sed -i "s/-lstdc++fs//g;s/-static-libgcc//g;s/-Wl,-Bstatic//g;" \
		3rd/luamake/compile/ninja/linux.ninja || die
	sed -i "s/-Wno-maybe-uninitialized/-Wno-uninitialized/g" \
		3rd/luamake/compile/ninja/linux.ninja || die
	sed -i "s/^cc = gcc$/cc = $(tc-getCC)/;s/-lstdc++/-lc++/g;" \
		3rd/luamake/compile/ninja/linux.ninja || die
	sed -i "s/-lstdc++/-lc++/g" \
		3rd/luamake/scripts/compiler/gcc.lua || die
	sed -i "s/-Wno-maybe-uninitialized/-Wno-uninitialized/g" \
		3rd/bee.lua/compile/common.lua || die
	sed -i "/links = \"stdc++fs\"/d" \
		3rd/bee.lua/compile/common.lua || die
	sed -i "s/flags = \"-Wall -Werror\"/flags = \"-Wall ${CXXFLAGS}\"/" \
		make/code_format.lua || die
	sed -i "/require \"make.detect_platform\"/a lm.cc = '$(tc-getCC)'" \
		make.lua || die
	sed -i "s/crt = \"static\"/crt = \"dynamic\"/" \
		make.lua || die

	default
}

src_compile() {
	einfo "Building luamake..."
	eninja -C 3rd/luamake -f compile/ninja/linux.ninja $(usex test '' 'luamake') \
		|| die "failed to build luamake"
	einfo "Building ${PN}..."
	./3rd/luamake/luamake $(usex test '' 'all') \
		|| die "failed to build ${PN}"
}

src_install() {
	newbin "${FILESDIR}/${PN}.sh" "${PN}"
	into "/usr/libexec/${PN}"
	dobin "bin/${PN}" bin/main.lua
	insinto "/usr/libexec/${PN}"
	doins -r main.lua debugger.lua locale script meta
}
