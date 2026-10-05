#!/bin/sh
set -eu

cd "$(dirname "$0")/.."

append_config() {
    key="$1"
    value="$2"
    if grep -qE "^${key}=" .config 2>/dev/null; then
        sed -i "s#^${key}=.*#${key}=${value}#" .config
    elif grep -qE "^# ${key} is not set" .config 2>/dev/null; then
        sed -i "s#^# ${key} is not set#${key}=${value}#" .config
    else
        printf '%s=%s\n' "$key" "$value" >> .config
    fi
}

# Force required target/image settings.
append_config CONFIG_TARGET_x86 y
append_config CONFIG_TARGET_x86_64 y
append_config CONFIG_TARGET_x86_64_DEVICE_generic y
append_config CONFIG_TARGET_ROOTFS_EXT4FS y
append_config CONFIG_TARGET_IMAGES_GZIP y
append_config CONFIG_GRUB_IMAGES y

# Explicitly disable EFI image generation.
sed -i '/^CONFIG_GRUB_EFI_IMAGES=/d' .config
sed -i '/^# CONFIG_GRUB_EFI_IMAGES is not set$/d' .config
printf '%s\n' '# CONFIG_GRUB_EFI_IMAGES is not set' >> .config

# PassWall. If a core is not available for this OpenWrt release/feed,
# make defconfig will leave the unavailable symbol unset instead of failing.
append_config CONFIG_PACKAGE_luci-app-passwall y
append_config CONFIG_PACKAGE_xray-core y
append_config CONFIG_PACKAGE_sing-box y

# Re-assert user-facing packages.
append_config CONFIG_PACKAGE_luci-theme-argon y
append_config CONFIG_PACKAGE_luci-i18n-base-zh-cn y
append_config CONFIG_PACKAGE_adguardhome y
append_config CONFIG_PACKAGE_smartdns y
append_config CONFIG_PACKAGE_dockerd y
append_config CONFIG_PACKAGE_docker y
append_config CONFIG_PACKAGE_docker-compose y
append_config CONFIG_PACKAGE_qbittorrent-nox y
append_config CONFIG_PACKAGE_mwan3 y

echo "Configuration seed prepared."
