# 后端说明

## 目录结构

```
backend/
├── vercel/              # Vercel Serverless 后端（推荐）
│   ├── api/            # API 端点
│   ├── deploy.bat      # Windows 部署脚本
│   ├── deploy.sh       # Mac/Linux 部署脚本
│   └── README.md       # 详细说明
├── api.php             # PHP 后端（备用方案）
└── database.sql        # 数据库 SQL（备用方案）
```

## 推荐方案：Vercel

使用 `vercel/` 目录下的 Serverless 后端，原因：
- ✅ 完全免费
- ✅ 中国可访问，不需要魔法
- ✅ 一键部署，无需配置服务器
- ✅ 自动 HTTPS 和全球 CDN

## 快速开始

```bash
cd vercel
./deploy.bat  # Windows
./deploy.sh   # Mac/Linux
```

详细步骤见：
- [../数据库部署指南.md](../数据库部署指南.md)
- [../快速开始 - 数据库功能.md](../快速开始%20-%20数据库功能.md)

## 备用方案：PHP

如果你有自己的 PHP 服务器，可以使用：
- `api.php` - PHP API 文件
- `database.sql` - MySQL 数据库 SQL

但需要注意：
- 需要自己配置服务器
- 需要配置 CORS
- 可能需要魔法（取决于服务器位置）
