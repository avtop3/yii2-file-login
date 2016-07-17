SELECT 
category.name
FROM 
item
INNER JOIN `category-item` ON item.id = `category-item`.item_id
INNER JOIN category ON `category-item`.category_id = category.id
WHERE item.id IN(8,4,10,21)