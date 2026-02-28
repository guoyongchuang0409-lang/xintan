-- 心探测试结果数据库
-- 创建数据库
CREATE DATABASE IF NOT EXISTS quiz_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE quiz_db;

-- 创建报告表
CREATE TABLE IF NOT EXISTS reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    share_code VARCHAR(10) NOT NULL UNIQUE,
    quiz_type_id VARCHAR(50) NOT NULL,
    quiz_type_name VARCHAR(100) NOT NULL,
    report_data JSON NOT NULL,
    created_at DATETIME NOT NULL,
    last_viewed_at DATETIME NULL,
    view_count INT DEFAULT 0,
    ip_address VARCHAR(45) NULL,
    INDEX idx_share_code (share_code),
    INDEX idx_quiz_type (quiz_type_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 创建管理员表（可选）
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 插入默认管理员账号（密码：admin123，请修改）
INSERT INTO admins (username, password_hash) 
VALUES ('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');
