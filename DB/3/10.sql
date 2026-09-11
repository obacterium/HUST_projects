-- 选择旅客编号、姓名、性别、出生日期，计算总票价并命名为expense
SELECT passenger.pid, pname, gender, dob, SUM(price) AS expense
-- 关联乘客表与乘车记录表（通过pid匹配）
FROM passenger, ride_record
WHERE passenger.pid = ride_record.pid
-- 按乘客编号分组，确保每个旅客的总支出独立计算
GROUP BY passenger.pid
-- 按总支出降序排列，确保最高花费在前
ORDER BY SUM(price) DESC
-- 仅取前3名结果
LIMIT 3;