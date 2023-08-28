#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/realme/ossi

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# A/B
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor

PRODUCT_PACKAGES += \
    otapreopt_script \
    checkpoint_gc \
    update_engine \
    update_engine_sideload \
    update_verifier

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true
    
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Boot control HAL
PRODUCT_PACKAGES += \
	android.hardware.boot@1.2-impl \
	android.hardware.boot@1.2-service \
	android.hardware.boot@1.2.recovery \
	bootctrl.mt6877

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl:64

PRODUCT_PACKAGES += \
    libkeymaster4.vendor \
    libkeymaster4_1support.vendor \
    libpuresoftkeymasterdevice.vendor \
    libsoft_attestation_cert.vendor

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl \
    android.hardware.gnss@2.1.vendor \
    libcurl

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.base@1.0.vendor \
    android.hidl.allocator@1.0.vendor \
    android.hidl.memory.block@1.0 \
    android.hidl.memory.block@1.0.vendor \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder.vendor

PRODUCT_PACKAGES += \
    libcodec2_hidl@1.1.vendor \
    libcodec2_hidl@1.2.vendor \
    libcodec2_hidl_plugin.vendor \
    libstagefright_softomx_plugin.vendor \
    libsfplugin_ccodec_utils.vendor \
    libcodec2_soft_common.vendor \
    libavservices_minijail \
    libavservices_minijail_vendor

# Neural Networks
PRODUCT_PACKAGES += \
    libruy \
    android.hardware.neuralnetworks@1.0.vendor \
    android.hardware.neuralnetworks@1.1.vendor \
    android.hardware.neuralnetworks@1.2.vendor \
    android.hardware.neuralnetworks@1.3.vendor

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock

PRODUCT_PACKAGES += \
    libtextclassifier_hash.vendor

# Pcap
PRODUCT_PACKAGES += \
    libpcap.vendor

PRODUCT_PACKAGES += \
    android.hardware.power-V1.vendor \
    android.hardware.power-V1-ndk_platform.vendor \
    android.hardware.power@1.0.vendor \
    android.hardware.power@1.1.vendor \
    android.hardware.power@1.3.vendor

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml

# Init
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/init/hw/init.mt6877.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.mt6877.rc \
    $(DEVICE_PATH)/init/hw/init.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.mt6877.rc

# Public libraries
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Renderscript
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Secure Element
PRODUCT_PACKAGES += \
    SecureElement \
    android.hardware.secure_element@1.0.vendor \
    android.hardware.secure_element@1.1.vendor \
    android.hardware.secure_element@1.2.vendor \
    libchrome.vendor

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    oplus/ossi

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure.recovery=0
