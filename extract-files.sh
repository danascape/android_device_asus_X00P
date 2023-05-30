#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0

if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

# Required!
DEVICE=X00P
VENDOR=asus

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        product/lib64/lib-imsvideocodec.so)
            for LIBGUI_SHIM in $(grep -L "libgui_shim.so" "${2}"); do
                "${PATCHELF}" --add-needed "libgui_shim.so" "${LIBGUI_SHIM}"
            done
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}"/proprietary-files.txt "${SRC}" \
        "${KANG}" --section "${SECTION}"

DEVICE_BLOB_ROOT="${ANDROID_ROOT}"/vendor/"${VENDOR}"/"${DEVICE}"/proprietary

#
# Fix xml version
#
function fix_xml_version () {
    sed -i \
        's/xml version="2.0"/xml version="1.0"/' \
        "$DEVICE_BLOB_ROOT"/"$1"
}

fix_xml_version product/etc/permissions/vendor.qti.hardware.data.connection-V1.0-java.xml
fix_xml_version product/etc/permissions/vendor.qti.hardware.data.connection-V1.1-java.xml

for blob in libarcsoft_nighthawk.so libarcsoft_piczoom.so libarcsoft_videostab.so libarcsoft_night_shot.so; do
    patchelf --remove-needed "libandroid.so" "$DEVICE_BLOB_ROOT/vendor/lib/$blob"
done
