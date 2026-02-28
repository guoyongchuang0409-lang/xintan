/**
 * Vercel Serverless API - 统计数据
 */

import { sql } from '@vercel/postgres';

export default async function handler(req, res) {
  if (req.method === 'OPTIONS') {
    return res.status(200).json({});
  }

  if (req.method !== 'GET') {
    return res.status(405).json({ 
      success: false, 
      error: '方法不允许' 
    });
  }

  try {
    // 总报告数
    const totalResult = await sql`SELECT COUNT(*) as total FROM reports`;
    const total = parseInt(totalResult.rows[0].total);

    // 按测试类型统计
    const typeResult = await sql`
      SELECT quiz_type_name, COUNT(*) as count
      FROM reports
      GROUP BY quiz_type_name
      ORDER BY count DESC
    `;

    // 今日新增
    const todayResult = await sql`
      SELECT COUNT(*) as count
      FROM reports
      WHERE DATE(created_at) = CURRENT_DATE
    `;
    const today = parseInt(todayResult.rows[0].count);

    // 本周新增
    const weekResult = await sql`
      SELECT COUNT(*) as count
      FROM reports
      WHERE created_at >= DATE_TRUNC('week', CURRENT_DATE)
    `;
    const week = parseInt(weekResult.rows[0].count);

    // 总浏览次数
    const viewsResult = await sql`SELECT SUM(view_count) as total FROM reports`;
    const totalViews = parseInt(viewsResult.rows[0].total || 0);

    return res.status(200).json({
      success: true,
      data: {
        totalReports: total,
        todayReports: today,
        weekReports: week,
        totalViews,
        byType: typeResult.rows,
      },
    });

  } catch (error) {
    console.error('Stats API Error:', error);
    return res.status(500).json({ 
      success: false, 
      error: error.message 
    });
  }
}
