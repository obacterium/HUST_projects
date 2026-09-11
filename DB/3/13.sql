-- 选择车站名称和所在城市
SELECT s.sname, s.city
FROM station s
-- 连接时刻表获取车站经停车次
JOIN timetable t ON s.sname = t.station_name
-- 连接行政区表筛选福建省（拼接“市”匹配全称）
JOIN district d ON CONCAT(s.city, '市') = d.city
WHERE d.prov = '福建省'  -- 限定省份为福建省
GROUP BY s.sname         -- 按车站分组
HAVING COUNT(DISTINCT t.train_no) = 1  -- 仅保留仅一趟列车经停的车站
ORDER BY s.sid;          -- 按车站编号排序