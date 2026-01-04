#!/bin/bash

# 1. 触发 UI 同步 (绕过没有参数的 deployer)
echo "--- 正在触发 Rime UI 同步 ---"
osascript -e 'tell application "System Events" to tell process "Squirrel" to click menu item "同步" of menu 1 of menu bar item 1 of menu bar 2'

# 给系统一点时间导出文件 (同步大词库通常需要 3-5 秒)
sleep 5

# 2. 拉取官方更新 (Upstream)
echo "--- 正在获取官方词库更新 ---"
git pull upstream main --no-rebase

# 3. 推送个人词库 (Origin)
echo "--- 正在同步到你的 GitHub 仓库 ---"
if [[ -n $(git status -s) ]]; then
    git add .
    git commit -m "auto: sync user data $(date +'%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "Done! 你的词库已安全上云。"
else
    echo "Nothing to update."
fi