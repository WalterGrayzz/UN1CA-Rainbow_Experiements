SET_PROP_IF_DIFF "vendor" "ro.oem_unlock_supported" "0"

LOG "- Disabling encryption"
LINE=$(sed -n "/^\/dev\/block\/by-name\/userdata/=" "$WORK_DIR/vendor/etc/fstab.qcom")
sed -i "${LINE}s/,fileencryption=aes-256-xts:aes-256-cts:v2//g" "$WORK_DIR/vendor/etc/fstab.qcom"

LOG_STEP_IN "- Downgrading VaultKeeper JNI"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.vaultkeeper-V1-ndk.so"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/libvkjni.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/libvkmanager.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/vendor.samsung.hardware.security.vaultkeeper@2.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Downgrading ENGMODE JNI"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.engmode-V1-ndk.so"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/lib.engmode.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/lib.engmodejni.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/vendor.samsung.hardware.security.engmode@1.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

#Nuke Shit
LOG_STEP_IN "- Remove qchdcpkprov"
DELETE_FROM_WORK_DIR "system" "system/bin/qchdcpkprov"
DELETE_FROM_WORK_DIR "system" "system/bin/dhkprov"
DELETE_FROM_WORK_DIR "system" "system/etc/init/dhkprov.rc"
LOG_STEP_OUT

#Soundbooster
LOG_STEP_IN "- Replacing SoundBooster"
DELETE_FROM_WORK_DIR "system" "system/lib64/lib_SoundBooster_ver2060.so"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/lib_SoundBooster_ver1100.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/libsamsungSoundbooster_plus_legacy.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT
>>>>>>> Stashed changes
