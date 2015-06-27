CFLAGS = -fobjc-arc -I../
ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PowerSaverSettings
PowerSaverSettings_FILES = $(shell find $(THEOS)/include/SettingsKit -name '*.m') Tweak.xm PowerSaverOptionsListController.mm
PowerSaverSettings_FRAMEWORKS = UIKit MessageUI Social QuartzCore CoreGraphics GraphicsServices
PowerSaverSettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"
