-- 查询满足条件的旅客基本信息
SELECT p.pid, p.card_no, p.pname, p.gender, p.dob
FROM passenger p
-- 核心逻辑：不存在27号旅客坐过而当前旅客没坐过的车次
WHERE NOT EXISTS (
    -- 27号旅客乘坐过的所有车次
    SELECT r1.train_no
    FROM ride_record r1
    WHERE r1.pid = 27
      -- 排除当前旅客也坐过该车次的情况
      AND r1.train_no NOT IN (
          -- 当前旅客乘坐过的车次
          SELECT r2.train_no
          FROM ride_record r2
          WHERE r2.pid = p.pid
      )
)
-- 按旅客编号排序
ORDER BY p.pid;