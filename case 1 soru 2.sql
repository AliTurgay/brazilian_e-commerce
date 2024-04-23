--Aylık olarak order status kırılımında order sayılarını inceleyiniz. Sorgu sonucunda çıkan outputu excel ile görselleştiriniz. 
SELECT to_char(date_trunc('month', order_approved_at), 'yyyy-mm') AS yıl_ay,
order_status,
COUNT(order_id) AS order_sayısı
FROM  orders
WHERE order_approved_at IS NOT NULL
GROUP BY 
to_char(date_trunc('month', order_approved_at), 'yyyy-mm'),
order_status
ORDER BY 
yıl_ay ASC,
order_status ASC;




