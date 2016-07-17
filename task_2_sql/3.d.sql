select 
count(DISTINCT item.title) as uniqe_items
from 
item INNER  JOIN `category-item` ON item.id = `category-item`.item_id 
INNER JOIN category ON `category-item`.category_id = category.id
where category.id IN(22,21,14,31,17)