#!/bin/bash

# 测试数据收集脚本
# 自动收集和分析测试结果

set -e

DATA_DIR="/root/.openclaw/workspace/test-data"
mkdir -p "$DATA_DIR"

# 1. 收集今日测试数据
collect_today_data() {
    local date=$(date +%Y-%m-%d)
    local data_file="$DATA_DIR/test-$date.json"
    
    # 创建数据模板
    cat > "$data_file" << EOF
{
  "date": "$date",
  "test_users": 0,
  "success_count": 0,
  "fail_count": 0,
  "avg_deploy_time": 0,
  "issues": [],
  "feedbacks": [],
  "suggestions": []
}
EOF
    
    echo "测试数据文件创建: $data_file"
}

# 2. 添加测试结果
add_test_result() {
    local date=$(date +%Y-%m-%d)
    local data_file="$DATA_DIR/test-$date.json"
    
    if [ ! -f "$data_file" ]; then
        collect_today_data
    fi
    
    echo ""
    echo "📝 添加测试结果"
    read -p "测试用户: " user
    read -p "部署时间(分钟): " deploy_time
    read -p "是否成功 (y/n): " success
    read -p "遇到的问题: " issues
    read -p "改进建议: " suggestions
    
    # 更新数据（简化版）
    echo "测试用户: $user, 时间: ${deploy_time}分钟, 成功: $success" >> "$DATA_DIR/test-log-$date.txt"
    echo "问题: $issues" >> "$DATA_DIR/test-log-$date.txt"
    echo "建议: $suggestions" >> "$DATA_DIR/test-log-$date.txt"
    echo "---" >> "$DATA_DIR/test-log-$date.txt"
    
    echo "✅ 测试结果已记录"
}

# 3. 生成测试报告
generate_report() {
    local date=$(date +%Y-%m-%d)
    local log_file="$DATA_DIR/test-log-$date.txt"
    
    if [ ! -f "$log_file" ]; then
        echo "暂无测试数据"
        return
    fi
    
    echo ""
    echo "📊 测试报告 - $date"
    echo "========================================"
    
    # 统计基本信息
    local total_tests=$(grep -c "测试用户:" "$log_file" || echo 0)
    local success_tests=$(grep -c "成功: y" "$log_file" || echo 0)
    
    echo "总测试数: $total_tests"
    echo "成功数: $success_tests"
    
    if [ "$total_tests" -gt 0 ]; then
        local success_rate=$((success_tests * 100 / total_tests))
        echo "成功率: ${success_rate}%"
    fi
    
    # 显示问题汇总
    echo ""
    echo "🔧 问题汇总:"
    grep "问题:" "$log_file" | sed 's/问题: //' | sort | uniq -c | sort -rn
    
    # 显示建议汇总
    echo ""
    echo "💡 改进建议:"
    grep "建议:" "$log_file" | sed 's/建议: //' | sort | uniq -c | sort -rn
    
    echo ""
    echo "📈 今日测试完成"
}

# 4. 主菜单
main_menu() {
    echo ""
    echo "📋 测试数据管理"
    echo "1. 收集今日数据"
    echo "2. 添加测试结果"
    echo "3. 生成测试报告"
    echo "4. 查看所有数据"
    echo "5. 退出"
    echo ""
    read -p "请选择 (1-5): " choice
    
    case $choice in
        1)
            collect_today_data
            ;;
        2)
            add_test_result
            ;;
        3)
            generate_report
            ;;
        4)
            echo "📁 测试数据目录: $DATA_DIR"
            ls -la "$DATA_DIR/"
            ;;
        5)
            echo "退出测试数据收集"
            exit 0
            ;;
        *)
            echo "无效选择"
            ;;
    esac
    
    main_menu
}

# 启动
echo "🤖 测试数据收集系统"
echo "========================================"
main_menu