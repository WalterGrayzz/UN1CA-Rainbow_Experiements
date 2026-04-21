ADD_TO_WORK_DIR "dm3qxxx" "system" "system/lib" 0 0 644

BLOBS_LIST="
system/apex/com.android.i18n.apex
system/apex/com.android.runtime.apex
system/apex/com.google.android.tzdata6.apex
system/bin/bootstrap/linker
system/bin/bootstrap/linker_asan
"
for blob in $BLOBS_LIST
do
    ADD_TO_WORK_DIR "dm3qxxx" "system" "$blob"
done

# Creating symlinks
ln -sf "/apex/com.android.runtime/bin/linker" "$WORK_DIR/system/system/bin/linker"
ln -sf "/apex/com.android.runtime/bin/linker" "$WORK_DIR/system/system/bin/linker_asan"
SET_METADATA "system" "system/bin/linker" 0 0 755 "u:object_r:system_file:s0"
SET_METADATA "system" "system/bin/linker_asan" 0 0 755 "u:object_r:system_file:s0"

ln -sf "/apex/com.android.runtime/lib/bionic/libc.so" "$WORK_DIR/system/system/lib/libc.so"
ln -sf "/apex/com.android.runtime/lib/bionic/libdl.so" "$WORK_DIR/system/system/lib/libdl.so"
ln -sf "/apex/com.android.runtime/lib/bionic/libdl_android.so" "$WORK_DIR/system/system/lib/libdl_android.so"
ln -sf "/apex/com.android.runtime/lib/bionic/libm.so" "$WORK_DIR/system/system/lib/libm.so"
SET_METADATA "system" "system/lib/libc.so" 0 0 644 "u:object_r:system_lib_file:s0"
SET_METADATA "system" "system/lib/libdl.so" 0 0 644 "u:object_r:system_lib_file:s0"
SET_METADATA "system" "system/lib/libdl_android.so" 0 0 644 "u:object_r:system_lib_file:s0"
SET_METADATA "system" "system/lib/libm.so" 0 0 644 "u:object_r:system_lib_file:s0"

LOG_STEP_IN "- Setting props"
SET_PROP "vendor" "ro.vendor.product.cpu.abilist" "arm64-v8a"
SET_PROP "vendor" "ro.vendor.product.cpu.abilist32" ""
SET_PROP "vendor" "ro.vendor.product.cpu.abilist64" "arm64-v8a"
SET_PROP "vendor" "ro.zygote" "zygote64"
#SET_PROP "vendor" "ro.bionic.2nd_arch" ""
#SET_PROP "vendor" "ro.bionic.2nd_cpu_variant" ""
SET_PROP "vendor" "dalvik.vm.dex2oat64.enabled" "true"
LOG_STEP_OUT

LOG_STEP_IN "- Downgrading VaultKeeper JNI"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.vaultkeeper-V1-ndk.so"
ADD_TO_WORK_DIR "dm3qxxx" "system" "system/lib64/libvkjni.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "dm3qxxx" "system" "system/lib64/libvkmanager.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "dm3qxxx" "system" "system/lib64/vendor.samsung.hardware.security.vaultkeeper@2.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Downgrading ENGMODE JNI"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.engmode-V1-ndk.so"
ADD_TO_WORK_DIR "dm3qxxx" "system" "system/lib64/lib.engmode.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "dm3qxxx" "system" "system/lib64/lib.engmodejni.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "dm3qxxx" "system" "system/lib64/vendor.samsung.hardware.security.engmode@1.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding stock WFD blobs"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/bin/insthk" 0 2000 755 "u:object_r:insthk_exec:s0"
DELETE_FROM_WORK_DIR "system" "system/lib64/libhdcp_client_aidl.so"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/libhdcp2.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/libstagefright_hdcp.so" 0 0 644 "u:object_r:system_lib_file:s0"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.hdcp.wifidisplay-V2-ndk.so"
LOG_STEP_OUT

#Audio
#ADD_TO_WORK_DIR "dm3qxxx" "vendor" "bin/hw/android.hardware.audio.service"
#ADD_TO_WORK_DIR "dm3qxxx" "vendor" "lib64/libhfp_pal.so"

#Codecs
#ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "vendor" "etc/seccomp_policy/mediacodec.policy"
#ADD_TO_WORK_DIR "los" "vendor" "lib64/libstagefright_softomx.so"
#ADD_TO_WORK_DIR "los" "vendor" "lib64/libstagefright_softomx_plugin.so"
#ADD_TO_WORK_DIR "los" "vendor" "lib64/vndk/libstagefright_omx_utils.so"
#ADD_TO_WORK_DIR "los" "vendor" "etc/init/android.hardware.media.omx@1.0-service.rc"
#ADD_TO_WORK_DIR "los" "vendor" "bin/hw/android.hardware.media.omx@1.0-service"

#qchdcpkprov
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/bin/qchdcpkprov"
DELETE_FROM_WORK_DIR "system" "system/lib64/vendor.samsung.hardware.security.hdcp.keyprovisioning-V1-ndk.so"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/vendor.samsung.hardware.security.hdcp.keyprovisioning@1.0.so"


#AIDL cas
LOG_STEP_IN "- Replacing 32-bit CAS with 64 bit ones"
DELETE_FROM_WORK_DIR "vendor" "bin/hw/android.hardware.cas@1.2-service-lazy"
DELETE_FROM_WORK_DIR "vendor" "etc/vintf/manifest/android.hardware.cas@1.2-service-lazy.xml"
DELETE_FROM_WORK_DIR "vendor" "etc/init/android.hardware.cas@1.2-service-lazy.rc"
ADD_TO_WORK_DIR "e3qxxx" "vendor" "etc/init/cas-default-lazy.rc"
ADD_TO_WORK_DIR "e3qxxx" "vendor" "etc/vintf/manifest/android.hardware.cas-service.xml"
ADD_TO_WORK_DIR "e3qxxx" "vendor" "bin/hw/android.hardware.cas-service.example-lazy"
LOG_STEP_OUT

#NFC
SET_PROP "vendor" "ro.vendor.nfc.info.antpos" "29"

#WIFI


