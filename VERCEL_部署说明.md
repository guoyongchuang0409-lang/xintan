# Vercel 部署说明

## ✅ 正确的部署方法

### 在 Vercel Dashboard 中设置：

1. **进入项目设置**
   - 点击 Settings 标签

2. **设置 Root Directory**
   - 找到 "Build & Development Settings"
   - 点击 "Root Directory" 的 Edit 按钮
   - 输入：`backend/vercel`
   - 点击 Save

3. **重新部署**
   - 点击 Deployments 标签
   - 点击最新部署的 "..." 按钮
   - 选择 Redeploy

### 为什么要这样设置？

- API 文件在 `backend/vercel/api/` 目录下
- Vercel 需要从 `backend/vercel` 作为根目录才能找到 `api/` 文件夹
- `backend/vercel/vercel.json` 包含了正确的配置

### 部署成功后

访问：`https://你的域名.vercel.app/api/stats`

应该返回：
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

## 🔧 如果还是 404

说明 Root Directory 设置没有生效，需要：

1. 删除当前项目
2. 重新导入 GitHub 仓库
3. 在导入时就设置 Root Directory 为 `backend/vercel`
