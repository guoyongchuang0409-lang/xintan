# Vercel 部署指南

## 🎯 前提条件

代码已推送到 GitHub：https://github.com/guoyongchuang0409-lang/xintan

---

## 📋 第一步：访问 Vercel

访问：https://vercel.com/signup

---

## 📋 第二步：使用 GitHub 登录

**重要！必须使用 GitHub 登录**

1. 点击 **"Continue with GitHub"**
2. 授权 Vercel 访问你的 GitHub 账号
3. 如果已经登录，会直接进入 Dashboard

---

## 📋 第三步：导入项目

### 1. 创建新项目

1. 点击 **"Add New..."** → **"Project"**
2. 在 "Import Git Repository" 部分找到 **"xintan"** 仓库
3. 点击 **"Import"**

### 2. 配置项目（重要！）

**关键配置：**

- **Project Name**: 保持 `xintan` 或修改为 `xintan-backend`
- **Framework Preset**: 选择 **"Other"**
- **Root Directory**: 点击 "Edit"，输入 `backend/vercel` ⭐ 重要！
- **Build and Output Settings**: 保持默认
- **Environment Variables**: 暂时不需要

### 3. 部署

点击 **"Deploy"** 按钮

---

## 📋 第四步：等待部署

### 部署过程

1. Vercel 会自动：
   - 检测项目结构
   - 安装依赖（npm install）
   - 部署 Serverless Functions
2. 等待 30-60 秒
3. 看到 🎉 表示成功

### 记录 API 地址

部署成功后，会显示你的 API 地址，例如：
```
https://xintan-backend-abc123.vercel.app
```

**复制并保存这个地址！**

---

## 📋 第五步：创建数据库

### 1. 进入 Storage

1. 在项目页面，点击顶部的 **"Storage"** 标签
2. 点击 **"Create Database"**

### 2. 选择 Postgres

1. 点击 **"Postgres"** 卡片
2. 填写信息：
   - **Database Name**: `quiz_db`
   - **Region**: 选择 **"Singapore (sin1)"** 或 **"Hong Kong (hkg1)"**
3. 点击 **"Create"**

### 3. 连接到项目

1. 数据库创建后，会提示 **"Connect to Project"**
2. 选择你的项目：`xintan` 或 `xintan-backend`
3. 点击 **"Connect"**
4. ✅ 环境变量自动配置完成！

---

## 📋 第六步：初始化数据库

### 1. 打开 Query 界面

1. 在 Storage 页面，点击你的数据库（quiz_db）
2. 点击顶部的 **"Query"** 标签

### 2. 执行 SQL

复制以下 SQL，粘贴到查询框：

```sql
CREATE TABLE IF NOT EXISTS reports (
    id SERIAL PRIMARY KEY,
    share_code VARCHAR(10) NOT NULL UNIQUE,
    quiz_type_id VARCHAR(50) NOT NULL,
    quiz_type_name VARCHAR(100) NOT NULL,
    report_data JSONB NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP,
    last_viewed_at TIMESTAMP,
    view_count INTEGER DEFAULT 0,
    ip_address VARCHAR(45),
    CONSTRAINT idx_share_code UNIQUE (share_code)
);

CREATE INDEX idx_quiz_type ON reports(quiz_type_id);
CREATE INDEX idx_created_at ON reports(created_at);
```

点击 **"Run Query"** 按钮

看到绿色的 **"Success"** 提示即可

---

## 📋 第七步：测试 API

### 在浏览器中测试

打开新标签页，访问：
```
https://xintan-backend-abc123.vercel.app/api/stats
```
（替换为你的 API 地址）

### 预期结果

应该看到：
```json
{
  "success": true,
  "data": {
    "totalReports": 0,
    "todayReports": 0,
    "weekReports": 0,
    "totalViews": 0,
    "byType": []
  }
}
```

✅ 如果看到这个，说明后端部署成功！

---

## 📋 第八步：配置 Flutter 应用

### 修改配置文件

打开文件：`lib/core/services/database_service.dart`

找到第 12 行：
```dart
static const String _apiBaseUrl = 'YOUR_VERCEL_API_URL';
```

替换为你的 API 地址：
```dart
static const String _apiBaseUrl = 'https://xintan-backend-abc123.vercel.app';
```

**保存文件**

---

## 🎉 完成！

现在你的后端已经部署成功！

### 下一步

1. 重新构建 Flutter 应用：`flutter build web --release`
2. 上传 `build/web` 到 Netlify
3. 测试自动上传功能

---

## 📊 查看部署状态

### 在 Vercel Dashboard

1. **Deployments** 标签：查看部署历史
2. **Functions** 标签：查看 API 函数日志
3. **Storage** 标签：管理数据库
4. **Settings** 标签：查看环境变量

### 查看日志

1. 点击 **"Functions"** 标签
2. 选择一个函数（如 `api/reports.js`）
3. 查看实时日志

---

## 🔄 更新代码

### 自动部署

每次你推送代码到 GitHub，Vercel 会自动重新部署！

### 手动重新部署

1. 在 Vercel Dashboard，进入项目
2. 点击 **"Deployments"** 标签
3. 点击最新部署右侧的 **"..."**
4. 选择 **"Redeploy"**

---

## ❓ 常见问题

### Q: 部署失败，提示找不到 package.json

**A**: 检查 Root Directory 是否设置为 `backend/vercel`

解决方法：
1. 进入项目设置（Settings）
2. 找到 "Root Directory"
3. 修改为 `backend/vercel`
4. 保存并重新部署

### Q: API 返回 404

**A**: 检查以下几点：
1. URL 是否正确（应该包含 `/api/`）
2. 函数文件是否在 `api/` 文件夹中
3. 查看 Deployments 日志，确认部署成功

### Q: API 返回 500 错误

**A**: 
1. 确认数据库已创建并连接
2. 确认已执行初始化 SQL
3. 查看 Functions 日志，找到具体错误

### Q: 数据库连接失败

**A**: 
1. 确认数据库已连接到项目
2. 在 Settings → Environment Variables 中查看
3. 应该能看到 `POSTGRES_URL` 等变量

### Q: Vercel 找不到我的 GitHub 仓库

**A**: 
1. 访问 https://vercel.com/account/integrations
2. 找到 GitHub 集成
3. 点击 "Configure"
4. 确保授权了 `xintan` 仓库

---

## 📞 需要帮助？

如果遇到问题，告诉我：
1. 在哪一步遇到问题
2. 具体的错误信息
3. 截图（如果有）

我会帮你解决！

---

**现在开始部署吧！** 🚀
