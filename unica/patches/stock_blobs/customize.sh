SOURCE_FIRMWARE_PATH="$FW_DIR/$(echo -n "$SOURCE_FIRMWARE" | sed 's./._.g' | rev | cut -d "_" -f2- | rev)"
TARGET_FIRMWARE_PATH="$FW_DIR/$(echo -n "$TARGET_FIRMWARE" | sed 's./._.g' | rev | cut -d "_" -f2- | rev)"

# "Replacing saiv blobs with stock"
DELETE_FROM_WORK_DIR "system" "system/saiv"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE_PATH" "system" "system/saiv" 0 0 755 "u:object_r:system_file:s0"
DELETE_FROM_WORK_DIR "system" "system/saiv/face"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE_PATH" "system" "system/saiv/face" 0 0 755 "u:object_r:system_file:s0"
DELETE_FROM_WORK_DIR "system" "system/saiv/textrecognition"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE_PATH" "system" "system/saiv/textrecognition" 0 0 755 "u:object_r:system_file:s0"

# "Replacing cameradata blobs with stock"
DELETE_FROM_WORK_DIR "system" "system/cameradata"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE_PATH" "system" "system/cameradata" 0 0 755 "u:object_r:system_file:s0"
DELETE_FROM_WORK_DIR "system" "system/cameradata/preloadfilters"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE_PATH" "system" "system/cameradata/preloadfilters" 0 0 755 "u:object_r:system_file:s0"
DELETE_FROM_WORK_DIR "system" "system/cameradata/myfilter"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE_PATH" "system" "system/cameradata/myfilter" 0 0 755 "u:object_r:system_file:s0"

# "Replacing gamebooster props with stock"
SET_PROP "product" "ro.gfx.driver.0" "$(GET_PROP "$WORK_DIR/vendor/build.prop" "ro.gfx.driver.0")"
SET_PROP "product" "ro.gfx.driver.1" "$(GET_PROP "$WORK_DIR/vendor/build.prop" "ro.gfx.driver.1")"

# Replacing main stuff
ADD_TO_WORK_DIR "$TARGET_FIRMWARE_PATH" "system" "system/framework/ssrm.jar" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE_PATH" "system" "system/priv-app/SamsungDeviceHealthManagerService/SamsungDeviceHealthManagerService.apk" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE_PATH" "system" "system/apex/com.android.bt.apex" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE_PATH" "system_ext" "bin/qcrosvm" 0 0 644 "u:object_r:system_file:s0"


