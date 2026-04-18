
#DELETE_FROM_WORK_DIR "system" "system/lib"

#LOG_STEP_IN "- Removing vendor/lib"
#DELETE_FROM_WORK_DIR "vendor" "lib"
#ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "vendor" "lib/modules"
#LOG_STEP_OUT

#BLOBS_LIST="
#ystem/apex/com.android.i18n.apex
#system/apex/com.android.runtime.apex
#system/apex/com.google.android.tzdata6.apex
#system/bin/bootstrap/linker64
#system/bin/bootstrap/linker_asan64
#system/bin/bootstrap/linker_hwasan64
#"
#for blob in $BLOBS_LIST
#do
    #ADD_TO_WORK_DIR "e3qxxx" "system" "$blob"
#done


LOG_STEP_IN "- Setting props"
SET_PROP "vendor" "ro.vendor.product.cpu.abilist" "arm64-v8a"
SET_PROP "vendor" "ro.vendor.product.cpu.abilist32" ""
SET_PROP "vendor" "ro.vendor.product.cpu.abilist64" "arm64-v8a"
SET_PROP "vendor" "ro.zygote" "zygote64"
#SET_PROP "vendor" "ro.bionic.2nd_arch" ""
#SET_PROP "vendor" "ro.bionic.2nd_cpu_variant" ""
SET_PROP "vendor" "dalvik.vm.dex2oat64.enabled" "true"
SET_PROP "odm" "ro.odm.product.cpu.abilist" "arm64-v8a"
SET_PROP "odm" "ro.odm.product.cpu.abilist32" ""
SET_PROP "odm" "ro.odm.product.cpu.abilist64" "arm64-v8a"
LOG_STEP_OUT

#Audio
#ADD_TO_WORK_DIR "dm3qxxx" "vendor" "bin/hw/android.hardware.audio.service"
#ADD_TO_WORK_DIR "dm3qxxx" "vendor" "lib64/libhfp_pal.so"

#Codecs
#ADD_TO_WORK_DIR "e3qxxx" "vendor" "etc/seccomp_policy/mediacodec.policy"
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
#SET_PROP "vendor" "ro.vendor.nfc.info.antpos" "29"
