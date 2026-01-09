GSTREAMER1p0_PLUGINS_GOOD_1p26_ARAGO = ""
GSTREAMER1p0_PLUGINS_GOOD_1p26_ARAGO:arago = "gstreamer1.0-plugins-good_1.26-arago.inc"

require ${GSTREAMER1p0_PLUGINS_GOOD_1p26_ARAGO}

PACKAGECONFIG:append = " ${@bb.utils.contains('BBFILE_COLLECTIONS', 'qt6-layer', 'qt6', '', d)}"

QT6WAYLANDDEPENDS = "${@bb.utils.contains("DISTRO_FEATURES", "wayland", "qtwayland", "", d)}"

PACKAGECONFIG[qt6] = "-Dqt6=enabled, -Dqt6=disabled, qtbase qtbase-native qtdeclarative qttools-native ${QT6WAYLANDDEPENDS}"

# Qt tools like rcc, moc and uic are located in /usr/libexec, instead of
# /usr/bin, which is not in PATH by default.
do_configure:prepend:class-target() {
	export PATH=${STAGING_DIR_NATIVE}${libexecdir}:$PATH
}
