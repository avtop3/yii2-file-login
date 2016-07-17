select 
category.name , COUNT(1) as item_in_category
from 
item INNER  JOIN `category-item` ON item.id = `category-item`.item_id 
INNER JOIN category ON `category-item`.category_id = category.id
GROUP BY category.id
HAVING category.id IN(22,21,14,31,17)