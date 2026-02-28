// 超简单的 Vercel Serverless API
// 使用文件系统存储（适合小项目）

const fs = require('fs').promises;
const path = require('path');

// 数据存储路径
const DATA_DIR = '/tmp/reports';

// 确保数据目录存在
async function ensureDataDir() {
  try {
    await fs.mkdir(DATA_DIR, { recursive: true });
  } catch (e) {
    // 目录已存在
  }
}

// 主处理函数
module.exports = async (req, res) => {
  // 设置 CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  await ensureDataDir();

  const { method, url } = req;
  const urlParts = url.split('/').filter(Boolean);

  try {
    // POST /api/reports - 上传报告
    if (method === 'POST' && urlParts[0] === 'reports') {
      const report = req.body;
      
      if (!report.shareCode) {
        return res.status(400).json({ error: '缺少分享码' });
      }

      const filePath = path.join(DATA_DIR, `${report.shareCode}.json`);
      
      // 检查是否已存在
      try {
        await fs.access(filePath);
        return res.status(409).json({ error: '分享码已存在' });
      } catch (e) {
        // 文件不存在，可以创建
      }

      // 保存报告
      await fs.writeFile(filePath, JSON.stringify({
        ...report,
        uploadedAt: new Date().toISOString()
      }));

      return res.status(201).json({ 
        success: true, 
        shareCode: report.shareCode 
      });
    }

    // GET /api/reports/:shareCode - 获取报告
    if (method === 'GET' && urlParts[0] === 'reports' && urlParts[1]) {
      const shareCode = urlParts[1].toUpperCase();
      const filePath = path.join(DATA_DIR, `${shareCode}.json`);

      try {
        const data = await fs.readFile(filePath, 'utf8');
        const report = JSON.parse(data);
        return res.status(200).json(report);
      } catch (e) {
        return res.status(404).json({ error: '报告不存在' });
      }
    }

    // GET /api/reports - 获取所有报告列表
    if (method === 'GET' && urlParts[0] === 'reports' && !urlParts[1]) {
      try {
        const files = await fs.readdir(DATA_DIR);
        const reports = [];

        for (const file of files) {
          if (file.endsWith('.json')) {
            const data = await fs.readFile(path.join(DATA_DIR, file), 'utf8');
            const report = JSON.parse(data);
            reports.push({
              shareCode: report.shareCode,
              uploadedAt: report.uploadedAt,
              personalityType: report.personalityType
            });
          }
        }

        // 按时间倒序
        reports.sort((a, b) => 
          new Date(b.uploadedAt) - new Date(a.uploadedAt)
        );

        return res.status(200).json({ reports });
      } catch (e) {
        return res.status(200).json({ reports: [] });
      }
    }

    // DELETE /api/reports/:shareCode - 删除报告
    if (method === 'DELETE' && urlParts[0] === 'reports' && urlParts[1]) {
      const shareCode = urlParts[1].toUpperCase();
      const filePath = path.join(DATA_DIR, `${shareCode}.json`);

      try {
        await fs.unlink(filePath);
        return res.status(200).json({ success: true });
      } catch (e) {
        return res.status(404).json({ error: '报告不存在' });
      }
    }

    return res.status(404).json({ error: '接口不存在' });

  } catch (error) {
    console.error('API Error:', error);
    return res.status(500).json({ error: '服务器错误', message: error.message });
  }
};
