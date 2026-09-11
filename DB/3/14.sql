-- 查询里程为第3高的车次全部信息
SELECT r1.train_no, r1.start, r1.dest, r1.depart, r1.arrival, r1.day, r1.mileage
FROM route r1
-- 匹配里程等于第3高的记录
WHERE r1.mileage = (
    -- 找出仅次于“第二高里程”的最高里程（即第3高）
    SELECT DISTINCT mileage
    FROM route
    WHERE mileage < (
        -- 找出仅次于“最高里程”的最高里程（即第2高）
        SELECT MAX(mileage)
        FROM route
        WHERE mileage < (
            -- 找出全局最高里程
            SELECT MAX(mileage)
            FROM route
        )
    )
    ORDER BY mileage DESC
    LIMIT 1  -- 确保只取一个基准值
)
ORDER BY r1.train_no;  -- 车次排序