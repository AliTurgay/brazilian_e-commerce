

--(Recency) hesaplama
WITH recency_table AS (
SELECT 
customerid, 
MAX(invoicedate) AS recency 
FROM rfm2
GROUP BY 
customerid
),
-- Sıklık (Frequency) hesaplama
frequency_table AS (
SELECT 
customerid, 
COUNT(DISTINCT invoiceno) AS frequency
FROM rfm2
GROUP BY 
customerid
),
-- Parasal Değer (Monetary) hesaplama
monetary_table AS (
SELECT 
customerid, 
SUM(quantity::numeric * unitprice::numeric) AS monetary_value
FROM rfm2
GROUP BY 
customerid
)
-- Yukarıdaki RFM değerlerini birleştirerek segmentasyon
SELECT 
rt.customerid,
EXTRACT(DAY FROM recency) AS recency_days, -- Recency değerini günlere dönüştür
ft.frequency,
mt.monetary_value,
CASE 
WHEN EXTRACT(DAY FROM recency) >= 7 AND ft.frequency >= 5 AND mt.monetary_value >= 1000 THEN 'VIP'
WHEN EXTRACT(DAY FROM recency) >= 30 AND ft.frequency >= 2 AND mt.monetary_value >= 500 THEN 'Sadık'
WHEN EXTRACT(DAY FROM recency) >= 90 AND ft.frequency >= 1 AND mt.monetary_value >= 100 THEN 'Yeniden_Kazanılabilir'
ELSE 'Potansiyel'
   END AS segment
FROM recency_table AS rt 
JOIN frequency_table AS ft ON rt.customerid = ft.customerid
JOIN monetary_table AS mt ON mt.customerid = ft.customerid;
