@echo off
setlocal

:: 1. 触发 Rime 同步
:: 注意：请根据你的实际安装路径调整 WeaselDeployer.exe 的位置
echo --- 正在触发 Rime 同步 (Windows) ---
"C:\Program Files (x86)\Rime\weasel-0.15.0\WeaselDeployer.exe" /sync

:: 2. 拉取官方 upstream 更新
echo --- 正在拉取官方 upstream 更新 ---
git fetch upstream
git merge upstream/main

:: 3. 推送个人配置与词库到 origin
echo --- 正在推送至个人 GitHub (origin) ---
git add .
git commit -m "auto: sync user dict and configs %date% %time%"
git push origin main

echo --- 同步完成！ ---
pause
