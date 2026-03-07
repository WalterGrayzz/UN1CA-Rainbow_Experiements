SET_PROP_IF_DIFF "vendor" "ro.oem_unlock_supported" "0"

LOG "- Disabling encryption"
LINE=$(sed -n "/^\/dev\/block\/by-name\/userdata/=" "$WORK_DIR/vendor/etc/fstab.qcom")
sed -i "${LINE}s/,fileencryption=aes-256-xts:aes-256-cts:v2//g" "$WORK_DIR/vendor/etc/fstab.qcom"

#test
ADD_TO_WORK_DIR "b0qxxx" "vendor" "firmware"
ADD_TO_WORK_DIR "b0qxxx" "vendor" "lib64/hw/gatekeeper.mdfpp.so"

#Use Stock BT Apex
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/apex/com.android.bt.apex"
