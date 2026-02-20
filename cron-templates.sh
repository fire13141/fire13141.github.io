#!/bin/bash
# 定时提醒模板脚本

# 1. 喝水提醒
water_reminder() {
    openclaw cron add \
        --name "喝水提醒" \
        --at "$1" \
        --session isolated \
        --message "💧 该喝水啦！保持水分充足很重要哦~" \
        --deliver \
        --channel qqbot \
        --to "62DF847C1D018ABA73CE6D740F3917D3" \
        --delete-after-run
}

# 2. 休息提醒
rest_reminder() {
    openclaw cron add \
        --name "休息提醒" \
        --at "$1" \
        --session isolated \
        --message "🛌 该休息一下啦！站起来活动活动，看看远方~" \
        --deliver \
        --channel qqbot \
        --to "62DF847C1D018ABA73CE6D740F3917D3" \
        --delete-after-run
}

# 3. 项目进度提醒
project_reminder() {
    openclaw cron add \
        --name "项目进度提醒" \
        --at "$1" \
        --session isolated \
        --message "📊 项目进度提醒：请检查当前任务完成情况~" \
        --deliver \
        --channel qqbot \
        --to "62DF847C1D018ABA73CE6D740F3917D3" \
        --delete-after-run
}

# 4. 自定义提醒
custom_reminder() {
    openclaw cron add \
        --name "$2" \
        --at "$1" \
        --session isolated \
        --message "$3" \
        --deliver \
        --channel qqbot \
        --to "62DF847C1D018ABA73CE6D740F3917D3" \
        --delete-after-run
}

echo "定时提醒模板已加载"
echo "可用函数："
echo "  water_reminder <时间>      # 喝水提醒"
echo "  rest_reminder <时间>       # 休息提醒"
echo "  project_reminder <时间>    # 项目进度提醒"
echo "  custom_reminder <时间> <名称> <消息> # 自定义提醒"
echo ""
echo "时间格式示例："
echo "  5m  # 5分钟后"
echo "  1h  # 1小时后"
echo "  2d  # 2天后"
echo "  2026-02-20T14:00:00+08:00  # 绝对时间"