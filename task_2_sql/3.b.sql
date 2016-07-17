SELECT 
item.title, category.name
FROM 
item
INNER JOIN `category-item` ON item.id = `category-item`.item_id
INNER JOIN category ON `category-item`.category_id = category.id
WHERE category.id IN(
	SELECT 
	id
	FROM category
	WHERE 
	l >= (SELECT l FROM category WHERE id = 22) 
	AND 
	r <= (SELECT r FROM category WHERE id = 22)
)