#!/bin/bash

# 项目进展监控脚本
# 自动监控部署状态和测试进展

set -e

echo "📊 现金活动机器人项目监控"
echo "========================================"
echo "监控时间: $(date)"
echo ""

# 1. 检查博客网站状态
echo "🌐 博客网站状态:"
if curl -s -I https://fire13141.github.io/ 2>&1 | grep -q "200\|301\|302"; then
    echo "✅ 在线 (https://fire13141.github.io/)"
else
    echo "❌ 离线或未启用GitHub Pages"
    echo "   需要启用: 仓库Settings → Pages → Branch: master → Folder: /"
fi

# 2. 检查部署包状态
echo ""
echo "📦 部署包状态:"
if curl -s https://api.github.com/repos/fire13141/cash-bot-deployment 2>&1 | grep -q "not found"; then
    echo "❌ 仓库不存在"
else
    echo "✅ 仓库正常 (https://github.com/fire13141/cash-bot-deployment)"
    
    # 检查最近更新
    last_update=$(curl -s https://api.github.com/repos/fire13141/cash-bot-deployment/commits 2>&1 | grep -o '"date":"[^"]*"' | head -1 | cut -d'"' -f4)
    if [ -n "$last_update" ]; then
        echo "   最近更新: $last_update"
    fi
fi

# 3. 检查管理面板状态
echo ""
echo "🛠️  管理面板状态:"
if curl -s -I https://fire13141.github.io/openclaw-managenment-panel/ 2>&1 | grep -q "200\|301\|302"; then
    echo "✅ 在线 (https://fire13141.github.io/openclaw-managenment-panel/)"
    
    # 检查是否包含培训清单链接
    if curl -s https://fire13141.github.io/openclaw-managenment-panel/ | grep -q "培训清单"; then
        echo "✅ 包含培训清单链接"
    else
        echo "⚠️  可能未更新培训清单链接"
    fi
else
    echo "❌ 离线"
fi

# 4. 检查测试数据
echo ""
echo "📈 测试进展:"
DATA_DIR="/root/.openclaw/workspace/test-data"
if [ -d "$DATA_DIR" ]; then
    today=$(date +%Y-%m-%d)
    if [ -f "$DATA_DIR/test-log-$today.txt" ]; then
        total_tests=$(grep -c "测试用户:" "$DATA_DIR/test-log-$today.txt" 2>/dev/null || echo 0)
        success_tests=$(grep -c "成功: y" "$DATA_DIR/test-log-$today.txt" 2>/dev/null || echo 0)
        
        echo "今日测试数: $total_tests"
        echo "成功数: $success_tests"
        
        if [ "$total_tests" -gt 0 ]; then
            success_rate=$((success_tests * 100 / total_tests))
            echo "成功率: ${success_rate}%"
        fi
    else
        echo "今日暂无测试数据"
    fi
else
    echo "测试数据目录未创建"
fi

# 5. 系统状态
echo ""
echo "⚙️  系统状态:"
# 检查OpenClaw
if openclaw status &> /dev/null; then
    echo "✅ OpenClaw运行正常"
else
    echo "❌ OpenClaw未运行"
fi

# 检查GitHub认证
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ GitHub SSH认证正常"
else
    echo "❌ GitHub SSH认证失败"
fi

# 6. 下一步建议
echo ""
echo "🚀 下一步建议:"
if curl -s -I https://fire13141.github.io/ 2>&1 | grep -q "404"; then
    echo "1. 启用GitHub Pages: 仓库Settings → Pages"
fi

if [ ! -d "$DATA_DIR" ] || [ ! -f "$DATA_DIR/test-log-$(date +%Y-%m-%d).txt" ]; then
    echo "2. 开始新用户测试: 运行 ./start-testing.sh"
fi

echo "3. 监控测试进展: 运行 ./test-data-collector.sh"
echo "4. 优化部署流程: 根据测试反馈改进"

# 7. 项目健康度
echo ""
echo "🏥 项目健康度:"
components=0
healthy=0

# 博客网站
if curl -s -I https://fire13141.github.io/ 2>&1 | grep -q "200\|301\|302"; then
    ((healthy++))
fi
((components++))

# 部署包
if curl -s https://api.github.com/repos/fire13141/cash-bot-deployment 2>&1 | grep -q '"name":'; then
    ((healthy++))
fi
((components++))

# 管理面板
if curl -s -I https://fire13141.github.io/openclaw-managenment-panel/ 2>&1 | grep -q "200\|301\|302"; then
    ((healthy++))
fi
((components++))

health_rate=$((healthy * 100 / components))
echo "组件健康度: ${health_rate}% ($healthy/$components)"

if [ "$health_rate" -ge 80 ]; then
    echo "✅ 项目状态良好"
elif [ "$health_rate" -ge 50 ]; then
    echo "⚠️  项目状态一般，需要优化"
else
    echo "❌ 项目状态较差，需要紧急处理"
fi

echo ""
echo "========================================"
echo "监控完成: $(date)"