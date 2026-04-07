

LOG " - Enabling vulkan"
SET_PROP "vendor" "ro.hwui.use_vulkan" "true"
SET_PROP "vendor" "debug.hwui.use_hint_manager" "true"
SET_PROP "system" "debug.hwui.renderer" "skiavk"
SET_PROP "system" "debug.hwui.skip_empty_frames" "1"
SET_PROP "system" "ro.hwui.use_vulkan" "true"
