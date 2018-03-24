#
# Copyright (C) 2020-21 The Android Open-Source Project
# Copyright (C) 2020-21 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/asus/X00P

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8937
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 #STOPSHIP
BOARD_KERNEL_CMDLINE += androidboot.bootdevice=7824900.sdhci
BOARD_KERNEL_CMDLINE += earlycon=msm_hsl_uart,0x78B0000
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE :=  2048
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_TAGS_OFFSET := 0x00000100

BOARD_RAMDISK_OFFSET := 0x01000000

TARGET_KERNEL_SOURCE := kernel/asus/X00P
TARGET_KERNEL_CONFIG := X00P_defconfig
TARGET_KERNEL_CLANG_COMPILE := true

# Audio
BOARD_USES_ALSA_AUDIO := true
USE_CUSTOM_AUDIO_POLICY := 1
USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include
BOARD_HAVE_BLUETOOTH_QCOM := true
TARGET_USE_QTI_BT_STACK := true

# Camera
TARGET_USES_QTI_CAMERA_DEVICE := true

# Charger
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BOARD_CHARGER_ENABLE_SUSPEND := true

# Crypto
TARGET_HW_DISK_ENCRYPTION := true

# Display
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

TARGET_SCREEN_DENSITY := 380

TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true
TARGET_USES_ION := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

# Media
TARGET_USES_MEDIA_EXTENSIONS := true

# Partitions - SAR
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# Partitions - Boot
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864
BOARD_FLASH_BLOCK_SIZE := 131072

# Partitions - Cache
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE    := 157286400

# Partitions - System
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 3460300800
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4

# Partitions - Vendor
BOARD_VENDORIMAGE_PARTITION_SIZE   := 681574400
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_VENDOR := vendor

# Partitions - Recovery
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864

TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 80

# Partitions - Userdata
BOARD_USERDATAIMAGE_PARTITION_SIZE := 24892644864

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_ROOT_EXTRA_SYMLINKS := /vendor/dsp:/dsp
BOARD_ROOT_EXTRA_SYMLINKS += /vendor/firmware_mnt:/firmware
BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist

# Platform
TARGET_BOARD_PLATFORM := msm8937
TARGET_BOARD_PLATFORM_GPU := qcom-adreno505

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Sepolicy - Common
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += device/qcom/sepolicy/private
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += device/qcom/sepolicy/public

# Sepolicy - X00P
include device/asus/X00P-sepolicy/X00P-sepolicy.mk

# Telephony
TARGET_PROVIDES_QTI_TELEPHONY_JAR := true

# Treble
BOARD_VNDK_RUNTIME_DISABLE := true
BOARD_VNDK_VERSION := current

# Inherit from the proprietary version
include vendor/asus/X00P/BoardConfigVendor.mk
