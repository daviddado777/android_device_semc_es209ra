ifeq ($(BUILD_SEMC_SENORS),true)

LOCAL_PATH := $(call my-dir)

# HAL module implemenation, not prelinked and stored in
# hw/<SENSORS_HARDWARE_MODULE_ID>.<ro.product.board>.so
include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_SHARED_LIBRARIES := \
			liblog \
			libcutils

LOCAL_SRC_FILES += 	sensors_module.c \
			sensors_list.c \
			sensors_fifo.c \
			sensors_config.c \
			sensors_worker.c \
			sensors_select.c \
			sensors_wrapper.c \
			sensors/sensor_util.c

LOCAL_CFLAGS += -I$(LOCAL_PATH)/sensors

include $(LOCAL_PATH)/sensors/Sensors.mk
LOCAL_SRC_FILES += $(patsubst %,sensors/%, $(DASH_SENSORS))
LOCAL_CFLAGS += $(DASH_SENSORS_CFLAGS)
LOCAL_STATIC_LIBRARIES += $(DASH_SENSORS_STATIC_LIBS)
LOCAL_SHARED_LIBRARIES += $(DASH_SENSORS_SHARED_LIBS)

LOCAL_MODULE := sensors.es209ra
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

include $(call first-makefiles-under, $(LOCAL_PATH)/libs)

endif
