<?php
/**
 * 心探测试结果 API
 * 简单的 REST API 用于保存和获取测试结果
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// 处理 OPTIONS 预检请求
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// 数据库配置
define('DB_HOST', 'localhost');
define('DB_NAME', 'quiz_db');
define('DB_USER', 'your_username');
define('DB_PASS', 'your_password');

// 连接数据库
function getDB() {
    try {
        $pdo = new PDO(
            "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
            DB_USER,
            DB_PASS,
            [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]
        );
        return $pdo;
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => '数据库连接失败']);
        exit();
    }
}

// 获取请求方法和路径
$method = $_SERVER['REQUEST_METHOD'];
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$path = str_replace('/api.php', '', $path);

// 路由处理
try {
    $db = getDB();
    
    switch ($method) {
        case 'POST':
            if ($path === '/reports' || $path === '/reports/') {
                // 保存新的测试报告
                saveReport($db);
            } else {
                http_response_code(404);
                echo json_encode(['error' => '接口不存在']);
            }
            break;
            
        case 'GET':
            if ($path === '/reports' || $path === '/reports/') {
                // 获取所有报告列表（分页）
                getReports($db);
            } elseif (preg_match('/^\/reports\/([a-zA-Z0-9]+)$/', $path, $matches)) {
                // 获取单个报告详情
                getReportById($db, $matches[1]);
            } elseif ($path === '/stats' || $path === '/stats/') {
                // 获取统计数据
                getStats($db);
            } else {
                http_response_code(404);
                echo json_encode(['error' => '接口不存在']);
            }
            break;
            
        case 'DELETE':
            if (preg_match('/^\/reports\/([a-zA-Z0-9]+)$/', $path, $matches)) {
                // 删除报告
                deleteReport($db, $matches[1]);
            } else {
                http_response_code(404);
                echo json_encode(['error' => '接口不存在']);
            }
            break;
            
        default:
            http_response_code(405);
            echo json_encode(['error' => '方法不允许']);
            break;
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}

// 保存报告
function saveReport($db) {
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input || !isset($input['shareCode'])) {
        http_response_code(400);
        echo json_encode(['error' => '无效的数据']);
        return;
    }
    
    $stmt = $db->prepare("
        INSERT INTO reports (
            share_code, quiz_type_id, quiz_type_name, 
            report_data, created_at, ip_address
        ) VALUES (?, ?, ?, ?, NOW(), ?)
    ");
    
    $stmt->execute([
        $input['shareCode'],
        $input['quizTypeId'],
        $input['quizTypeName'],
        json_encode($input, JSON_UNESCAPED_UNICODE),
        $_SERVER['REMOTE_ADDR']
    ]);
    
    echo json_encode([
        'success' => true,
        'shareCode' => $input['shareCode'],
        'shareUrl' => 'https://xintan.netlify.app/shared/' . $input['shareCode']
    ]);
}

// 获取报告列表
function getReports($db) {
    $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 20;
    $offset = ($page - 1) * $limit;
    
    $quizType = isset($_GET['quizType']) ? $_GET['quizType'] : null;
    
    // 构建查询
    $where = $quizType ? "WHERE quiz_type_id = ?" : "";
    
    // 获取总数
    $countStmt = $db->prepare("SELECT COUNT(*) as total FROM reports $where");
    if ($quizType) {
        $countStmt->execute([$quizType]);
    } else {
        $countStmt->execute();
    }
    $total = $countStmt->fetch()['total'];
    
    // 获取数据
    $stmt = $db->prepare("
        SELECT 
            id, share_code, quiz_type_id, quiz_type_name, 
            created_at, view_count
        FROM reports 
        $where
        ORDER BY created_at DESC 
        LIMIT ? OFFSET ?
    ");
    
    if ($quizType) {
        $stmt->execute([$quizType, $limit, $offset]);
    } else {
        $stmt->execute([$limit, $offset]);
    }
    
    $reports = $stmt->fetchAll();
    
    echo json_encode([
        'success' => true,
        'data' => $reports,
        'pagination' => [
            'page' => $page,
            'limit' => $limit,
            'total' => $total,
            'pages' => ceil($total / $limit)
        ]
    ]);
}

// 获取单个报告
function getReportById($db, $shareCode) {
    $stmt = $db->prepare("
        SELECT report_data, view_count 
        FROM reports 
        WHERE share_code = ?
    ");
    $stmt->execute([$shareCode]);
    $result = $stmt->fetch();
    
    if (!$result) {
        http_response_code(404);
        echo json_encode(['error' => '报告不存在']);
        return;
    }
    
    // 增加浏览次数
    $updateStmt = $db->prepare("
        UPDATE reports 
        SET view_count = view_count + 1, last_viewed_at = NOW() 
        WHERE share_code = ?
    ");
    $updateStmt->execute([$shareCode]);
    
    $data = json_decode($result['report_data'], true);
    $data['viewCount'] = $result['view_count'] + 1;
    
    echo json_encode([
        'success' => true,
        'data' => $data
    ]);
}

// 获取统计数据
function getStats($db) {
    // 总报告数
    $totalStmt = $db->query("SELECT COUNT(*) as total FROM reports");
    $total = $totalStmt->fetch()['total'];
    
    // 按测试类型统计
    $typeStmt = $db->query("
        SELECT quiz_type_name, COUNT(*) as count 
        FROM reports 
        GROUP BY quiz_type_name
        ORDER BY count DESC
    ");
    $byType = $typeStmt->fetchAll();
    
    // 今日新增
    $todayStmt = $db->query("
        SELECT COUNT(*) as count 
        FROM reports 
        WHERE DATE(created_at) = CURDATE()
    ");
    $today = $todayStmt->fetch()['count'];
    
    // 本周新增
    $weekStmt = $db->query("
        SELECT COUNT(*) as count 
        FROM reports 
        WHERE YEARWEEK(created_at) = YEARWEEK(NOW())
    ");
    $week = $weekStmt->fetch()['count'];
    
    // 总浏览次数
    $viewsStmt = $db->query("SELECT SUM(view_count) as total FROM reports");
    $totalViews = $viewsStmt->fetch()['total'] ?? 0;
    
    echo json_encode([
        'success' => true,
        'data' => [
            'totalReports' => $total,
            'todayReports' => $today,
            'weekReports' => $week,
            'totalViews' => $totalViews,
            'byType' => $byType
        ]
    ]);
}

// 删除报告
function deleteReport($db, $shareCode) {
    $stmt = $db->prepare("DELETE FROM reports WHERE share_code = ?");
    $stmt->execute([$shareCode]);
    
    if ($stmt->rowCount() > 0) {
        echo json_encode(['success' => true, 'message' => '删除成功']);
    } else {
        http_response_code(404);
        echo json_encode(['error' => '报告不存在']);
    }
}
