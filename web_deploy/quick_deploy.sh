#!/bin/bash

# 心探 Web 应用快速部署脚�?# 使用 rsync 将文件上传到服务�?
# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 心探 Web 应用快速部署工�?{NC}"
echo ""

# 检查参�?if [ -z "$1" ]; then
    echo -e "${RED}�?错误: 请提供服务器地址${NC}"
    echo ""
    echo "使用方法:"
    echo "  ./quick_deploy.sh user@server:/path/to/deploy"
    echo ""
    echo "示例:"
    echo "  ./quick_deploy.sh root@example.com:/var/www/html/xintan"
    echo "  ./quick_deploy.sh ubuntu@192.168.1.100:/usr/share/nginx/html/xintan"
    echo ""
    exit 1
fi

SERVER_PATH="$1"

# 确认部署
echo -e "${YELLOW}准备部署�? ${SERVER_PATH}${NC}"
echo ""
read -p "确认部署? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}�?部署已取�?{NC}"
    exit 1
fi

# 检�?rsync 是否安装
if ! command -v rsync &> /dev/null; then
    echo -e "${RED}�?错误: rsync 未安�?{NC}"
    echo "请先安装 rsync:"
    echo "  Ubuntu/Debian: sudo apt install rsync"
    echo "  CentOS/RHEL: sudo yum install rsync"
    echo "  macOS: brew install rsync"
    exit 1
fi

echo ""
echo -e "${GREEN}📦 开始上传文�?..${NC}"
echo ""

# 使用 rsync 上传文件
# 排除不需要的文件
rsync -avz --progress \
    --exclude='*.sh' \
    --exclude='*.example' \
    --exclude='DEPLOY_README.md' \
    --exclude='.DS_Store' \
    --exclude='Thumbs.db' \
    ./ "$SERVER_PATH"

# 检查上传结�?if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}�?部署成功�?{NC}"
    echo ""
    echo "后续步骤:"
    echo "1. 确保服务器配置正确（Nginx �?Apache�?
    echo "2. 配置 HTTPS（推荐使�?Let's Encrypt�?
    echo "3. 测试应用功能"
    echo "4. 配置域名 DNS"
    echo ""
    echo "访问你的应用: http://your-domain.com"
    echo ""
else
    echo ""
    echo -e "${RED}�?部署失败${NC}"
    echo "请检�?"
    echo "1. 服务器地址是否正确"
    echo "2. SSH 连接是否正常"
    echo "3. 目标目录是否有写入权�?
    echo ""
    exit 1
fi
