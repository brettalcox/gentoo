# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/isc-projects/${PN}.git"

inherit git-r3 flag-o-matic

DESCRIPTION="Ethernet NIC Queue stats viewer"
HOMEPAGE="https://github.com/isc-projects/ethq"

LICENSE="MPL-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="sys-libs/ncurses:="
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# respect FLAGS, remove Werror and strip
	sed -i  -e '/CXXFLAGS/s/= -O3/+=/' \
		-e '/CXXFLAGS/s/ -Werror//' \
		-e '/LDFLAGS/s/= -s/+=/' Makefile || die "sed failed for Makefile"

	if ! use test ; then
		sed -i '/TARGETS/s/ethq_test//' Makefile \
			|| die "sed failed for USE flag test"
	fi
}

src_configure() {
	# https://github.com/isc-projects/ethq/issues/30 (bug #879893)
	filter-lto

	default
}

src_test() {
	local driver
	for driver in tests/* ; do
		"${S}"/ethq_test "$(basename "${driver%%-*}")" "${driver}" \
			|| die "test failed on ${driver}"
	done
}

src_install() {
	einstalldocs
	dobin ethq
}
