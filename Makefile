ARCHS = arm64
TARGET = appletv:10.2.2:10.2.22
export GO_EASY_ON_ME=1
THEOS_DEVICE_IP=guest-room.local
DEBUG=0
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
