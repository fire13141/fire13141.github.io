#!/bin/bash
# AI Tools Library 部署到 Netlify 脚本

echo "🚀 开始部署 AI Tools Library 到 Netlify"
echo "========================================"

# 检查必要文件
echo "📁 检查网站文件..."
if [ ! -f "index.html" ]; then
    echo "❌ 错误: index.html 不存在"
    exit 1
fi

if [ ! -f "netlify.toml" ]; then
    echo "❌ 错误: netlify.toml 不存在"
    exit 1
fi

echo "✅ 网站文件检查完成"

# 显示部署信息
echo ""
echo "📋 部署信息:"
echo "   网站名称: AI Tools Library | Smart Efficiency Guide"
echo "   目标平台: Netlify (免费)"
echo "   预计网址: https://ai-tools-library.netlify.app/"
echo "   国内访问: ✅ 可正常访问"
echo "   部署成本: $0 (完全免费)"
echo ""

# 部署步骤说明
echo "📝 部署步骤:"
echo "1. 访问 https://app.netlify.com/"
echo "2. 点击 'Sign up with GitHub'"
echo "3. 授权 GitHub 账号"
echo "4. 点击 'New site from Git'"
echo "5. 选择 GitHub"
echo "6. 选择仓库: fire13141/fire13141.github.io"
echo "7. 部署设置:"
echo "   - Build command: 留空 (静态网站)"
echo "   - Publish directory: ."
echo "   - Branch to deploy: main"
echo "8. 点击 'Deploy site'"
echo "9. 等待部署完成"
echo "10. 获取免费网址"
echo ""

# 验证部署
echo "🔍 部署验证:"
echo "- 访问部署后的网址"
echo "- 测试多语言功能"
echo "- 测试响应式设计"
echo "- 验证广告代码"
echo "- 检查移动端适配"
echo ""

# 后续步骤
echo "🎯 后续步骤:"
echo "1. 注册 Google AdSense (免费)"
echo "2. 获取发布商 ID"
echo "3. 替换 HTML 中的 YOUR_PUBLISHER_ID"
echo "4. 提交网站审核 (1-3天)"
echo "5. 开始添加 AI 工具内容"
echo "6. 推广网站获取流量"
echo ""

echo "✅ 部署准备完成!"
echo "立即访问 https://app.netlify.com/ 开始部署"
echo ""
echo "💡 提示: 部署时间约 10-15 分钟"
echo "🌐 免费网址: https://ai-tools-library.netlify.app/"
echo "💰 总成本: $0"

# 创建快速访问链接
echo ""
echo "📎 快速链接:"
echo "   Netlify注册: https://app.netlify.com/signup"
echo "   GitHub仓库: https://github.com/fire13141/fire13141.github.io"
echo "   部署指南: FREE-DEPLOYMENT.md"
echo "   网站规格: website-spec.md"