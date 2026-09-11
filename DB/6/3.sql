-- 转出操作：付款卡为储蓄卡且属于付款人，余额减少
update bank_card set b_balance = b_balance-amount 
where b_number = source_card_id and b_c_id = applicant_id and b_type = "储蓄卡";

-- 转入操作：收款卡为储蓄卡且属于收款人，余额增加
update bank_card set b_balance = b_balance+amount 
where b_number = dest_card_id and b_c_id = receiver_id and b_type = "储蓄卡";

-- 转入操作：收款卡为信用卡且属于收款人，余额增加（允许透支）
update bank_card set b_balance = b_balance-amount 
where b_number = dest_card_id and b_c_id = receiver_id and b_type = "信用卡";

-- 验证转出是否合法：付款卡为储蓄卡且余额≥0（未超额）
if not exists(select * from bank_card where b_number = source_card_id and b_c_id = applicant_id and b_type = "储蓄卡" and b_balance >= 0) then
    set return_code = 0; -- 转账失败
    rollback; -- 回滚事务
-- 验证转入是否合法：收款卡存在且属于收款人
elseif not exists(select * from bank_card where b_number = dest_card_id and b_c_id = receiver_id) then
    set return_code = 0; -- 转账失败
    rollback; -- 回滚事务
else
    set return_code = 1; -- 转账成功
    commit; -- 提交事务
end if;