#!/bin/bash

# GitHub一键部署脚本
# 老板只需将SSH公钥添加到GitHub账户即可

set -e

echo "🚀 GitHub部署准备完成"
echo ""

echo "📋 需要老板完成的步骤："
echo "1. 登录GitHub: https://github.com"
echo "2. 添加SSH公钥到账户设置"
echo "3. 创建2个仓库（名称如下）"
echo ""

echo "🔑 SSH公钥（复制以下内容添加到GitHub）："
echo "========================================"
cat ~/.ssh/github_rsa.pub
echo "========================================"
echo ""

echo "📦 需要创建的GitHub仓库："
echo "1. 仓库名称: fire13141.github.io"
echo "   描述: 现金活动自动化机器人博客"
echo "   类型: Public"
echo "   初始化: 不添加README"
echo ""
echo "2. 仓库名称: cash-bot-deployment"
echo "   描述: 现金活动机器人一键部署包"
echo "   类型: Public"
echo "   初始化: 不添加README"
echo ""

echo "🚀 仓库创建后，运行以下命令："
echo ""
echo "# 1. 推送博客网站"
echo "cd /root/.openclaw/workspace"
echo "git remote add origin git@github.com:fire13141/fire13141.github.io.git"
echo "git push -u origin master"
echo ""
echo "# 2. 推送部署包"
echo "cd /root/.openclaw/workspace/cash-bot-deployment"
echo "git remote add origin git@github.com:fire13141/cash-bot-deployment.git"
echo "git push -u origin master"
echo ""

echo "✅ 完成后访问："
echo "- 博客网站: https://fire13141.github.io/"
echo "- 部署包: https://github.com/fire13141/cash-bot-deployment"
echo "- 管理面板: https://fire13141.github.io/openclaw-managenment-panel/"
echo ""

echo "📞 如有问题，检查SSH连接："
echo "ssh -T git@github.com"