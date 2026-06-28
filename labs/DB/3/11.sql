-- 统计国庆期间出行人数（去重）和出行次数（不去重）
SELECT COUNT(DISTINCT pid) AS 人, COUNT(*) AS 次
FROM ride_record
-- 筛选2023年国庆小长假日期范围（含首尾两天）
WHERE rdate >= '2023-09-29' AND rdate <= '2023-10-06';