-- OHOUSE TEST

select *
from product_image;

SELECT
    og.option_group_id,
    og.group_name,
    og.required,
    ov.option_value_id,
    ov.option_name
FROM option_group og
JOIN option_value ov
    ON og.option_group_id = ov.option_group_id
WHERE og.product_id = 3898584
ORDER BY og.sort_order, ov.sort_order;

SELECT
    po.product_option_id,
    po.product_id,
    po.sku,
    po.price,
    po.stock,
    po.status,
    pov.option_value_id
FROM product_option po
JOIN product_option_value pov
    ON po.product_option_id = pov.product_option_id
WHERE po.product_id = 3898584
ORDER BY po.product_option_id, pov.option_value_id;

SELECT
    a.table_name,
    a.constraint_name,
    a.r_constraint_name
FROM user_constraints a
WHERE a.constraint_type = 'R'
AND a.r_constraint_name IN (
    SELECT constraint_name
    FROM user_constraints
    WHERE table_name = 'MEMBER'
);