#!/bin/bash
# =========================================
# Linux 初始化脚本
# 作者: lillinlin
# 说明: 适用于 Debian/Ubuntu 系列系统
# =========================================

# 检查是否为 root 用户
if [ "$(id -u)" -ne 0 ]; then
    echo "请使用 root 用户运行此脚本。"
    exit 1
fi

echo "开始更新软件源..."
apt update -y

echo "安装必要组件..."
apt install -y unzip sudo cron curl wget

echo "执行系统全面升级..."
apt full-upgrade -y

# 检查返回状态
if [ $? -eq 0 ]; then
    echo "系统升级完成！"
else
    echo "升级过程中出现错误，请检查日志。"
    exit 1
fi

# 询问是否重启
read -p "是否立即重启系统？(y/n): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "系统即将重启..."
    reboot
else
    echo "已取消重启，请手动重启以确保更新生效。"
fi
