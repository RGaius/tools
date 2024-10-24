#!/bin/bash

# 定义查看日志的函数
view_log() {
    local product=$1
    local level=$2
    local lines=${3:-10}  # 默认显示最后 10 行
    local log_file="/data/logs/$product/$product.$level.log"

    if [ ! -f "$log_file" ]; then
        echo "Error: Log file not found at $log_file"
        return 1
    fi

    if [ "$lines" -eq 0 ]; then
        tail -f "$log_file"
    elif [ "$lines" -gt 0 ]; then
        tail -n "$lines" -f "$log_file"
    else
        head -n "${lines#-}" "$log_file"
    fi
}

# 检查参数数量
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 <product> <level> [lines]"
    echo "Example:"
    echo "  $0 productA info"
    echo "  $0 productA info 20"
    echo "  $0 productA info -20"
    exit 1
fi

# 调用函数
view_log "$1" "$2" "$3"
