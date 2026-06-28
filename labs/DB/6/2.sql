delimiter $$
-- 创建夜班排班存储过程，输入起始和结束日期
create procedure sp_night_shift_arrange(in start_date date, in end_date date)
begin
declare done, waitdir int default false; -- done标记游标结束，waitdir标记主任待安排
declare nowdate date; -- 当前排班日期
declare waitdr, dr, nr1, nr2 char(30); -- 等待安排的主任、当前医生、护士1、护士2
declare drtype int; -- 医生类型（1=主任，2=普通医生）
-- 医生游标：筛选医生（e_type<3）
declare drlist cursor for select e_name, e_type from employee where e_type < 3;
-- 护士游标：筛选护士（e_type=3）
declare nrlist cursor for select e_name from employee where e_type = 3;
declare continue handler for not found set done = true; -- 游标无数据时设置done=true

open drlist; -- 打开医生游标
open nrlist; -- 打开护士游标
set nowdate = start_date; -- 初始化当前日期为起始日
while nowdate <= end_date do -- 循环排班日期
    if weekday(nowdate) < 5 and waitdir then -- 非周末且有待安排的主任
        set dr = waitdr, waitdir = false; -- 安排主任值班
    else
        fetch drlist into dr, drtype; -- 取下一个医生
        if done then -- 医生游标到末尾，重置游标
            close drlist;
            open drlist;
            fetch drlist into dr, drtype;
            set done = false;
        end if;
        if weekday(nowdate) >= 5 and drtype = 1 then -- 周末且当前是主任
            set waitdir = true, waitdr = dr; -- 主任留待周一安排
            fetch drlist into dr, drtype; -- 取下一个医生递补周末
            if done then -- 再次重置医生游标
                close drlist;
                open drlist;
                fetch drlist into dr, drtype;
                set done = false;
            end if;
        end if;
    end if;

    fetch nrlist into nr1; -- 取第一个护士
    if done then -- 护士游标到末尾，重置
        close nrlist;
        open nrlist;
        fetch nrlist into nr1;
        set done = false;
    end if;

    fetch nrlist into nr2; -- 取第二个护士
    if done then -- 护士游标到末尾，重置
        close nrlist;
        open nrlist;
        fetch nrlist into nr2;
        set done = false;
    end if;
    insert into night_shift_schedule values (nowdate, dr, nr1, nr2); -- 写入排班表
    set nowdate = date_add(nowdate, interval 1 day); -- 日期加一天
end while;
end
$$
delimiter ;