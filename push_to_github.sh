#!/bin/bash

echo "========================================"
echo "推送代码到 GitHub"
echo "========================================"
echo ""

# 检查是否已初始化 Git
if [ ! -d ".git" ]; then
    echo "[步骤 1/4] 初始化 Git 仓库..."
    git init
    echo ""
else
    echo "[提示] Git 仓库已存在"
    echo ""
fi

echo "[步骤 2/4] 添加远程仓库..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/guoyongchuang0409-lang/xintan.git
echo ""

echo "[步骤 3/4] 添加所有文件..."
git add .
echo ""

echo "[步骤 4/4] 提交并推送..."
git commit -m "添加数据库功能 - Vercel 后端"
git branch -M main
git push -u origin main --force
echo ""

echo "========================================"
echo "推送完成！"
echo "========================================"
echo ""
echo "接下来："
echo "1. 访问 https://vercel.com/"
echo "2. 使用 GitHub 登录"
echo "3. 导入 xintan 仓库"
echo "4. 部署项目"
echo ""
