# Vercel 后端部署指南

最后更新：2026-02-28

## 快速开始

### 1. 安装 Vercel CLI

```bash
npm install -g vercel
```

### 2. 登录 Vercel

```bash
vercel login
```

### 3. 部署到 Vercel

在 `backend/vercel` 目录下运行：

```bash
vercel
```

首次部署会询问：
- 项目名称：输入 `quiz-api` 或其他名称
- 是否链接到现有项目：选择 `N`（新项目）

### 4. 创建数据库

1. 访问 [Vercel Dashboard](https://vercel.com/dashboard)
2. 进入你的项目
3. 点击 "Storage" 标签
4. 点击 "Create Database"
5. 选择 "Postgres"
6. 创建数据库（免费版）

### 5. 初始化数据库表

在 Vercel Dashboard 的 Postgres 数据库中，点击 "Query" 标签，执行以下 SQL：

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

### 6. 获取 API 地址

部署成功后，Vercel 会给你一个地址，例如：
```
https://quiz-api-xxx.vercel.app
```

你的 API 端点：
- 保存报告：`POST https://quiz-api-xxx.vercel.app/api/reports`
- 获取报告：`GET https://quiz-api-xxx.vercel.app/api/reports?shareCode=ABC123`
- 获取列表：`GET https://quiz-api-xxx.vercel.app/api/reports?page=1&limit=20`
- 统计数据：`GET https://quiz-api-xxx.vercel.app/api/stats`
- 删除报告：`DELETE https://quiz-api-xxx.vercel.app/api/reports?shareCode=ABC123`

### 7. 更新 Flutter 应用

在 Flutter 应用中，将 API 地址更新为你的 Vercel 地址。

## API 文档

### 保存报告

```bash
POST /api/reports
Content-Type: application/json

{
  "shareCode": "ABC123",
  "quizTypeId": "female_m",
  "quizTypeName": "女性M倾向测试",
  "reportData": { ... }
}
```

### 获取单个报告

```bash
GET /api/reports?shareCode=ABC123
```

### 获取报告列表（分页）

```bash
GET /api/reports?page=1&limit=20&quizType=female_m
```

### 获取统计数据

```bash
GET /api/stats
```

### 删除报告

```bash
DELETE /api/reports?shareCode=ABC123
```

## 环境变量

Vercel 会自动注入以下环境变量（创建数据库后）：
- `POSTGRES_URL`
- `POSTGRES_PRISMA_URL`
- `POSTGRES_URL_NON_POOLING`
- `POSTGRES_USER`
- `POSTGRES_HOST`
- `POSTGRES_PASSWORD`
- `POSTGRES_DATABASE`

无需手动配置！

## 优势

✅ 完全免费（Hobby 计划）
✅ 自动 HTTPS
✅ 全球 CDN
✅ 自动扩展
✅ 中国可访问（不需要魔法）
✅ 简单部署（一条命令）

## 限制

- 免费版数据库：256 MB 存储
- 每月 100 GB 带宽
- 对于测试应用来说完全够用

## 故障排查

### 数据库连接失败

确保在 Vercel Dashboard 中已经创建了 Postgres 数据库，并且环境变量已自动注入。

### CORS 错误

已在 `vercel.json` 中配置了 CORS，如果仍有问题，检查浏览器控制台的具体错误信息。

### API 404

确保 API 文件在 `api/` 目录下，Vercel 会自动识别并部署。
