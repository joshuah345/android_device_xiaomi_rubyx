# extras typically found in lineage_garnet.mk

# ViPER4Android (if exists)
$(call inherit-product-if-exists, packages/apps/ViPER4AndroidFX/config.mk)

# Do things if GMS added
ifeq ($(strip $(WITH_GMS)),true)

	# import BCR
    $(call inherit-product-if-exists, vendor/bcr/bcr.mk)

	# rising specific
    TARGET_DEFAULT_PIXEL_LAUNCHER := true
endif

# Include Lawnchair 14 (rising)
TARGET_PREBUILT_LAWNCHAIR_LAUNCHER := true

PRODUCT_BUILD_PROP_OVERRIDES += \
    RISING_CHIPSET="Dimensity 1080" \
    RISING_MAINTAINER="hiroshi. (Superuser)"

PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pixelprops.gms=true 

RISING_MAINTAINER := hiroshi. (Superuser)

# -------
TARGET_SUPPORTS_BLUR := true

TARGET_USES_DOLBY := true

ifeq ($(strip $(TARGET_USES_DOLBY)),true)
ifeq ($(strip $(TARGET_DOLBY_VENDOR)),)
  $(warning TARGET_USES_DOLBY is set to true but no type was set. Defaulting to XiaomiDolby...)
  PRODUCT_PACKAGES += \
    XiaomiDolby.rubyx
else 
ifeq ($(strip $(TARGET_DOLBY_VENDOR)), MOTO)
    $(call inherit-product, vendor/dolby_moto/dolby.mk)
endif
endif
endif

 PRODUCT_PACKAGES += \
     SettingsIntelligenceGooglePrebuilt
