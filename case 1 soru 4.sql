--Haftanın günleri(pazartesi, perşembe, ….) 
--ve ay günleri (ayın 1’i,2’si gibi) bazında order sayılarını inceleyiniz. Yazdığınız sorgunun outputu ile excel’de bir görsel oluşturup yorumlayı




WITH tablo AS (
    SELECT
        TRIM(TO_CHAR(order_approved_at, 'DAY')) AS tarih_gün,
        LPAD(TO_CHAR(order_approved_at, 'Month'), 2, '0') AS tarih_ay, 
        order_id
    FROM
        orders
)

SELECT
    tarih_gün,
    tarih_ay,
    COUNT(o.order_id) AS order_sayısı
FROM
    orders AS o
JOIN
    tablo AS t ON o.order_id = t.order_id
WHERE
    t.tarih_gün IN ('MONDAY', 'THURSDAY')
    AND EXTRACT(DAY FROM order_approved_at) IN (1, 2) -- Ayın 1 ve 2 günleri
GROUP BY
    tarih_gün,
    tarih_ay
ORDER BY
    tarih_gün, tarih_ay;










