#!/bin/bash

RUNTIME_ENV=$(conda info | grep "active environment" | awk '{print $NF}')
PROJECT_PATH=$(pwd)/..
JOB_PATH=${PROJECT_PATH}/job

function TIME() {
    date "+%Y-%m-%d %H:%M:%S"
}

function INFO() {
    echo "\033[1;32m[INFO]\033[0m\033[32m $(TIME) $1\033[0m"
}

function WARN() {
    echo "\033[1;33m[WARN]\033[0m\033[33m $(TIME) $1\033[0m"
}

function ERROR() {
    echo "\033[1;31m[ERROR]\033[0m\033[31m $(TIME) $1\033[0m"
}

function RUN_JOB() {
    local JOB_NAME=$1
    local JOB_FILE=$2

    INFO "开始运行作业: ${JOB_NAME}..."
    python ${JOB_FILE}

    if [[ $? != 0 ]]; then
      ERROR "运行异常: ${JOB_NAME}"
    fi
}

RUN_JOB "当前时间作业" ${JOB_PATH}/execute_daily_job.py
RUN_JOB "综合选股作业" ${JOB_PATH}/selection_data_daily_job.py
RUN_JOB "基础数据实时作业" ${JOB_PATH}/basic_data_daily_job.py
RUN_JOB "基础数据收盘2小时后作业" ${JOB_PATH}/backtest_data_daily_job.py
RUN_JOB "基础数据非实时作业" ${JOB_PATH}/basic_data_other_daily_job.py
RUN_JOB "指标数据作业" ${JOB_PATH}/indicators_data_daily_job.py
RUN_JOB "K线形态作业" ${JOB_PATH}/klinepattern_data_daily_job.py
RUN_JOB "策略数据作业" ${JOB_PATH}/strategy_data_daily_job.py
RUN_JOB "回测数据" ${JOB_PATH}/backtest_data_daily_job.py



#o ------整体作业 支持批量作业------
#echo 当前时间作业 python execute_daily_job.py
#echo 1个时间作业 python execute_daily_job.py 2023-03-01
#echo N个时间作业 python execute_daily_job.py 2023-03-01,2023-03-02
#echo 区间作业 python execute_daily_job.py 2023-03-01 2023-03-21

