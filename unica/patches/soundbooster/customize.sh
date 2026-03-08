    LOG_STEP_IN "- Replacing SoundBooster"
    DELETE_FROM_WORK_DIR "system" "system/lib64/lib_SoundBooster_ver2000.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libsoundboostereq_legacy.so"
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/lib_SoundBooster_ver1100.so" 0 0 644 "u:object_r:system_lib_file:s0"
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/libsamsungSoundbooster_plus_legacy.so" 0 0 644 "u:object_r:system_lib_file:s0"
    LOG_STEP_OUT
