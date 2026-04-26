TARGET_FIRMWARE_PATH="$FW_DIR/$(echo -n "$TARGET_FIRMWARE" | sed 's./._.g' | rev | cut -d "_" -f2- | rev)"

if [ -d "$TARGET_FIRMWARE_PATH/system/system/media/audio/pensounds" ]; then
    LOG_STEP_IN "- Adding Ultra device extra features"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/app/AirGlance/AirGlance.apk" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/app/LiveDrawing/LiveDrawing.apk" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" \
        "system/etc/default-permissions/default-permissions-com.samsung.android.service.aircommand.xml" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" \
        "system/etc/permissions/privapp-permissions-com.samsung.android.app.readingglass.xml" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" \
        "system/etc/permissions/privapp-permissions-com.samsung.android.service.aircommand.xml" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" \
        "system/etc/permissions/privapp-permissions-com.samsung.android.service.airviewdictionary.xml" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/etc/sysconfig/airviewdictionaryservice.xml" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/etc/public.libraries-smps.samsung.txt" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/lib/libandroid_runtime.so" 0 0 644 "u:object_r:system_lib_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/lib/libsmpsft.smps.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/lib64/libandroid_runtime.so" 0 0 644 "u:object_r:system_lib_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/lib64/libsmpsft.smps.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/media/audio/pensounds" 0 0 755 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/priv-app/AirCommand/AirCommand.apk" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/priv-app/AirReadingGlass/AirReadingGlass.apk" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system" "system/priv-app/SmartEye/SmartEye.apk" 0 0 644 "u:object_r:system_file:s0"
else
    LOG "- Target device is not an Ultra variant. Ignoring"
fi
    LOG_STEP_OUT
