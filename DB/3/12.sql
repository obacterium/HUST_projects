SELECT 
  -- 根据车次首字母判断列车类别并命名
  CASE LEFT(train_no, 1)
    WHEN 'G' THEN '高速动车组旅客列车'
    WHEN 'D' THEN '动车组旅客列车'
    WHEN 'C' THEN '城际动车组旅客列车'
    WHEN 'Z' THEN '直达特快旅客列车'
    WHEN 'T' THEN '特快旅客列车'
    WHEN 'K' THEN '快速旅客列车'
    ELSE '其他旅客列车'
  END AS 列车类别,
  -- 统计每类列车的数量
  COUNT(*) AS 车次数
FROM route
-- 按列车类别分组统计
GROUP BY 列车类别
-- 按类别名称排序输出
ORDER BY 列车类别;