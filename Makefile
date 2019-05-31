lethargyARCHS = arm64
TARGET = appletv
export GO_EASY_ON_ME=1
export SDKVERSION=10,1
THEOS_DEVICE_IP=bedroom.local
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = lethargy
lethargy_FILES = fuckYoCouch.xm
lethargy_LIBRARIES = substrate
lethargy_FRAMEWORKS = Foundation UIKit
lethargy_PRIVATE_FRAMEWORKS = MediaRemote
#lethargy_LDFLAGS = -undefined dynamic_lookup

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
