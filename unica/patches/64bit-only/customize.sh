
LOG_STEP_IN "- Setting props"
SET_PROP "vendor" "ro.vendor.product.cpu.abilist" "arm64-v8a"
SET_PROP "vendor" "ro.vendor.product.cpu.abilist32" ""
SET_PROP "vendor" "ro.vendor.product.cpu.abilist64" "arm64-v8a"
SET_PROP "vendor" "ro.zygote" "zygote64"
SET_PROP "vendor" "dalvik.vm.dex2oat64.enabled" "true"
SET_PROP "odm" "ro.odm.product.cpu.abilist" "arm64-v8a"
SET_PROP "odm" "ro.odm.product.cpu.abilist32" ""
SET_PROP "odm" "ro.odm.product.cpu.abilist64" "arm64-v8a"
SET_PROP "system" "ro.system.product.cpu.abilist" "arm64-v8a"
SET_PROP "system" "ro.system.product.cpu.abilist32" ""
SET_PROP "system" "ro.system.product.cpu.abilist64" "arm64-v8a"
SET_PROP "system" "dalvik.vm.dex2oat64.enabled" "true"
LOG_STEP_OUT

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

#BootAnim
LOG_STEP_IN "- Adding boot animation from S26 Ultra"
ADD_TO_WORK_DIR "m3qxxx" "system" "system/media/bootandroid.jpg"
ADD_TO_WORK_DIR "m3qxxx" "system" "system/media/bootsamsung.qmg"
ADD_TO_WORK_DIR "m3qxxx" "system" "system/media/bootsamsungloop.qmg"
ADD_TO_WORK_DIR "m3qxxx" "system" "system/media/shutdown.qmg"
LOG_STEP_OUT

#fix dm3q buggies
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system_ext" "lib64/libqcc_file_agent_sys.so"
ADD_TO_WORK_DIR "$SOURCE_FIRMWARE" "system_ext" "lib/libqcc_file_agent_sys.so"


