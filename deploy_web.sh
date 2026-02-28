#!/bin/bash

# 心探应用 Web 部署脚本
# 用于构建并准备 Web 版本用于服务器部署

echo "🚀 开始构建心探 Web 应用..."

# 1. 清理之前的构建
echo "📦 清理旧的构建文件..."
flutter clean

# 2. 获取依赖
echo "📥 获取依赖包..."
flutter pub get

# 3. 构建 Web 版本（生产模式）
echo "🔨 构建 Web 版本..."
flutter build web --release --web-renderer canvaskit

# 4. 创建部署目录
echo "📁 准备部署文件..."
rm -rf web_deploy
mkdir -p web_deploy

# 5. 复制构建文件到部署目录
echo "📋 复制构建文件..."
cp -r build/web/* web_deploy/

# 6. 创建 .htaccess 文件（用于 Apache 服务器）
echo "⚙️  创建服务器配置文件..."
cat > web_deploy/.htaccess << 'EOF'
# 启用重写引擎
RewriteEngine On

# 如果请求的是文件或目录，直接返回
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d

# 否则重定向到 index.html（用于 Flutter 路由）
RewriteRule ^ index.html [L]

# 启用 GZIP 压缩
<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
</IfModule>

# 设置缓存
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType image/jpg "access plus 1 year"
  ExpiresByType image/jpeg "access plus 1 year"
  ExpiresByType image/gif "access plus 1 year"
  ExpiresByType image/png "access plus 1 year"
  ExpiresByType image/svg+xml "access plus 1 year"
  ExpiresByType text/css "access plus 1 month"
  ExpiresByType application/javascript "access plus 1 month"
  ExpiresByType application/wasm "access plus 1 month"
</IfModule>
EOF

# 7. 创建 nginx 配置示例
cat > web_deploy/nginx.conf.example << 'EOF'
server {
    listen 80;
    server_name your-domain.com;
    root /path/to/web_deploy;
    index index.html;

    # 启用 GZIP 压缩
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/json application/wasm;

    # 处理 Flutter 路由
    location / {
        try_files $uri $uri/ /index.html;
    }

    # 缓存静态资源
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|wasm)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOF

# 8. 创建部署说明文档
cat > web_deploy/DEPLOY_README.md << 'EOF'
# 心探 Web 应用部署说明

## 📦 部署文件说明

此目录包含心探应用的 Web 构建版本，可以直接部署到任何支持静态网站的服务器。

## 🚀 部署方式

### 方式一：Apache 服务器

1. 将 `web_deploy` 目录中的所有文件上传到服务器
2. 确保 `.htaccess` 文件已上传
3. 确保 Apache 启用了 `mod_rewrite` 模块
4. 访问你的域名即可

### 方式二：Nginx 服务器

1. 将 `web_deploy` 目录中的所有文件上传到服务器
2. 参考 `nginx.conf.example` 配置 Nginx
3. 重启 Nginx 服务
4. 访问你的域名即可

### 方式三：静态托管服务

支持以下平台：
- **Vercel**: 直接连接 Git 仓库自动部署
- **Netlify**: 拖拽上传或 Git 部署
- **GitHub Pages**: 推送到 gh-pages 分支
- **Firebase Hosting**: 使用 Firebase CLI 部署
- **Cloudflare Pages**: Git 集成自动部署

## 📋 部署检查清单

- [ ] 所有文件已上传
- [ ] 服务器配置正确（.htaccess 或 nginx.conf）
- [ ] HTTPS 已配置（推荐）
- [ ] GZIP 压缩已启用
- [ ] 缓存策略已配置
- [ ] 域名 DNS 已解析

## 🔧 技术要求

- 支持静态文件托管
- 支持 URL 重写（用于 Flutter 路由）
- 建议启用 HTTPS
- 建议启用 GZIP 压缩

## 📱 功能特性

本 Web 版本包含以下功能：
- ✅ 完整的测试功能
- ✅ 历史记录（使用 IndexedDB）
- ✅ 用户资料管理
- ✅ 响应式设计（支持手机、平板、桌面）
- ✅ 分享功能（支持 Web Share API）
- ✅ 截图功能（触发下载）
- ✅ 离线缓存（Service Worker）

## 🌐 浏览器兼容性

- Chrome/Edge: 完全支持
- Safari: 完全支持
- Firefox: 完全支持
- 移动浏览器: 完全支持

## 📞 技术支持

如有问题，请查看项目文档或联系开发团队。

---

构建时间: $(date)
版本: 1.0.0
EOF

# 9. 创建快速部署脚本
cat > web_deploy/quick_deploy.sh << 'EOF'
#!/bin/bash

# 快速部署到服务器
# 使用方法: ./quick_deploy.sh user@server:/path/to/deploy

if [ -z "$1" ]; then
    echo "❌ 错误: 请提供服务器地址"
    echo "使用方法: ./quick_deploy.sh user@server:/path/to/deploy"
    exit 1
fi

echo "🚀 开始部署到服务器..."
rsync -avz --progress --exclude='*.sh' --exclude='*.example' --exclude='DEPLOY_README.md' ./ "$1"
echo "✅ 部署完成！"
EOF

chmod +x web_deploy/quick_deploy.sh

# 10. 显示构建信息
echo ""
echo "✅ Web 应用构建完成！"
echo ""
echo "📁 部署文件位置: web_deploy/"
echo "📄 部署说明: web_deploy/DEPLOY_README.md"
echo ""
echo "🚀 快速部署命令:"
echo "   cd web_deploy"
echo "   ./quick_deploy.sh user@server:/path/to/deploy"
echo ""
echo "或者手动上传 web_deploy 目录中的所有文件到服务器"
echo ""
