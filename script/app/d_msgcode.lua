
---
--@module d_msgcode
local m = {
    --心跳信息
    client_heart_beat = 0,

    --注册
    h_signup = 10000,
    --登陆
    h_signin = 10001,
    --登出
    h_signout = 10002,
    --异地登陆
    w_remote_signin = 10003,

    --获取个人信息
    h_get_self_info = 10100,
    --货币变化
    w_money_chage = 10101,

    --进入时时彩
    h_ssc_enter = 10200,
    --离开时时彩
    h_ssc_leave = 10201,
    --时时彩下注
    h_ssc_bet = 10202,
    --时时彩撤销下注
    h_ssc_bet_cancel = 10203,
    --获取个人下注记录
    h_ssc_bet_record = 10204,
    --获取开奖历史记录
    h_ssc_reward_record = 10205,
    --获奖名单
    h_ssc_reward_list = 10206,
    --获取赔率
    h_ssc_get_odds = 10207,
    --获取最新一期开奖结果
    h_ssc_last_result = 10208,
    --推送最新一期开奖结果
    w_ssc_last_result = 10209,
}

return m
