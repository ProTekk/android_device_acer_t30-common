$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device (TODO)
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# TODO: LtoDownloader

PRODUCT_AAPT_CONFIG := normal large xlarge hdpi
PRODUCT_AAPT_PREF_CONFIG := xlarge hdpi

DEVICE_PACKAGE_OVERLAYS += device/acer/t30-common/overlay

PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=wlan0 \
    ro.carrier=wifi-only

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Don't store dalvik on /cache, it gets annoying when /cache is wiped
# by the bootloader everytime we boot into recovery
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=96m \
    dalvik.vm.heapsize=384m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=8m

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
    device/acer/t30-common/prebuilt/ramdisk/init.picasso_m.rc:root/init.picasso_m.rc \
    device/acer/t30-common/prebuilt/ramdisk/fstab.picasso_mf:root/fstab.picasso_mf \
    device/acer/t30-common/prebuilt/ramdisk/init.picasso_mf.usb.rc:root/init.picasso_mf.usb.rc \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

PRODUCT_COPY_FILES += \
    device/acer/t30-common/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/acer/t30-common/prebuilt/etc/gps/gpsconfig.xml:system/etc/gps/gpsconfig.xml \
    device/acer/t30-common/prebuilt/usr/idc/acer-touch.idc:system/usr/idc/acer-touch.idc \
    device/acer/t30-common/prebuilt/usr/keylayout/Acer-AK00LB.kl:system/usr/keylayout/Acer-AK00LB.kl \
    device/acer/t30-common/prebuilt/usr/keylayout/Acer-ICONIA-TAB-KB01.kl:system/usr/keylayout/Acer-ICONIA-TAB-KB01.kl \
    device/acer/t30-common/prebuilt/usr/keylayout/acer-dock.kl:system/usr/keylayout/acer-dock.kl \
    device/acer/t30-common/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl

PRODUCT_PACKAGES := \
    audio.primary.tegra \
    libaudioutils \
    audio.a2dp.default \
    audio.usb.default \
    a1026_init \
    librs_jni \
    make_ext4fs \
    setup_fs \
    l2ping \
    hcitool \
    bttest \
    com.android.future.usb.accessory

PRODUCT_CHARACTERISTICS := tablet

# Device-specific packages
PRODUCT_PACKAGES += \
    DeviceParts

# Audio config
PRODUCT_COPY_FILES += \
    device/acer/t30-common/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf

# media config xml file
PRODUCT_COPY_FILES += \
    device/acer/t30-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/acer/t30-common/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml

# Bluetooth config file
PRODUCT_COPY_FILES += \
    system/bluetooth/data/main.nonsmartphone.conf:system/etc/bluetooth/main.conf \

WIFI_BAND := 802_11_BG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)
