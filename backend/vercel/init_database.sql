-- Vercel Postgres 数据库初始化脚本
-- 在 Vercel Dashboard 的 Postgres Query 界面执行此脚本

-- 创建报告表
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

-- 创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_quiz_type ON reports(quiz_type_id);
CREATE INDEX IF NOT EXISTS idx_created_at ON reports(created_at);
CREATE INDEX IF NOT EXISTS idx_view_count ON reports(view_count);

-- 添加注释
COMMENT ON TABLE reports IS '测试报告表';
COMMENT ON COLUMN reports.id IS '主键ID';
COMMENT ON COLUMN reports.share_code IS '分享码（唯一）';
COMMENT ON COLUMN reports.quiz_type_id IS '测试类型ID';
COMMENT ON COLUMN reports.quiz_type_name IS '测试类型名称';
COMMENT ON COLUMN reports.report_data IS '报告数据（JSON格式）';
COMMENT ON COLUMN reports.created_at IS '创建时间';
COMMENT ON COLUMN reports.updated_at IS '更新时间';
COMMENT ON COLUMN reports.last_viewed_at IS '最后查看时间';
COMMENT ON COLUMN reports.view_count IS '浏览次数';
COMMENT ON COLUMN reports.ip_address IS 'IP地址';

-- 验证表是否创建成功
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable
FROM 
    information_schema.columns
WHERE 
    table_name = 'reports'
ORDER BY 
    ordinal_position;

-- 查看索引
SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'reports';
