#!/bin/bash

# 🔧 现金活动机器人部署验证脚本
# 版本: v2.0
# 用途: 验证部署是否成功，检查所有功能

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 日志函数
log_info() { echo -e "${BLUE}[验证]${NC} $1"; }
log_success() { echo -e "${GREEN}[通过]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[警告]${NC} $1"; }
log_error() { echo -e "${RED}[失败]${NC} $1"; }

# 验证计数器
total_tests=0
passed_tests=0
failed_tests=0
warning_tests=0

# 运行测试并计数
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected="$3"
    
    total_tests=$((total_tests + 1))
    log_info "$test_name..."
    
    if eval "$test_command" 2>/dev/null; then
        passed_tests=$((passed_tests + 1))
        log_success "$test_name"
        return 0
    else
        failed_tests=$((failed_tests + 1))
        log_error "$test_name"
        return 1
    fi
}

run_test_warning() {
    local test_name="$1"
    local test_command="$2"
    
    total_tests=$((total_tests + 1))
    log_info "$test_name..."
    
    if eval "$test_command" 2>/dev/null; then
        passed_tests=$((passed_tests + 1))
        log_success "$test_name"
        return 0
    else
        warning_tests=$((warning_tests + 1))
        log_warning "$test_name (非关键)"
        return 1
    fi
}

echo "================================================"
echo "🔧 现金活动机器人部署验证"
echo "================================================"
echo "开始时间: $(date)"
echo ""

# 1. 基础环境验证
echo "1. 基础环境验证"
echo "----------------"

run_test "OpenClaw运行状态" "openclaw status &> /dev/null"
run_test "Python版本检查" "python3 --version | grep -q 'Python 3'"
run_test "Git安装检查" "git --version &> /dev/null"
run_test "Workspace目录存在" "[ -d \"$HOME/.openclaw/workspace\" ]"
echo ""

# 2. 配置文件验证
echo "2. 配置文件验证"
echo "----------------"

run_test "主配置文件存在" "[ -f \"$HOME/.openclaw/config.yaml\" ]"
run_test "配置文件可读" "cat \"$HOME/.openclaw/config.yaml\" | grep -q 'cash_activities'"
run_test "配置文件包含用户信息" "cat \"$HOME/.openclaw/config.yaml\" | grep -q '15822348053'"
echo ""

# 3. 记忆文件验证
echo "3. 记忆文件验证"
echo "----------------"

run_test "长期记忆文件存在" "[ -f \"$HOME/.openclaw/workspace/MEMORY.md\" ]"
run_test "长期记忆内容完整" "cat \"$HOME/.openclaw/workspace/MEMORY.md\" | grep -q '现金活动'"
run_test "日常记忆目录存在" "[ -d \"$HOME/.openclaw/workspace/memory\" ]"
run_test "身份文件存在" "[ -f \"$HOME/.openclaw/workspace/IDENTITY.md\" ]"
run_test "用户文件存在" "[ -f \"$HOME/.openclaw/workspace/USER.md\" ]"
echo ""

# 4. 技能文件验证
echo "4. 技能文件验证"
echo "----------------"

run_test_warning "技能目录存在" "[ -d \"$HOME/.openclaw/skills\" ]"
run_test_warning "技能列表可获取" "openclaw skills list 2>/dev/null | head -5"
echo ""

# 5. 功能响应验证
echo "5. 功能响应验证"
echo "----------------"

# 测试响应时间
log_info "测试响应时间..."
start_time=$(date +%s%N)
if echo "测试" | timeout 10 openclaw chat &> /dev/null; then
    end_time=$(date +%s%N)
    response_ms=$(( (end_time - start_time) / 1000000 ))
    if [ "$response_ms" -le 5000 ]; then
        passed_tests=$((passed_tests + 1))
        log_success "响应时间: ${response_ms}ms (目标: ≤5000ms)"
    else
        warning_tests=$((warning_tests + 1))
        log_warning "响应时间: ${response_ms}ms (较慢，目标: ≤5000ms)"
    fi
else
    failed_tests=$((failed_tests + 1))
    log_error "响应测试失败"
fi
total_tests=$((total_tests + 1))

# 测试记忆查询
run_test_warning "记忆查询功能" "echo '现金活动' | timeout 10 openclaw chat | grep -q -i '现金'"
echo ""

# 6. 现金活动配置验证
echo "6. 现金活动配置验证"
echo "----------------"

run_test "配置文件包含活动列表" "cat \"$HOME/.openclaw/config.yaml\" | grep -q '支付宝新春红包'"
run_test "配置文件包含收益预期" "cat \"$HOME/.openclaw/config.yaml\" | grep -q '87-314'"
run_test "用户信息完整" "cat \"$HOME/.openclaw/workspace/USER.md\" | grep -q '10821558@qq.com'"
echo ""

# 7. 安全配置验证
echo "7. 安全配置验证"
echo "----------------"

run_test_warning "配置文件包含安全设置" "cat \"$HOME/.openclaw/config.yaml\" | grep -q 'security'"
run_test_warning "API限制配置" "cat \"$HOME/.openclaw/config.yaml\" | grep -q 'max_api_calls_per_day'"
echo ""

# 验证结果汇总
echo "================================================"
echo "📊 验证结果汇总"
echo "================================================"
echo "总测试数: $total_tests"
echo "通过测试: $passed_tests"
echo "失败测试: $failed_tests"
echo "警告测试: $warning_tests"
echo ""

# 计算通过率
if [ $total_tests -gt 0 ]; then
    pass_rate=$((passed_tests * 100 / total_tests))
else
    pass_rate=0
fi

# 显示结果
if [ $failed_tests -eq 0 ]; then
    if [ $warning_tests -eq 0 ]; then
        echo -e "${GREEN}🎉 完美通过！所有测试成功${NC}"
        echo "通过率: ${pass_rate}%"
        echo "部署状态: 完全成功"
        echo "建议: 立即开始现金活动"
    else
        echo -e "${GREEN}✅ 基本通过！核心功能正常${NC}"
        echo "通过率: ${pass_rate}%"
        echo "部署状态: 成功（有非关键警告）"
        echo "建议: 可以开始现金活动，注意警告项"
    fi
else
    echo -e "${YELLOW}⚠️  部分失败！需要检查${NC}"
    echo "通过率: ${pass_rate}%"
    echo "部署状态: 部分成功"
    echo "建议: 修复失败项后再开始现金活动"
fi

echo ""
echo "🔧 后续步骤:"
if [ $failed_tests -eq 0 ]; then
    echo "1. 访问管理面板: https://fire13141.github.io/openclaw-managenment-panel/"
    echo "2. 查看现金活动列表"
    echo "3. 开始参与活动获取收益"
else
    echo "1. 检查失败测试项"
    echo "2. 重新运行部署脚本: ./deploy.sh"
    echo "3. 再次运行验证: ./verify-deployment.sh"
fi

echo ""
echo "📞 技术支持:"
echo "- 查看部署指南: cat deployment-guide.md | head -50"
echo "- 联系QQ: 10821558"
echo "- 邮箱: 10821558@qq.com"

echo ""
echo "验证完成时间: $(date)"
echo "================================================"

# 保存验证报告
report_file="$HOME/cash-bot-verify-$(date +%Y%m%d_%H%M%S).log"
{
    echo "现金活动机器人部署验证报告"
    echo "验证时间: $(date)"
    echo "总测试数: $total_tests"
    echo "通过测试: $passed_tests"
    echo "失败测试: $failed_tests"
    echo "警告测试: $warning_tests"
    echo "通过率: ${pass_rate}%"
    echo ""
    echo "系统信息:"
    echo "- 主机名: $(hostname)"
    echo "- 系统: $(uname -a)"
    echo "- Python: $(python3 --version)"
    echo "- OpenClaw: $(openclaw --version 2>/dev/null || echo '未知')"
} > "$report_file"

log_success "验证报告已保存到: $report_file"

# 根据测试结果退出
if [ $failed_tests -eq 0 ]; then
    exit 0
else
    exit 1
fi