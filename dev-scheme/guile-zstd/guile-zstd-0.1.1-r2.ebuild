# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="GNU Guile bindings to the zstd compression library"
HOMEPAGE="https://notabug.org/guile-zstd/guile-zstd/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://notabug.org/${PN}/${PN}.git"
else
	SRC_URI="https://notabug.org/${PN}/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"

# In zstd-1.5.5-r1 library was moved back from "/lib" to "/usr/lib".
RDEPEND="
	>=app-arch/zstd-1.5.5-r1
	>=dev-scheme/guile-2.0.0:=
"
DEPEND="
	${RDEPEND}
"

DOCS=( AUTHORS ChangeLog NEWS README )

# guile generates ELF files without use of C or machine code
# It's a portage's false positive. bug #677600
QA_PREBUILT='*[.]go'

src_prepare() {
	default
	eautoreconf

	# http://debbugs.gnu.org/cgi/bugreport.cgi?bug=38112
	find "${S}" -name "*.scm" -exec touch {} + || die
}

src_install() {
	default

	# Workaround llvm-strip problem of mangling guile ELF debug
	# sections: https://bugs.gentoo.org/905898
	dostrip -x "/usr/$(get_libdir)/guile"
}
