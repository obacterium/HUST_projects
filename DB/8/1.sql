delimiter $$
-- 创建函数get_deposit，计算客户储蓄卡总余额
create function get_deposit(client_id int)
returns numeric(10,2) 
begin
    declare tot_dep int; -- 声明变量存储总余额
    -- 查询指定客户的储蓄卡余额总和
    select SUM(b_balance) into tot_dep
    from bank_card
    where b_c_id = client_id and b_type = '储蓄卡';
    return tot_dep; -- 返回总余额
end
$$
delimiter ;

/* 应用函数查询存款总额≥100万的客户信息 */
select c_id_card, c_name, get_deposit(c_id) as total_deposit  
from client
where get_deposit(c_id) >= 1000000 -- 筛选存款达标客户
order by total_deposit desc; -- 按存款总额降序排序