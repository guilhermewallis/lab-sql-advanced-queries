	-- 1.
with cte_faa as(
	select actor_id, film_id, first_name, last_name from film_actor fa
	join actor a using(actor_id)
)
select distinct faa1.actor_id actor_id_1, concat(faa1.first_name, ' ', faa1.last_name) actor_name_1,
faa2.actor_id actor_id_2, concat(faa2.first_name, ' ', faa2.last_name) actor_name_2 from cte_faa faa1
join cte_faa faa2 using(film_id)
where faa1.film_id = faa2.film_id and faa1.actor_id < faa2.actor_id
order by faa1.actor_id;

	-- 2.
with actor_films_acted as(
	select actor_id, count(*) films_acted from film_actor
	group by actor_id
),
film_films_acted as(
	select film_id, max(films_acted) max_films_acted from film_actor
	join actor_films_acted using(actor_id)
	group by film_id
)
select film_id, actor_id, concat(a.first_name, ' ', a.last_name) actor_name, films_acted from film_actor
join actor_films_acted using(actor_id)
join film_films_acted using(film_id)
join actor a using(actor_id)
where films_acted = max_films_acted
order by film_id;


