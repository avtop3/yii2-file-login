SELECT 
name
FROM category
WHERE 
l <= (SELECT l FROM category WHERE id = 25) /*подставить значение l требуемой категории вместо скобок с запросом*/
AND 
r >= (SELECT r FROM category WHERE id = 25) /*подставить значение r требуемой категории вместо скобок с запросом*/
ORDER BY id ASC