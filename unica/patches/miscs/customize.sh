


SOURCE_FIRMWARE_PATH="$(cut -d "/" -f 1 -s <<< "$SOURCE_FIRMWARE")_$(cut -d "/" -f 2 -s <<< "$SOURCE_FIRMWARE")"
TARGET_FIRMWARE_PATH="$(cut -d "/" -f 1 -s <<< "$TARGET_FIRMWARE")_$(cut -d "/" -f 2 -s <<< "$TARGET_FIRMWARE")"

SET_PROP_IF_DIFF "vendor" "ro.oem_unlock_supported" "0"

LOG "- Disabling encryption"
LINE=$(sed -n "/^\/dev\/block\/by-name\/userdata/=" "$WORK_DIR/vendor/etc/fstab.qcom")
sed -i "${LINE}s/,fileencryption=aes-256-xts:aes-256-cts:v2//g" "$WORK_DIR/vendor/etc/fstab.qcom"

#Adding stock game driver
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/priv-app/GameDriver-SM8450"

# Fix portrait mode
if [[ -f "$TARGET_FIRMWARE_PATH/vendor/lib64/libDualCamBokehCapture.camera.samsung.so" ]]; then
    if grep -q "ro.build.flavor" "$TARGET_FIRMWARE_PATH/vendor/lib64/libDualCamBokehCapture.camera.samsung.so"; then
        SET_PROP "system" "ro.build.flavor" "$(GET_PROP "$TARGET_FIRMWARE_PATH/system/system/build.prop" "ro.build.flavor")"
    elif grep -q "ro.product.name" "$TARGET_FIRMWARE_PATH/vendor/lib64/libDualCamBokehCapture.camera.samsung.so"; then
        sed -i "s/ro.product.name/ro.unica.camera/g" "$WORK_DIR/vendor/lib/libDualCamBokehCapture.camera.samsung.so" && \
            sed -i "s/ro.product.name/ro.unica.camera/g" "$WORK_DIR/vendor/lib/liblivefocus_capture_engine.so" && \
            sed -i "s/ro.product.name/ro.unica.camera/g" "$WORK_DIR/vendor/lib/liblivefocus_preview_engine.so" && \
            sed -i "s/ro.product.name/ro.unica.camera/g" "$WORK_DIR/vendor/lib64/libDualCamBokehCapture.camera.samsung.so" && \
            sed -i "s/ro.product.name/ro.unica.camera/g" "$WORK_DIR/vendor/lib64/liblivefocus_capture_engine.so" && \
            sed -i "s/ro.product.name/ro.unica.camera/g" "$WORK_DIR/vendor/lib64/liblivefocus_preview_engine.so"
        echo -e "\nro.unica.camera u:object_r:build_prop:s0 exact string" >> "$WORK_DIR/system/system/etc/selinux/plat_property_contexts"
        SET_PROP "system" "ro.unica.camera" "$(GET_PROP "$TARGET_FIRMWARE_PATH/system/system/build.prop" "ro.product.system.name")"
    fi
fi

DELETE_FROM_WORK_DIR "system" "system/cameradata/portrait_data"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/cameradata/portrait_data" 0 0 755 "u:object_r:system_file:s0"
if [ -f "$SRC_DIR/target/$TARGET_CODENAME/camera/singletake/service-feature.xml" ]; then
    LOG "- Adding /system/system/cameradata/singletake/service-feature.xml"
    EVAL "cp -a \"$SRC_DIR/target/$TARGET_CODENAME/camera/singletake/service-feature.xml\" \"$WORK_DIR/system/system/cameradata/singletake/service-feature.xml\""
else
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" \
        "system" "system/cameradata/singletake/service-feature.xml" 0 0 644 "u:object_r:system_file:s0"
fi
if [ -f "$SRC_DIR/target/$TARGET_CODENAME/camera/aremoji-feature.xml" ]; then
    LOG "- Adding /system/system/cameradata/aremoji-feature.xml"
    EVAL "cp -a \"$SRC_DIR/target/$TARGET_CODENAME/camera/aremoji-feature.xml\" \"$WORK_DIR/system/system/cameradata/aremoji-feature.xml\""
else
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" \
        "system" "system/cameradata/aremoji-feature.xml" 0 0 644 "u:object_r:system_file:s0"
fi
if [ -f "$SRC_DIR/target/$TARGET_CODENAME/camera/camera-feature.xml" ]; then
    LOG "- Adding /system/system/cameradata/camera-feature.xml"
    EVAL "cp -a \"$SRC_DIR/target/$TARGET_CODENAME/camera/camera-feature.xml\" \"$WORK_DIR/system/system/cameradata/camera-feature.xml\""
elif [[ "$SOURCE_PLATFORM_SDK_VERSION" == "$TARGET_PLATFORM_SDK_VERSION" ]]; then
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" \
        "system" "system/cameradata/camera-feature.xml" 0 0 644 "u:object_r:system_file:s0"
else
    _LOG "File not found: $SRC_DIR/target/$TARGET_CODENAME/camera/camera-feature.xml"
fi

LOG_STEP_IN
if grep -q "DURING_SMARTVIEW" "$WORK_DIR/system/system/cameradata/camera-feature.xml" 2> /dev/null; then
    LOG "- Removing Smart View limitations flags"
    EVAL "sed -i \"/DURING_SMARTVIEW/d\" \"$WORK_DIR/system/system/cameradata/camera-feature.xml\""
fi
if [ "$(GET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_GRAPHICS_SUPPORT_3D_SURFACE_TRANSITION_FLAG")" ]; then
    if grep -q "SUPPORT_LIVE_BLUR" "$WORK_DIR/system/system/cameradata/camera-feature.xml" 2> /dev/null; then
        LOG "- Removing native blur disable flag"
        EVAL "sed -i \"/SUPPORT_LIVE_BLUR/d\" \"$WORK_DIR/system/system/cameradata/camera-feature.xml\""
    fi
fi
LOG_STEP_OUT

LOG_STEP_IN
if grep -q "DURING_SMARTVIEW" "$WORK_DIR/system/system/cameradata/camera-feature.xml" 2> /dev/null; then
    LOG "- Removing Smart View limitations flags"
    EVAL "sed -i \"/DURING_SMARTVIEW/d\" \"$WORK_DIR/system/system/cameradata/camera-feature.xml\""
fi
if [ "$(GET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_GRAPHICS_SUPPORT_3D_SURFACE_TRANSITION_FLAG")" ]; then
    if grep -q "SUPPORT_LIVE_BLUR" "$WORK_DIR/system/system/cameradata/camera-feature.xml" 2> /dev/null; then
        LOG "- Removing native blur disable flag"
        EVAL "sed -i \"/SUPPORT_LIVE_BLUR/d\" \"$WORK_DIR/system/system/cameradata/camera-feature.xml\""
    fi
fi
LOG_STEP_OUT

if {
    [[ "$SOURCE_CAMERA_CONFIG_VENDOR_LIB_INFO" == *"fusion_high_res.arcsoft.v1"* ]] && \
        [[ "$TARGET_CAMERA_CONFIG_VENDOR_LIB_INFO" != *"fusion_high_res.arcsoft.v1"* ]]
} || {
    [[ "$SOURCE_CAMERA_CONFIG_VENDOR_LIB_INFO" == *"high_res.arcsoft.v2"* ]] && \
        [[ "$TARGET_CAMERA_CONFIG_VENDOR_LIB_INFO" != *"high_res.arcsoft.v2"* ]]
}; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libHREnhancementAPI.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libhighres_enhancement.arcsoft.so"
fi
if [[ "$SOURCE_CAMERA_CONFIG_VENDOR_LIB_INFO" == *"fr_tracking.arcsoft.v1"* ]] && \
        [[ "$TARGET_CAMERA_CONFIG_VENDOR_LIB_INFO" != *"fr_tracking.arcsoft.v1"* ]]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libFaceRecognition.arcsoft.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libfrtracking_engine.arcsoft.so"
fi
if [[ "$SOURCE_CAMERA_CONFIG_VENDOR_LIB_INFO" == *"hybridhdr.arcsoft.v1"* ]] && \
        [[ "$TARGET_CAMERA_CONFIG_VENDOR_LIB_INFO" != *"hybridhdr.arcsoft.v1"* ]]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libhybridHDR_wrapper.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libhybrid_high_dynamic_range.arcsoft.so"
fi
if [[ "$SOURCE_CAMERA_CONFIG_VENDOR_LIB_INFO" == *"pro_single_rgb.mpi.v1"* ]] && \
        [[ "$TARGET_CAMERA_CONFIG_VENDOR_LIB_INFO" != *"pro_single_rgb.mpi.v1"* ]]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libAIQSolution_MPISingleRGB40.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libMPISingleRGB40.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libMPISingleRGB40Tuning.camera.samsung.so"
fi
if [[ "$SOURCE_CAMERA_CONFIG_VENDOR_LIB_INFO" == *"super_night.mpi.v2"* ]] && \
        [[ "$TARGET_CAMERA_CONFIG_VENDOR_LIB_INFO" != *"super_night.mpi.v2"* ]]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libAIQSolution_MPI.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libLocalTM_pcc.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libMultiFrameProcessing30.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libMultiFrameProcessing30.snapwrapper.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libMultiFrameProcessing30Tuning.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libObjectDetector_v1.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libSwIsp_core.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libSwIsp_wrapper_v1.camera.samsung.so"
fi
if [[ "$SOURCE_CAMERA_CONFIG_VENDOR_LIB_INFO" == *"super_resolution_raw.arcsoft"* ]] && \
        [[ "$TARGET_CAMERA_CONFIG_VENDOR_LIB_INFO" != *"super_resolution_raw.arcsoft"* ]]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libsuperresolutionraw_wrapper_v2.camera.samsung.so"
    DELETE_FROM_WORK_DIR "system" "system/lib64/libsuperresolution_raw.arcsoft.so"
fi
SOURCE_CAMERA_DOCUMENTSCAN_SOLUTIONS="$(GET_FLOATING_FEATURE_CONFIG "$FW_DIR/$SOURCE_FIRMWARE_PATH/system/system/etc/floating_feature.xml"  "SEC_FLOATING_FEATURE_CAMERA_DOCUMENTSCAN_SOLUTIONS")"
TARGET_CAMERA_DOCUMENTSCAN_SOLUTIONS="$(GET_FLOATING_FEATURE_CONFIG "SEC_FLOATING_FEATURE_CAMERA_DOCUMENTSCAN_SOLUTIONS")"
if [[ "$SOURCE_CAMERA_DOCUMENTSCAN_SOLUTIONS" == *"AI_DEWARPING"* ]] && \
        [[ "$TARGET_CAMERA_DOCUMENTSCAN_SOLUTIONS" != *"AI_DEWARPING"* ]]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libDeepDocRectify.camera.samsung.so"
fi
if [[ "$SOURCE_CAMERA_DOCUMENTSCAN_SOLUTIONS" == *"SHADOW_REMOVAL"* ]] && \
        [[ "$TARGET_CAMERA_DOCUMENTSCAN_SOLUTIONS" != *"SHADOW_REMOVAL"* ]]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libDocShadowRemoval.arcsoft.so"
fi
if [ -f "$WORK_DIR/system/system/lib64/libImageSegmenter_v1.camera.samsung.so" ] && \
        [ ! -d "$WORK_DIR/vendor/etc/portrait_data/LF_segmenter" ]; then
    DELETE_FROM_WORK_DIR "system" "system/lib64/libImageSegmenter_v1.camera.samsung.so"
fi
