---Ürün kategorisi kırılımında sipariş sayılarını inceleyiniz. Özel günlerde öne çıkan kategoriler nelerdir? Örneğin yılbaşı, sevgililer günü…
with tablo as (
	select order_id,
	to_char (order_approved_at, 'mm-dd') AS tarih
	from orders
	)
	
select 
product_category_name,
tarih,
CASE WHEN t.tarih = '02-14' THEN 'sevgililer_günü' ELSE ' ' END as sevgililer_günü ,
CASE WHEN t.tarih = '01-01' THEN 'yılbaşı' ELSE ' ' END as yılbası,
CASE WHEN t.tarih = '10-29' THEN 'C.bayram' ELSE ' ' END as C_bayram,
count(o.order_id) as siparis_sayısı 
from order_items as o join products as p on o.product_id = p.product_id join orders as ord on ord.order_id=o.order_id join tablo as t on o.order_id= t.order_id
where t.tarih='02-14' or t.tarih='01-01' or t.tarih='10-29'
group by 1,2
order by tarih asc











	
	



