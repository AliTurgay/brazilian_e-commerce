--Hangi satıcılar daha fazla kategoriye ait ürün satışı yapmaktadır? 
--Fazla kategoriye sahip satıcıların order sayıları da fazla mı? 

with SellerCategoryCounts as(
select 
s.seller_id,
count(order_id) as order_count,
count(distinct product_category_name) as category_count
from sellers as s join order_items as ort on s.seller_id=ort.seller_id
join products as p on ort.product_id = p.product_id
group by 1
)

select 
seller_id,
category_count,
order_count
from SellerCategoryCounts 
order by category_count desc ,  order_count desc
