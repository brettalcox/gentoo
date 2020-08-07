# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="a library for command line parsing & online help"
HOMEPAGE="https://hackage.haskell.org/package/cmdlib"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/mtl-2:=[profile?]
		>=dev-haskell/transformers-0.2.2:=[profile?]
		dev-haskell/split:=[profile?]
		dev-haskell/syb:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/${PN}-0.3.4-ghc-6.12.patch")

src_configure() {
	haskell-cabal_src_configure \
		--flag=mtl2 \
		--flag=-test
}
