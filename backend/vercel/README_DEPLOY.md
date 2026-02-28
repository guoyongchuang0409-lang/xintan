# 通过 GitHub 部署到 Vercel

## 📋 步骤一：上传代码到 GitHub

### 1. 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 填写信息：
   - **Repository name**: `quiz-backend`（或其他名称）
   - **Description**: 心探测试后端 API
   - **Public** 或 **Private**（都可以）
3. **不要**勾选 "Add a README file"
4. 点击 **"Create repository"**

### 2. 上传文件到 GitHub

#### 方式 A：使用 GitHub 网页上传（最简单）

1. 在新创建的仓库页面，点击 **"uploading an existing file"**
2. 将 `backend/vercel` 文件夹中的所有文件拖拽到上传区域：
   - `api/reports.js`
   - `api/stats.js`
   - `package.json`
   - `vercel.json`
   - `.gitignore`
   - `.vercelignore`
   - `README.md`
3. 在底部填写提交信息：`Initial commit`
4. 点击 **"Commit changes"**

#### 方式 B：使用 GitHub Desktop（如果已安装）

1. 打开 GitHub Desktop
2. File → Add Local Repository
3. 选择 `backend/vercel` 文件夹
4. 点击 "Publish repository"

---

## 📋 步骤二：连接 Vercel 和 GitHub

### 1. 访问 Vercel

1. 访问 https://vercel.com/
2. 点击 **"Sign Up"** 或 **"Login"**
3. **重要！选择 "Continue with GitHub"**（使用 GitHub 登录）
4. 授权 Vercel 访问你的 GitHub

### 2. 导入 GitHub 项目

1. 登录后，点击 **"Add New..."** → **"Project"**
2. 你会看到 **"Import Git Repository"** 部分
3. 找到你刚创建的仓库（quiz-backend）
4. 点击 **"Import"**

### 3. 配置项目

1. **Project Name**: 保持默认或修改
2. **Framework Preset**: 选择 **"Other"**
3. **Root Directory**: 保持默认 `./`
4. **Build Settings**: 保持默认
5. 点击 **"Deploy"** 按钮

### 4. 等待部署

- 部署过程约 30-60 秒
- 完成后会显示 🎉 Congratulations!
- **记录你的 API 地址**，例如：
  ```
  https://quiz-backend-xxx.vercel.app
  ```

---

## 📋 步骤三：创建数据库

### 1. 进入项目设置

1. 在 Vercel Dashboard 中，点击你的项目
2. 点击顶部的 **"Storage"** 标签

### 2. 创建 Postgres 数据库

1. 点击 **"Create Database"**
2. 选择 **"Postgres"**
3. 填写信息：
   - **Database Name**: `quiz_db`
   - **Region**: 选择 **"Singapore"** 或 **"Hong Kong"**
4. 点击 **"Create"**
5. 等待创建完成

### 3. 连接数据库到项目

1. 创建完成后，Vercel 会询问：**"Connect to Project"**
2. 选择你的项目（quiz-backend）
3. 点击 **"Connect"**
4. Vercel 会自动注入环境变量，无需手动配置！

---

## 📋 步骤四：初始化数据库表

### 1. 进入数据库

1. 在 Storage 页面，点击你的数据库（quiz_db）
2. 点击 **"Query"** 标签

### 2. 执行 SQL

复制以下 SQL 并执行：

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

点击 **"Run Query"**，看到 Success 即可。

---

## 📋 步骤五：测试 API

在浏览器中访问：
```
https://quiz-backend-xxx.vercel.app/api/stats
```

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

---

## 📋 步骤六：配置 Flutter 应用

在 `lib/core/services/database_service.dart` 中：

```dart
static const String _apiBaseUrl = 'https://quiz-backend-xxx.vercel.app';
```

---

## ✅ 完成！

现在每次你修改代码并推送到 GitHub，Vercel 都会自动重新部署！

---

## 🔄 后续更新

如果需要更新后端代码：
1. 修改本地文件
2. 在 GitHub 网页上传新文件（覆盖旧文件）
3. Vercel 自动检测并重新部署

---

## 📞 遇到问题？

### 问题：Vercel 找不到我的 GitHub 仓库

**解决**：
1. 访问 https://vercel.com/account/integrations
2. 找到 GitHub 集成
3. 点击 "Configure"
4. 确保授权了正确的仓库

### 问题：部署失败

**解决**：
1. 检查 `package.json` 文件是否存在
2. 检查 `api/` 文件夹中的文件是否完整
3. 查看 Vercel 的部署日志（Deployments → 点击失败的部署 → 查看日志）

### 问题：API 返回 500 错误

**解决**：
1. 确认数据库已创建并连接到项目
2. 确认已执行初始化 SQL
3. 检查 Vercel 的 Function Logs
