# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/dacyberduck/clang-config.git"
	inherit git-r3
else
	SRC_URI="https://github.com/dacyberduck/clang-config/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="amd64"
fi

DESCRIPTION="Utility to manage compilers"
HOMEPAGE="https://github.com/dacyberduck/clang-config.git/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+cc-wrappers +native-symlinks"

RDEPEND=">=sys-apps/gentoo-functions-0.10"

_emake() {
	emake \
		PV="${PVR}" \
		SUBLIBDIR="$(get_libdir)" \
		USE_CC_WRAPPERS="$(usex cc-wrappers)" \
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
	# Do we have a valid multi ver setup ?
	local x
	for x in $(clang-config -C -l 2>/dev/null | awk '$NF == "*" { print $2 }') ; do
		clang-config ${x}
	done

	# USE flag change can add or delete files in /usr/bin worth recaching
	if [[ ! ${ROOT} && -f ${EPREFIX}/usr/share/eselect/modules/compiler-shadow.eselect ]] ; then
		eselect compiler-shadow update all
	fi
}
