# OpenWrt x86-64 Custom

基于 OpenWrt 官方源码的 x86-64 自定义固件构建仓库。

## 目标

- x86_64
- generic
- BIOS/Legacy
- ext4-combined
- **不生成 EFI 镜像**
- 默认 LuCI 简体中文
- 默认 Argon
- PassWall
- Xray / sing-box
- qBittorrent-nox
- DDNS
- AdGuardHome（用户态，不添加所谓 AdGuardHome 内核模块）
- SmartDNS
- Docker / Docker Compose
- mwan3
- USB Wi-Fi
- USB 存储 / EXT4

## GitHub Actions

1. 上传本仓库到 GitHub。
2. 打开 `Actions`。
3. 选择 `Build OpenWrt x86-64`。
4. 点击 `Run workflow`。
5. 默认使用 `v25.12.5`。
6. 编译完成后：
   - Actions Artifact 会包含构建产物；
   - workflow 手动运行时还会创建 GitHub Release。

## 输出

Release 只收集：

`*ext4-combined*.img.gz`

并明确排除：

`*efi*`

同时生成：

- `openwrt-x86-64.config`
- `build-info.txt`
- `sha256sums.txt`

## 默认管理

默认 LAN 地址通常为：

`192.168.1.1`

默认语言：

`简体中文`

默认主题：

`Argon`

## 存储建议

Docker 数据目录：

`/opt/docker`

qBittorrent 下载目录建议放到独立 SSD/HDD，不要长期写系统 overlay。

## 多拨说明

仓库默认提供 mwan3、多 WAN 和 PPPoE 所需基础组件。

“多 WAN”与“单账号 PPPoE 多拨”不是同一个概念。真正的运营商 PPPoE 多拨策略需要根据线路、账号、运营商限制和上联设备进一步配置，不能保证所有宽带都允许多拨。

## USB Wi-Fi

优先使用 OpenWrt 主线 mac80211 驱动。实际兼容性取决于 USB 无线网卡芯片型号及对应固件。

## 注意

PassWall 使用其当前 `main` feed，因此第三方 feed 的更新速度可能快于 OpenWrt 稳定分支。生产环境建议在需要可复现构建时固定 PassWall feed 到具体 commit。
