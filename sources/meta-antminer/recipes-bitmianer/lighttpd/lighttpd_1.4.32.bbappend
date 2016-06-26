FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-1.0:"

PRINC := "${@int(PRINC) + 1}"

RDEPENDS_${PN} += " \
               lighttpd-module-auth \
               lighttpd-module-cgi \
               lighttpd-module-expire \
"

do_install_append() {
    update-rc.d -r ${D} lighttpd start 60 S .
    install -m 0755 ${WORKDIR}/lighttpd.conf ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/lighttpd-htdigest.user ${D}${sysconfdir}
    if [ x"YES" == x"${Miner_Monitor}" ]; then
        cp -pr ${WORKDIR}/www_miner/* ${D}/www/pages
    else
	cp -pr ${WORKDIR}/www/* ${D}/www/pages
    fi
#mkdir ${D}/www/tmpl
#   cp -pr ${WORKDIR}/tmpl/* ${D}/www/tmpl
	if [ x"C1" == x"${Miner_TYPE}" ]; then
		rm ${D}/www/pages/cgi-bin/minerAdvanced.cgi
		mv ${D}/www/pages/cgi-bin/minerAdvanced_c1.cgi ${D}/www/pages/cgi-bin/minerAdvanced.cgi
	elif [ x"C2" == x"${Miner_TYPE}" ]; then
        	rm ${D}/www/pages/cgi-bin/minerAdvanced.cgi
        	mv ${D}/www/pages/cgi-bin/minerAdvanced_c2.cgi ${D}/www/pages/cgi-bin/minerAdvanced.cgi
	elif [ x"S5" == x"${Miner_TYPE}" ]; then
        	rm ${D}/www/pages/cgi-bin/minerAdvanced.cgi
        	mv ${D}/www/pages/cgi-bin/minerAdvanced_s5.cgi ${D}/www/pages/cgi-bin/minerAdvanced.cgi
	elif [ x"S4+" == x"${Miner_TYPE}" ]; then
        	rm ${D}/www/pages/cgi-bin/minerAdvanced.cgi
        	mv ${D}/www/pages/cgi-bin/minerAdvanced_s4_p.cgi ${D}/www/pages/cgi-bin/minerAdvanced.cgi
	elif [ x"S5+" == x"${Miner_TYPE}" ]; then
        	rm ${D}/www/pages/cgi-bin/minerAdvanced.cgi
        	mv ${D}/www/pages/cgi-bin/minerAdvanced_s5_p.cgi ${D}/www/pages/cgi-bin/minerAdvanced.cgi
	elif [ x"S7" == x"${Miner_TYPE}" -o x"S7+" == x"${Miner_TYPE}" ]; then
        	rm ${D}/www/pages/minerConfiguration.html
        	mv ${D}/www/pages/minerConfiguration_s7.html ${D}/www/pages/minerConfiguration.html
        	rm ${D}/www/pages/cgi-bin/minerAdvanced.cgi
        	mv ${D}/www/pages/cgi-bin/minerAdvanced_s7.cgi ${D}/www/pages/cgi-bin/minerAdvanced.cgi
        	rm ${D}/www/pages/cgi-bin/set_monitor_conf.cgi
        	mv ${D}/www/pages/cgi-bin/set_monitor_conf_s7.cgi ${D}/www/pages/cgi-bin/set_monitor_conf.cgi
        	rm ${D}/www/pages/cgi-bin/set_miner_conf.cgi
        	mv ${D}/www/pages/cgi-bin/set_miner_conf_s7.cgi ${D}/www/pages/cgi-bin/set_miner_conf.cgi
        	rm ${D}/www/pages/cgi-bin/minerConfiguration.cgi
        	mv ${D}/www/pages/cgi-bin/minerConfiguration_s7.cgi ${D}/www/pages/cgi-bin/minerConfiguration.cgi
        	rm ${D}/www/pages/cgi-bin/minerStatus.cgi
        	mv ${D}/www/pages/cgi-bin/minerStatus_s7.cgi ${D}/www/pages/cgi-bin/minerStatus.cgi
	else
		echo "S4"
	fi
	rm -f ${D}/www/pages/minerConfiguration_*.html
	rm -f ${D}/www/pages/cgi-bin/minerAdvanced_*.cgi
	rm -f ${D}/www/pages/cgi-bin/set_monitor_conf_*.cgi
	rm -f ${D}/www/pages/cgi-bin/set_miner_conf_*.cgi
	rm -f ${D}/www/pages/cgi-bin/minerConfiguration_*.cgi
	rm -f ${D}/www/pages/cgi-bin/minerStatus_*.cgi
}

SRC_URI_append = " file://lighttpd.conf"
SRC_URI_append = " file://lighttpd-htdigest.user"
SRC_URI_append = " file://www"
SRC_URI_append = " file://www_miner"
