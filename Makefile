ARCHS = armv7 arm64
CFLAGS = -fobjc-arc
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PowerSaver
PowerSaver_FILES = $(wildcard *.mm) $(wildcard *.xm) $(wildcard toggles/*.xm)
PowerSaver_FRAMEWORKS = UIKit CoreTelephony CoreLocation 
PowerSaver_PRIVATE_FRAMEWORKS = GraphicsServices Preferences
PowerSaver_LDFLAGS = -lAccessibility
PowerSaver_CFLAGS += -I.

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += powersaverflipswitch
SUBPROJECTS += powersaversettings
include $(THEOS_MAKE_PATH)/aggregate.mk
