SELECT * FROM SALES_DATASET_RFM_PRJ;
-- 1.Chuyển đổi kiểu dữ liệu phù hợp cho các trường (sử dụng câu lệnh ALTER) 
ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN ordernumber TYPE integer USING(trim(ordernumber) :: integer);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN quantityordered TYPE smallint USING(trim(quantityordered) :: smallint);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN priceeach TYPE numeric USING(trim(priceeach) :: numeric);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN orderlinenumber TYPE smallint USING(trim(orderlinenumber) :: smallint);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN sales TYPE numeric USING(trim(sales) :: numeric);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN orderdate TYPE timestamp with time zone USING orderdate :: timestamp with time zone;

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN status TYPE varchar(15) USING(trim(status) :: varchar(15));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN productline TYPE varchar(20) USING(productline :: varchar(20));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN msrp TYPE smallint USING(trim(msrp) :: smallint);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN productcode TYPE varchar(15) USING(productcode :: varchar(15));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN customername TYPE text USING(customername :: text);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN phone TYPE varchar(20) USING(phone :: varchar(20)); 

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN addressline1 TYPE text USING(addressline1 :: text);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN addressline2 TYPE text USING(addressline2 :: text);

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN city TYPE varchar(20) USING(city :: varchar(20));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN state TYPE varchar(20) USING(state :: varchar(20));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN postalcode TYPE varchar(15) USING(postalcode :: varchar(15));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN country TYPE varchar(15) USING(country :: varchar(15));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN territory TYPE varchar(10) USING(territory :: varchar(10));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN contactfullname TYPE varchar(25) USING(contactfullname :: varchar(25));

ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN dealsize TYPE varchar(10) USING(dealsize :: varchar(15));

-- 2. Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
SELECT * 
FROM SALES_DATASET_RFM_PRJ
WHERE ordernumber IS NULL 
OR quantityordered IS NULL
OR priceeach IS NULL 
OR orderlinenumber IS NULL 
OR sales IS NULL
OR orderdate IS NULL 
 -- -> None

-- 3.Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
-- Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 
-- Gợi ý: ( ADD column sau đó INSERT)
ALTER TABLE SALES_DATASET_RFM_PRJ
ADD COLUMN CONTACTFIRSTNAME text,
ADD COLUMN CONTACTLASTNAME text;

UPDATE SALES_DATASET_RFM_PRJ 
SET 
	CONTACTFIRSTNAME = UPPER(LEFT(contactfullname, 1)) || LOWER(SUBSTRING(contactfullname FROM 2 FOR POSITION('-' IN contactfullname) - 2)),
	CONTACTLASTNAME = UPPER(SUBSTRING(contactfullname FROM POSITION('-' IN contactfullname) + 1 FOR 1)) || LOWER(RIGHT(contactfullname, LENGTH(contactfullname) -  POSITION('-' IN contactfullname) - 1));	

-- 4. Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Quý, tháng, năm được lấy ra từ ORDERDATE 
ALTER TABLE SALES_DATASET_RFM_PRJ
ADD COLUMN QTR_ID smallint,
ADD COLUMN MONTH_ID smallint,
ADD COLUMN YEAR_ID smallint;

UPDATE SALES_DATASET_RFM_PRJ
SET
	QTR_ID = EXTRACT(quarter FROM ORDERDATE),
	MONTH_ID = EXTRACT(month FROM orderdate),
	YEAR_ID = EXTRACT(year FROM orderdate);

SELECT * FROM SALES_DATASET_RFM_PRJ;

-- 5. Tìm outlier (nếu có) cho cột QUANTITYORDERED và xử lý outlier cho bản ghi đó (2 cách)

-- C1: IQR = Q3 - Q1, min = Q1 - 1.5*IQR, max = Q3 + 1.5*IQR, outlier > max or < min
-- Q1 = 27, Q3 = 43, IQR = 16, min = 3, max = 67
CREATE TEMP TABLE cte1 AS(
	SELECT 
		Q1 - 1.5*IQR AS min,
		Q3 + 1.5*IQR AS max
	FROM(
		SELECT
			percentile_cont(0.25) WITHIN GROUP(ORDER BY quantityordered) AS Q1,
			percentile_cont(0.75) WITHIN GROUP(ORDER BY quantityordered) AS Q3,
			percentile_cont(0.75) WITHIN GROUP(ORDER BY quantityordered) - percentile_cont(0.25) WITHIN GROUP(ORDER BY quantityordered) AS IQR
		FROM SALES_DATASET_RFM_PRJ
	)
);
-- các outlier c1
SELECT * FROM SALES_DATASET_RFM_PRJ
WHERE quantityordered > (SELECT max FROM cte1) OR quantityordered < (SELECT min FROM cte1)

-- C2: z-score = (quantity - AVG(quantity))/stddev, outlier when |z| > 3 and consider outlier when |z| > 2
CREATE TEMP TABLE cte2 AS (
	SELECT *
	FROM SALES_DATASET_RFM_PRJ
	WHERE ABS((quantityordered - (SELECT AVG(quantityordered) FROM SALES_DATASET_RFM_PRJ))*1.0 / (SELECT stddev(quantityordered) FROM SALES_DATASET_RFM_PRJ)) > 2
);

----Xử lí outlier 
-- C1: Xoá outlier khỏi database
DELETE FROM SALES_DATASET_RFM_PRJ
WHERE quantityordered IN (SELECT quantityordered FROM cte2);

-- C2: Thay thế outlier với GT trung bình
UPDATE SALES_DATASET_RFM_PRJ
SET quantityordered = (SELECT AVG(quantityordered) FROM SALES_DATASET_RFM_PRJ)
WHERE quantityordered IN (SELECT quantityordered FROM cte2);


--6. Sau khi làm sạch dữ liệu, lưu vào bảng mới: SALES_DATASET_RFM_PRJ_CLEAN
CREATE TABLE SALES_DATASET_RFM_PRJ_CLEAN AS(
	SELECT * 
	FROM SALES_DATASET_RFM_PRJ
	WHERE 
		ORDERNUMBER IS NOT NULL AND
		QUANTITYORDERED IS NOT NULL AND
		PRICEEACH IS NOT NULL AND
		ORDERLINENUMBER IS NOT NULL AND
		SALES IS NOT NULL AND
		ORDERDATE IS NOT NULL
)

-- Phân tích:

-- 1) Doanh thu theo từng ProductLine, Year và DealSize
SELECT productline, year_id, dealsize,
SUM(sales) AS revenue
FROM SALES_DATASET_RFM_PRJ_CLEAN
WHERE status = 'Shipped'
GROUP BY productline, year_id, dealsize;


-- 2) Đâu là tháng có bán tốt nhất mỗi năm?
SELECT month_id, year_id,
SUM(sales) AS revenue,
COUNT(ordernumber) AS order_number
FROM SALES_DATASET_RFM_PRJ_CLEAN
WHERE status = 'Shipped'
GROUP BY month_id, year_id
ORDER BY year_id, revenue DESC, order_number DESC
--> Các tháng bán tốt nhất: Tháng 11 năm 2003, Tháng 11 năm 2004, Tháng 2 năm 2005


-- 3) Product line nào được bán nhiều ở tháng 11?
SELECT month_id, productline,
SUM(sales) AS revenue,
COUNT(ordernumber) AS order_number
FROM SALES_DATASET_RFM_PRJ_CLEAN
WHERE month_id = 11 AND status = 'Shipped'
GROUP BY month_id, productline
ORDER BY order_number DESC
--> Product line: Classic Cars bán nhiều ở T11


-- 4) Đâu là sản phẩm có doanh thu tốt nhất ở UK mỗi năm? Xếp hạng các các doanh thu đó theo từng năm.
SELECT *, 
RANK() OVER(PARTITION BY year_id ORDER BY revenue DESC) AS rank
FROM(
	SELECT year_id, productline,
	SUM(sales) AS revenue
	FROM SALES_DATASET_RFM_PRJ_CLEAN
	WHERE status = 'Shipped' AND country = 'UK'
	GROUP BY year_id, productline
)
--> Sản phẩm có doanh thu tốt nhất theo năm ở UK là: Classic Cars (năm 2023), Vintage Cars (năm 2024), Motorcycle (năm 2025)


-- 5) Ai là khách hàng tốt nhất, phân tích dựa vào RFM 
WITH customer_rfm AS (
	SELECT customername,
	current_date - MAX(orderdate) AS R,
	COUNT(DISTINCT ordernumber) AS F,
	SUM(sales) AS M
	FROM SALES_DATASET_RFM_PRJ_CLEAN
	WHERE status = 'Shipped'
	GROUP BY customername
)
, rfm_score AS (
	SELECT customername,
	ntile(5) OVER (ORDER BY R DESC) AS r_score,
	ntile(5) OVER (ORDER BY F) AS f_score,
	ntile(5) OVER (ORDER BY M) AS m_score
	FROM customer_rfm
)
, rfm_final AS (
	SELECT customername, 
	CAST(r_score AS varchar) || CAST(f_score AS varchar) || CAST(m_score AS varchar) AS rfm_score
	FROM rfm_score
)
, customer_retention AS (
SELECT b.customername, a.segment
FROM segment_score AS a
JOIN rfm_final AS b ON a.scores = b.rfm_score
ORDER BY segment
)
-- Các khách hàng tốt nhất
SELECT * 
FROM customer_retention
WHERE segment = 'Champions'









