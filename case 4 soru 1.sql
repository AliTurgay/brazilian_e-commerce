--Ödeme yaparken taksit sayısı fazla olan kullanıcılar en çok hangi bölgede yaşamaktadır? Bu çıktıyı yorumlayınız.

with taksit_sayilari as (
select 
c.customer_unique_id,
c.customer_state,
count(payment_installments) as taksit_sayısı 
from payments as p join orders as o on o.order_id=p.order_id
join customers as c on c.customer_id= o.customer_id
group by 1,2
)


select
customer_state,
max(taksit_sayısı ) as max_taksit_sayısı
from taksit_sayilari
group by 1
order by max_taksit_sayısı desc


