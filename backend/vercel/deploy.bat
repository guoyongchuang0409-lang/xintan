@echo off
echo ========================================
echo Vercel 后端部署脚本
echo ========================================
echo.

REM 检查是否安装了 Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未检测到 Node.js，请先安装 Node.js
    echo 下载地址: https://nodejs.org/
    pause
    exit /b 1
)

REM 检查是否安装了 Vercel CLI
where vercel >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [提示] 未检测到 Vercel CLI，正在安装...
    npm install -g vercel
    if %ERRORLEVEL% NEQ 0 (
        echo [错误] Vercel CLI 安装失败
        pause
        exit /b 1
    )
    echo [成功] Vercel CLI 安装完成
    echo.
)

echo [步骤 1/3] 登录 Vercel...
echo.
vercel login

echo.
echo [步骤 2/3] 部署到 Vercel...
echo.
vercel --prod

echo.
echo ========================================
echo 部署完成！
echo ========================================
echo.
echo 接下来的步骤：
echo 1. 访问 https://vercel.com/dashboard
echo 2. 进入你的项目
echo 3. 点击 "Storage" 标签
echo 4. 创建 Postgres 数据库
echo 5. 在数据库中执行 SQL（见 README.md）
echo 6. 复制 API 地址到 Flutter 应用
echo.
pause
