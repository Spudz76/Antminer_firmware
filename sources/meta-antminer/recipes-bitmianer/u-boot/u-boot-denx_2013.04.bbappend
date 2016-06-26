FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append = " file://fw_env.config"
PACKAGES =+ "u-boot-denx-fwenv"
FILES_${PN} += "${sysconfdir}/* ${base_sbindir}/*"
FILES_u-boot-denx-fwenv = "${sysconfdir}/fw_env.config ${base_sbindir}/fw_printenv ${base_sbindir}/fw_setenv"

do_compile_append () {
	oe_runmake 'HOSTCC=${CC}' 'HOSTSTRIP=${STRIP}' env
}
 
do_install_append () {
	install -d ${D}${sysconfdir}
	install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/
	install -d ${D}${base_sbindir}
	install -m 755 ${S}/tools/env/fw_printenv ${D}${base_sbindir}/fw_printenv
	ln -sf ${base_sbindir}/fw_printenv ${D}${base_sbindir}/fw_setenv
 
}
 
