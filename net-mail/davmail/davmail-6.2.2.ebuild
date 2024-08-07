# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

#inherit user

DESCRIPTION="DavMail POP/IMAP/SMTP/Caldav/Carddav/LDAP Exchange Gateway"
HOMEPAGE="http://davmail.sourceforge.net/"
REV=3546
MY_PN="${PN}"
MY_PV="${PV}"
MY_P="${MY_PN}-${PV}"

#URL_32="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}-${REV}.zip"
#URL_64="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}-${REV}.zip"
URL_32="https://sourceforge.net/projects/${MY_PN}/files/${MY_PN}/${MY_PV}/${MY_PN}-${MY_PV}-${REV}.zip/download"
URL_64="https://sourceforge.net/projects/${MY_PN}/files/${MY_PN}/${MY_PV}/${MY_PN}-${MY_PV}-${REV}.zip/download"

SRC_URI="
        amd64? ( ${URL_64} )
        x86? ( ${URL_32} )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}"

#PATCHES=(
#	"${FILESDIR}/${PN}-5.5.1.patch"
#)

src_prepare() {
	default
}

src_unpack() {
	unpack ${A}
}

src_install () {

	local TARGETDIR="/opt/davmail"
	dodir "${TARGETDIR}"
	insinto "${TARGETDIR}"/

    doins -r ${S}/*  || die "Install failed!"
    
	fowners root:users -R "${TARGETDIR}" || die "Could not change ownership of /opt/davmail directory."

	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/davmail.png || die "Could not copy davmail.png"

	return
}

pkg_postinst() {

	chmod 755 /opt/davmail/davmail || die "Could not set file permissions on davmail.sh file"
	/opt/davmail/davmail azul || die "Could not install the java environment"
	return
}

pkg_postrm() {

	return
}
