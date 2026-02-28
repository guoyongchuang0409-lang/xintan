@echo off
REM 心探应用 Web 部署脚本 (Windows 版本)
REM 用于构建并准备 Web 版本用于服务器部署

echo 🚀 开始构建心探 Web 应用...

REM 1. 清理之前的构建
echo 📦 清理旧的构建文件...
call flutter clean

REM 2. 获取依赖
echo 📥 获取依赖包...
call flutter pub get

REM 3. 构建 Web 版本（生产模式）
echo 🔨 构建 Web 版本...
call flutter build web --release --web-renderer canvaskit

REM 4. 创建部署目录
echo 📁 准备部署文件...
if exist web_deploy rmdir /s /q web_deploy
mkdir web_deploy

REM 5. 复制构建文件到部署目录
echo 📋 复制构建文件...
xcopy /E /I /Y build\web\* web_deploy\

REM 6. 创建 .htaccess 文件
echo ⚙️  创建服务器配置文件...
(
echo # 启用重写引擎
echo RewriteEngine On
echo.
echo # 如果请求的是文件或目录，直接返回
echo RewriteCond %%{REQUEST_FILENAME} !-f
echo RewriteCond %%{REQUEST_FILENAME} !-d
echo.
echo # 否则重定向到 index.html
echo RewriteRule ^ index.html [L]
echo.
echo # 启用 GZIP 压缩
echo ^<IfModule mod_deflate.c^>
echo   AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
echo ^</IfModule^>
echo.
echo # 设置缓存
echo ^<IfModule mod_expires.c^>
echo   ExpiresActive On
echo   ExpiresByType image/jpg "access plus 1 year"
echo   ExpiresByType image/jpeg "access plus 1 year"
echo   ExpiresByType image/gif "access plus 1 year"
echo   ExpiresByType image/png "access plus 1 year"
echo   ExpiresByType image/svg+xml "access plus 1 year"
echo   ExpiresByType text/css "access plus 1 month"
echo   ExpiresByType application/javascript "access plus 1 month"
echo   ExpiresByType application/wasm "access plus 1 month"
echo ^</IfModule^>
) > web_deploy\.htaccess

REM 7. 创建 nginx 配置示例
(
echo server {
echo     listen 80;
echo     server_name your-domain.com;
echo     root /path/to/web_deploy;
echo     index index.html;
echo.
echo     # 启用 GZIP 压缩
echo     gzip on;
echo     gzip_vary on;
echo     gzip_min_length 1024;
echo     gzip_types text/plain text/css text/xml text/javascript application/javascript application/json application/wasm;
echo.
echo     # 处理 Flutter 路由
echo     location / {
echo         try_files $uri $uri/ /index.html;
echo     }
echo.
echo     # 缓存静态资源
echo     location ~* \.\(jpg^|jpeg^|png^|gif^|ico^|css^|js^|wasm\)$ {
echo         expires 1y;
echo         add_header Cache-Control "public, immutable";
echo     }
echo }
) > web_deploy\nginx.conf.example

REM 8. 创建部署说明文档
(
echo # 心探 Web 应用部署说明
echo.
echo ## 📦 部署文件说明
echo.
echo 此目录包含心探应用的 Web 构建版本，可以直接部署到任何支持静态网站的服务器。
echo.
echo ## 🚀 部署方式
echo.
echo ### 方式一：Apache 服务器
echo.
echo 1. 将 web_deploy 目录中的所有文件上传到服务器
echo 2. 确保 .htaccess 文件已上传
echo 3. 确保 Apache 启用了 mod_rewrite 模块
echo 4. 访问你的域名即可
echo.
echo ### 方式二：Nginx 服务器
echo.
echo 1. 将 web_deploy 目录中的所有文件上传到服务器
echo 2. 参考 nginx.conf.example 配置 Nginx
echo 3. 重启 Nginx 服务
echo 4. 访问你的域名即可
echo.
echo ### 方式三：静态托管服务
echo.
echo 支持以下平台：
echo - Vercel: 直接连接 Git 仓库自动部署
echo - Netlify: 拖拽上传或 Git 部署
echo - GitHub Pages: 推送到 gh-pages 分支
echo - Firebase Hosting: 使用 Firebase CLI 部署
echo - Cloudflare Pages: Git 集成自动部署
echo.
echo ## 📋 部署检查清单
echo.
echo - [ ] 所有文件已上传
echo - [ ] 服务器配置正确
echo - [ ] HTTPS 已配置
echo - [ ] GZIP 压缩已启用
echo - [ ] 缓存策略已配置
echo - [ ] 域名 DNS 已解析
echo.
echo ## 📱 功能特性
echo.
echo - ✅ 完整的测试功能
echo - ✅ 历史记录（IndexedDB）
echo - ✅ 用户资料管理
echo - ✅ 响应式设计
echo - ✅ 分享功能
echo - ✅ 截图功能
echo - ✅ 离线缓存
echo.
echo 构建时间: %date% %time%
echo 版本: 1.0.0
) > web_deploy\DEPLOY_README.md

REM 9. 显示构建信息
echo.
echo ✅ Web 应用构建完成！
echo.
echo 📁 部署文件位置: web_deploy\
echo 📄 部署说明: web_deploy\DEPLOY_README.md
echo.
echo 🚀 部署方式：
echo    1. 使用 FTP/SFTP 上传 web_deploy 目录中的所有文件
echo    2. 或使用 rsync/scp 命令上传到服务器
echo    3. 或使用静态托管服务（Vercel、Netlify 等）
echo.
pause
