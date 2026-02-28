@echo off
REM 更新 Netlify 部署脚本

echo 🔄 更新 Netlify 部署...
echo.

REM 检查是否已安装 Netlify CLI
where netlify >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Netlify CLI 未安装
    echo.
    echo 请先安装 Netlify CLI:
    echo   npm install -g netlify-cli
    echo.
    pause
    exit /b 1
)

REM 1. 清理并重新构建
echo 📦 清理旧构建...
call flutter clean

echo 📥 获取依赖...
call flutter pub get

echo 🔨 构建最新版本...
call flutter build web --release

if %ERRORLEVEL% NEQ 0 (
    echo ❌ 构建失败
    pause
    exit /b 1
)

REM 2. 部署到 Netlify
echo.
echo 🚀 部署到 Netlify...
cd build\web
call netlify deploy --prod

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ 部署成功！
    echo.
    echo 访问你的网站: https://xintan.netlify.app
    echo.
) else (
    echo.
    echo ❌ 部署失败
    echo.
)

cd ..\..
pause
