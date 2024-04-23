with tablo1 as (
select 
order_approved_at as onay_verilme_tarihi,
order_delivered_customer_date as ulaşma_tarihi,
order_id,
(order_delivered_customer_date - order_approved_at) as fark_tarihi
from orders as o join customers as c on c.customer_id = o.customer_id
where o.order_status = 'delivered' and order_delivered_customer_date > order_approved_at
),

satici_siparis_sayisi as (
select 
s.seller_id,
count(ort.order_id) as sip_sayısı
from sellers as s join order_items as ort on s.seller_id = ort.seller_id 
join tablo1 as t1 on t1.order_id = ort.order_id
group by s.seller_id
having count(ort.order_id) >= 10
),

ortalama_teslimat_suresi as (
select 
s.seller_id,
avg(t1.fark_tarihi) as ortalama_teslimat_suresi
from sellers as s join order_items as ort on s.seller_id = ort.seller_id 
join tablo1 as t1 on t1.order_id = ort.order_id
where s.seller_id in (select seller_id from satici_siparis_sayisi)
group by s.seller_id
)

select 
    sss.seller_id,
    ots.ortalama_teslimat_suresi,
    sss.sip_sayısı
from satici_siparis_sayisi as sss join ortalama_teslimat_suresi as ots on sss.seller_id = ots.seller_id
order by ots.ortalama_teslimat_suresi asc



