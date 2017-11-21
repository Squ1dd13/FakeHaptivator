ARCHS = armv7 arm64
TARGET = iphone:clang: 9.3:7.0
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FakeHaptivator
FakeHaptivator_FILES = Tweak.xm
FakeHaptivator_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
