/**
 * Vercel Serverless API - 测试报告管理
 * 部署到 Vercel 后自动可用
 */

import { sql } from '@vercel/postgres';

// 允许跨域访问
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type',
};

export default async function handler(req, res) {
  // 处理 OPTIONS 预检请求
  if (req.method === 'OPTIONS') {
    return res.status(200).json({});
  }

  try {
    // 检查表是否存在
    const tableCheck = await sql`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_name = 'reports'
      )
    `;

    if (!tableCheck.rows[0].exists) {
      return res.status(503).json({ 
        success: false, 
        error: '数据库表尚未创建，请先初始化数据库' 
      });
    }

    // POST - 保存新报告
    if (req.method === 'POST') {
      const { shareCode, quizTypeId, quizTypeName, reportData } = req.body;

      if (!shareCode || !reportData) {
        return res.status(400).json({ 
          success: false, 
          error: '缺少必要参数' 
        });
      }

      // 插入数据库
      await sql`
        INSERT INTO reports (
          share_code, quiz_type_id, quiz_type_name, 
          report_data, created_at, ip_address
        ) VALUES (
          ${shareCode}, 
          ${quizTypeId}, 
          ${quizTypeName}, 
          ${JSON.stringify(reportData)}, 
          NOW(), 
          ${req.headers['x-forwarded-for'] || req.connection.remoteAddress}
        )
        ON CONFLICT (share_code) DO UPDATE SET
          report_data = ${JSON.stringify(reportData)},
          updated_at = NOW()
      `;

      return res.status(200).json({
        success: true,
        shareCode,
        message: '保存成功',
      });
    }

    // GET - 获取报告
    if (req.method === 'GET') {
      const { shareCode, page = 1, limit = 20, quizType } = req.query;

      // 获取单个报告
      if (shareCode) {
        const result = await sql`
          SELECT report_data, view_count, created_at
          FROM reports
          WHERE share_code = ${shareCode}
        `;

        if (result.rows.length === 0) {
          return res.status(404).json({ 
            success: false, 
            error: '报告不存在' 
          });
        }

        // 增加浏览次数
        await sql`
          UPDATE reports 
          SET view_count = view_count + 1, last_viewed_at = NOW()
          WHERE share_code = ${shareCode}
        `;

        return res.status(200).json({
          success: true,
          data: {
            ...result.rows[0].report_data,
            viewCount: result.rows[0].view_count + 1,
          },
        });
      }

      // 获取报告列表（管理员功能）
      const offset = (page - 1) * limit;
      let countQuery, dataQuery;

      if (quizType) {
        countQuery = await sql`
          SELECT COUNT(*) as total FROM reports 
          WHERE quiz_type_id = ${quizType}
        `;
        dataQuery = await sql`
          SELECT id, share_code, quiz_type_id, quiz_type_name, 
                 created_at, view_count
          FROM reports
          WHERE quiz_type_id = ${quizType}
          ORDER BY created_at DESC
          LIMIT ${limit} OFFSET ${offset}
        `;
      } else {
        countQuery = await sql`SELECT COUNT(*) as total FROM reports`;
        dataQuery = await sql`
          SELECT id, share_code, quiz_type_id, quiz_type_name, 
                 created_at, view_count
          FROM reports
          ORDER BY created_at DESC
          LIMIT ${limit} OFFSET ${offset}
        `;
      }

      const total = parseInt(countQuery.rows[0].total);

      return res.status(200).json({
        success: true,
        data: dataQuery.rows,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total,
          pages: Math.ceil(total / limit),
        },
      });
    }

    // DELETE - 删除报告（管理员功能）
    if (req.method === 'DELETE') {
      const { shareCode } = req.query;

      if (!shareCode) {
        return res.status(400).json({ 
          success: false, 
          error: '缺少分享码' 
        });
      }

      const result = await sql`
        DELETE FROM reports WHERE share_code = ${shareCode}
      `;

      if (result.rowCount === 0) {
        return res.status(404).json({ 
          success: false, 
          error: '报告不存在' 
        });
      }

      return res.status(200).json({
        success: true,
        message: '删除成功',
      });
    }

    return res.status(405).json({ 
      success: false, 
      error: '方法不允许' 
    });

  } catch (error) {
    console.error('API Error:', error);
    return res.status(500).json({ 
      success: false, 
      error: error.message 
    });
  }
}

export const config = {
  api: {
    bodyParser: true,
  },
};
