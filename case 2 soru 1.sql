
with tablo1 as (
select 
customer_unique_id,
seller_city,
count(o.order_id) as siparis_sayısı
from customers as c join orders as o on c.customer_id=o.customer_id 
join order_items as ort on o.order_id=ort.order_id
join sellers as s on ort.seller_id= s.seller_id
group by 1,2
) ,
tablo2 as (
select 
customer_unique_id,
seller_city,
siparis_sayısı,
row_number() over (partition by customer_unique_id order by siparis_sayısı desc ) as rn
from tablo1 
) ,
tablo3 as (
select 
customer_unique_id,
sum(siparis_sayısı) as toplam_siparis_sayısı
from tablo2
group by 1
)
select 
t2.customer_unique_id,
seller_city,
toplam_siparis_sayısı
from tablo2 as t2 join tablo3 as t3 on t2.customer_unique_id=t3.customer_unique_id
where rn=1