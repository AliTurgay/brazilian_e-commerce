--Tek çekimde ve taksitle ödenen siparişlerin kategori bazlı analizini yapınız. En çok hangi kategorıde taksıtlı odenmıstır ödeme kullanılmaktadır?
select 
pr.product_category_name,
case 
when p.payment_installments = 1 then 'tekçekim'
else 'taksit' end as ödeme_tipi,
count(ort.order_id) as toplam_sipariş_sayısı,
sum(payment_installments) as toplam_taksit_sayısı
from payments as p join order_items as ort on p.order_id=ort.order_id
join products as pr on pr.product_id=ort.product_id
where (case when payment_installments = 1 then 'tekçekim'
else 'taksit' end) ='taksit'
group by 1,2
order by 3 desc



