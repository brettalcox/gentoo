# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="bin lib profile" # duplicate symbols: haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Tools to build the Gtk2Hs suite of User Interface libraries"
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+closuresignals"

RDEPEND=">=dev-haskell/cabal-1.24.0.0:=[profile?] <dev-haskell/cabal-1.25:=[profile?]
	dev-haskell/hashtables:=[profile?]
	dev-haskell/random:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	dev-haskell/alex
	>=dev-haskell/cabal-1.18.1.3
	dev-haskell/happy
"

PATCHES=("${FILESDIR}"/${PN}-0.13.1.0-ia64.patch)

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag closuresignals closuresignals)
}
