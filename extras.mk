# extras typically found in lineage_<codename>.mk

# ViPER4Android (if exists)
$(call inherit-product-if-exists, packages/apps/ViPER4AndroidFX/config.mk)

# Do things if GMS added
ifeq ($(strip $(WITH_GMS)),true)
	USES_BASIC_CALL_RECORDER := true
endif

# Detect risingOS dir
ifeq ("$(wildcard $(vendor/rising))", "")

# Do things if GMS added (in risingOS)
ifeq ($(strip $(WITH_GMS)),true)
    TARGET_DEFAULT_PIXEL_LAUNCHER := true
endif

TARGET_PREBUILT_LAWNCHAIR_LAUNCHER := true

RISING_MAINTAINER := hiroshi. (Superuser)

PRODUCT_BUILD_PROP_OVERRIDES += \
    RISING_CHIPSET="Dimensity 1080" \
    RISING_MAINTAINER="$(RISING_MAINTAINER)"

PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pixelprops.gms=true 

PRODUCT_PACKAGES += \
     SettingsIntelligenceGooglePrebuilt
endif

# Detect Evolution X 
ifeq (,$(findstring EvolutionX, $(LINEAGE_VERSION)))
    $(warning we are evolving!)
    PRODUCT_PACKAGES += \
        EvolutionSettingsOverlayRuby
endif

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

ifeq ($(strip $(USES_BASIC_CALL_RECORDER)),true)
    $(call inherit-product, vendor/bcr/bcr.mk)
endif
