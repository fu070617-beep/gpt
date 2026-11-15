-- SELECT 单表查询实验
-- 数据库：MySQL 5.7.18
-- 示例数据表：sales（商品销售记录）
-- 说明：本脚本包含建库建表、样例数据和三类单表查询。

CREATE DATABASE IF NOT EXISTS db_select_lab
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;
USE db_select_lab;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '记录编号',
  product_name VARCHAR(50) NOT NULL COMMENT '商品名称',
  category VARCHAR(30) NOT NULL COMMENT '商品类别',
  quantity INT NOT NULL COMMENT '销售数量',
  unit_price DECIMAL(10,2) NOT NULL COMMENT '商品单价',
  sale_date DATE NOT NULL COMMENT '销售日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO sales (product_name, category, quantity, unit_price, sale_date) VALUES
('笔记本电脑', '数码', 2, 4999.00, '2026-10-01'),
('无线鼠标', '数码', 10, 89.00, '2026-10-02'),
('机械键盘', '数码', 5, 299.00, '2026-10-03'),
('保温杯', '生活用品', 8, 59.00, '2026-10-04'),
('背包', '生活用品', 3, 199.00, '2026-10-05'),
('台灯', '家居', 6, 129.00, '2026-10-06'),
('显示器', '数码', 4, 1099.00, '2026-10-07'),
('水杯', '生活用品', 12, 29.00, '2026-10-08'),
('书架', '家居', 2, 399.00, '2026-10-09'),
('耳机', '数码', 7, 259.00, '2026-10-10');

-- 题目一：基本查询与条件查询
-- 1. 查询所有销售记录
SELECT * FROM sales;
-- 2. 查询商品名称、类别和单价
SELECT product_name, category, unit_price FROM sales;
-- 3. 查询类别为“数码”的商品
SELECT * FROM sales WHERE category = '数码';
-- 4. 查询单价大于等于 200 元的商品
SELECT product_name, unit_price
FROM sales
WHERE unit_price >= 200;

-- 题目二：排序与 LIMIT
-- 1. 按销售数量从高到低排序
SELECT product_name, quantity
FROM sales
ORDER BY quantity DESC;
-- 2. 按单价从低到高排序
SELECT product_name, unit_price
FROM sales
ORDER BY unit_price ASC;
-- 3. 查询单价最高的 3 种商品
SELECT product_name, unit_price
FROM sales
ORDER BY unit_price DESC
LIMIT 3;

-- 题目三：聚合函数、GROUP BY 与 HAVING
-- 1. 统计销售记录总数
SELECT COUNT(*) AS total_records FROM sales;
-- 2. 统计销售总数量
SELECT SUM(quantity) AS total_quantity FROM sales;
-- 3. 计算平均商品单价
SELECT AVG(unit_price) AS average_price FROM sales;
-- 4. 按商品类别统计商品种类数和销售总数量
SELECT category,
       COUNT(*) AS product_count,
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY category;
-- 5. 查询销售总数量大于 10 的商品类别
SELECT category, SUM(quantity) AS total_quantity
FROM sales
GROUP BY category
HAVING SUM(quantity) > 10;

-- 实验核对：样例数据应为 10 条，销售总数量应为 59。
SELECT
  CASE WHEN COUNT(*) = 10 THEN 'PASS' ELSE 'FAIL' END AS record_count_check,
  CASE WHEN SUM(quantity) = 59 THEN 'PASS' ELSE 'FAIL' END AS quantity_sum_check
FROM sales;
