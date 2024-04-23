---Aylık olarak order dağılımını inceleyiniz. Tarih verisi için order_approved_at kullanılmalıdır.
SELECT TO_CHAR(date_trunc('month', order_approved_at), 'YYYY-MM') AS yil_ay,
COUNT(order_id) AS siparis_sayısı
FROM orders  
WHERE order_approved_at IS NOT NULL
GROUP BY TO_CHAR(date_trunc('month', order_approved_at), 'YYYY-MM')
ORDER BY 1 ASC;























