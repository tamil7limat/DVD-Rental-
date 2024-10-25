CREATE TABLE all_table3 AS
SELECT 
    c.name AS filmcategory,                         -- Film category
    f.film_id,                                      -- Film ID
    f.title AS film_name,                           -- Film name
    f.release_year,                                 -- Release year
    f.language_id,                                  -- Language ID
    f.rental_duration,                              -- Rental duration
    f.rental_rate,                                  -- Rental rate
    f.length,                                       -- Film length
    f.rating,                                       -- Film rating
    STRING_AGG(DISTINCT a.first_name || ' ' || a.last_name, ', ') AS film_actor, -- Actors
    cu.customer_id ,                                 -- Customer ID
	p.amount AS payment                           -- Individual payment
FROM 
    film f
JOIN language l ON f.language_id = l.language_id           -- Join with language table
JOIN film_category fc ON f.film_id = fc.film_id            -- Join with film_category to get category
JOIN category c ON fc.category_id = c.category_id          -- Join with category table
JOIN film_actor fa ON f.film_id = fa.film_id               -- Join with film_actor to get actor IDs
JOIN actor a ON fa.actor_id = a.actor_id                   -- Join with actor table to get actor names
JOIN inventory i ON f.film_id = i.film_id                  -- Join with inventory to relate to rentals
JOIN rental r ON i.inventory_id = r.inventory_id           -- Join with rental to get rental data
JOIN customer cu ON r.customer_id = cu.customer_id         -- Join with customer to get customer ID
JOIN payment p ON r.rental_id = p.rental_id                -- Join with payment table to get individual payments
GROUP BY 
    c.name, f.film_id, f.title, f.release_year, f.language_id, 
    f.rental_duration, f.rental_rate, f.length, f.rating, cu.customer_id, 
    p.amount;


select *from all_table3