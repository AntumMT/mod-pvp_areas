#!/bin/bash

PARAM=$1

SCRIPT="$(basename $(readlink -f $0))"

if [ "${PARAM}" == "help" ]; then
	echo -e "\nUsage:"
	echo -e "\t${SCRIPT} [option]"
	echo -e "\nOptions:"
	echo -e "\thelp:\tShow this help information."
	echo -e "\tclean:\tOnly clean old files. Don't generate new docs."
	exit 0
fi

DOCS="$(dirname $(readlink -f $0))"
ROOT="$(dirname ${DOCS})"
CONFIG="${DOCS}/config.ld"

cd "${ROOT}"

# Clean old files
echo -e "\nCleaning old files ..."
rm -rf "${DOCS}/api.html" "${DOCS}/scripts" "${DOCS}/modules" "${DOCS}/ldoc.css"

if [ "${PARAM}" != "clean" ]; then
	# Create new files
	echo -e "\nGenerating new documentation ..."
	ldoc -c "${CONFIG}" -d "${DOCS}" "${ROOT}"
	
	if [ -f "${DOCS}/api.html" ]; then
		# Put "prefix:name_" settings in angled brackets (<>)
		sed -i -e 's|>prefix:name|>\&lt;prefix\&gt;:\&lt;name\&gt;|' "${DOCS}/api.html"
	fi
fi
