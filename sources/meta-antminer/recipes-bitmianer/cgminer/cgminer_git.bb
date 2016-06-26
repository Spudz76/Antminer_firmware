DESCRIPTION = "Cgminer bitcoin miner SW"
LICENSE = "GPLv3 & bzip2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

DEPENDS = "ncurses curl udev"

SRCREV = "HEAD"
PV = "${SRCREV}+git${SRCPV}"
PR = "r1"
SRC_URI = "git://github.com/ckolivas/cgminer.git;protocol=https;branch=master"
S = "${WORKDIR}/git"

#CFLAGS_prepend = "-I ${S}/compat/jansson -I ${S}/compat/libusb-1.0/libusb"
#CFLAGS_prepend = "-I ${S}/compat/jansson-2.5/src -I ${S}/compat/libusb-1.0/libusb"
CFLAGS_prepend = "-I ${S}/compat/jansson-2.6/src -I ${S}/compat/libusb-1.0/libusb"
#TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/usr/lib
#--with-sysroot=${prefix}/${TARGET_SYS}
#--with-system-libusb

EXTRA_OECONF = " \
	     --enable-ants3 \
	     --disable-adl \
	     --disable-opencl \
	     "
		 
do_configure_prepend() {
	autoreconf -fiv
}

do_compile_append() {
	make api-example
}

do_install_append() {
        install -d ${D}${bindir}
        install -m 0755 ${S}/api-example ${D}${bindir}/cgminer-api
}
 
inherit autotools pkgconfig
