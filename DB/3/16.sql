-- 子查询1：查找从武汉出发的车次及其可中转的站点与到达时间
SELECT 
    t1.train_no,
    t1.station_name AS start_station,
    t1.departure_time AS depart_time,
    t2.station_name AS transfer_station,
    t2.arrival_time AS arrival_time,
    t2.stop_seq AS transfer_stop_seq
FROM timetable t1
INNER JOIN station s_start ON t1.station_name = s_start.sname
INNER JOIN timetable t2 ON t1.train_no = t2.train_no
WHERE s_start.city = '武汉'              -- 限定出发城市为武汉
    AND t1.stop_seq < t2.stop_seq        -- 确保中转站在出发站之后
    AND t1.departure_time IS NOT NULL     -- 排除终到站（无离站时间）
    AND t2.arrival_time IS NOT NULL;      -- 排除始发站（无到站时间）

-- 子查询2：查找前往大理的车次及其对应的中转站与出发时间
SELECT 
    t3.train_no,
    t3.station_name AS transfer_station,
    t3.departure_time AS depart_time,
    t4.station_name AS dest_station,
    t4.arrival_time AS arrival_time,
    t3.stop_seq AS transfer_stop_seq
FROM timetable t3
INNER JOIN timetable t4 ON t3.train_no = t4.train_no
WHERE t4.station_name = '大理'           -- 限定目的地为大理工
    AND t3.stop_seq < t4.stop_seq        -- 确保中转站在目的站之前
    AND t3.departure_time IS NOT NULL     -- 排除终到站
    AND t4.arrival_time IS NOT NULL;      -- 排除始发站


   