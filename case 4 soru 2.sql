--Ödeme tipine göre başarılı order sayısı ve toplam başarılı ödeme tutarını hesaplayınız. En çok kullanılan ödeme tipinden en az olana göre sıralayınız.



with card_type as (
select 
distinct(payment_type) as ödeme_tipi ,
count(o.order_id) as basarılı_order_sayısı,
to_char(sum(price), 'FM999999999999999.00') AS toplam_price
from orders as o join payments as p on o.order_id=p.order_id 
join order_items as ort on ort.order_id=o.order_id
where order_status ='delivered'
group by 1
)
select 
ödeme_tipi,
basarılı_order_sayısı,
toplam_price
from card_type
order by basarılı_order_sayısı  desc