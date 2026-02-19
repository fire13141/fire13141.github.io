#!/bin/bash

# 自动化推送脚本
# 仓库创建后运行此脚本

set -e

echo "🚀 开始自动化部署"
echo "========================================"

# 检查SSH认证
echo "🔑 检查SSH认证..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ SSH认证成功"
else
    echo "❌ SSH认证失败，请检查公钥配置"
    exit 1
fi

# 1. 推送博客网站
echo ""
echo "📦 推送博客网站..."
cd /root/.openclaw/workspace

# 检查远程仓库
if git remote | grep -q origin; then
    git remote remove origin
fi

git remote add origin git@github.com:fire13141/fire13141.github.io.git

if git push -u origin master 2>&1; then
    echo "✅ 博客网站推送成功"
else
    echo "⚠️  博客网站推送失败，可能仓库未创建"
    echo "请先创建仓库: fire13141.github.io"
    exit 1
fi

# 2. 推送部署包
echo ""
echo "📦 推送部署包..."
cd /root/.openclaw/workspace/cash-bot-deployment

if git remote | grep -q origin; then
    git remote remove origin
fi

git remote add origin git@github.com:fire13141/cash-bot-deployment.git

if git push -u origin master 2>&1; then
    echo "✅ 部署包推送成功"
else
    echo "⚠️  部署包推送失败，可能仓库未创建"
    echo "请先创建仓库: cash-bot-deployment"
    exit 1
fi

# 3. 显示成功信息
echo ""
echo "🎉 部署完成！"
echo "========================================"
echo ""
echo "✅ 访问链接："
echo "- 博客网站: https://fire13141.github.io/"
echo "- 部署包: https://github.com/fire13141/cash-bot-deployment"
echo "- 管理面板: https://fire13141.github.io/openclaw-managenment-panel/"
echo ""
echo "⏰ 页面生效需要1-2分钟"
echo ""
echo "🚀 下一步：更新管理面板"
echo "1. 访问现有管理面板GitHub仓库"
echo "2. 上传 openclaw-managenment-panel-index.html"
echo "3. 重命名为 index.html（覆盖）"
echo "4. 提交更改"
echo ""
echo "📊 验证部署："
echo "1. 访问博客网站，检查功能"
echo "2. 下载部署包，测试一键部署"
echo "3. 检查管理面板更新"
echo ""
echo "🔧 如有问题，运行验证："
echo "ssh -T git@github.com"
echo "curl -I https://fire13141.github.io/"