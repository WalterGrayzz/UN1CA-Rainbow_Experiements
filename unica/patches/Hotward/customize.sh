LOG_STEP_IN "- Replacing Hotword"
    DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentXGoogleEx4HEXAGON"
    DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentOKGoogleEx4HEXAGON"
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "product" "priv-app/HotwordEnrollmentOKGoogleEx4HEXAGON/HotwordEnrollmentOKGoogleEx4HEXAGON.apk" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "product" "priv-app/HotwordEnrollmentOKGoogleEx4HEXAGON/HotwordEnrollmentOKGoogleEx4HEXAGON.apk" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT
