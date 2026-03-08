    LOG_STEP_IN "- Replacing GameDriver"
    DELETE_FROM_WORK_DIR "system" "system/priv-app/GameDriver-SM8450/GameDriver-SM8650.apk"
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/priv-app/GameDriver-SM8450/GameDriver-SM8450.apk" 0 0 644 "u:object_r:system_file:s0"
    LOG_STEP_OUT
