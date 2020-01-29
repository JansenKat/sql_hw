use sakila;

-- 1
select first_name, last_name 
from actor;

select concat(first_name, ' ',last_name) as 'Actor Name' 
from actor;

-- 2
select actor_id
from actor
where first_name = 'Joe';

select actor_id,first_name, last_name
from actor
where last_name like '%gen%';

select actor_id,first_name, last_name
from actor
where last_name like '%li%'
order by last_name, first_name;

select country_id,country
from country
where country in ('Afghanistan','Bangladesh','China');

-- 3
alter table actor 
	add (description blob);
    
alter table actor 
	drop description;

-- 4
select last_name, count(first_name) as count
from actor
group by last_name;

select last_name, count(first_name) as count
from actor
group by last_name
having count > 1;

update actor 
set first_name = 'HARPO'
where first_name = 'GROUCHO'
	and last_name = 'WILLIAMS';
    
update actor 
set first_name = 'GROUCHO'
where first_name = 'HARPO'
	and last_name = 'WILLIAMS';
    
-- 5
select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='address'

-- 6
select s.first_name, s.last_name, a.address
from staff s
join address a
using (address_id);

select s.first_name, s.last_name, sum(p.amount)
from staff s
join payment p
using (staff_id)
group by staff_id;

select f.title, sum(fa.actor_id) as actors
from film f
inner join film_actor fa
using (film_id)
group by film_id;

select f.title, count(*) as copies
from film f
join inventory using (film_id)
where f.title = 'Hunchback Impossible'
group by f.film_id;

select c.first_name, c.last_name, sum(p.amount)
from customer c
join payment p
using (customer_id)
group by customer_id
order by c.last_name;

-- 7
select title
from film
where title like 'K%' or title like 'Q%'
	and language_id in (
					select language_id 
					from language 
                    where `name` = 'ENGLISH'
                    );

select first_name, last_name
from actor
where actor_id in (
	select actor_id 
    from film
    where title = 'Alone Trip');

select cu.first_name, cu.last_name, cu.email
from customer cu
join address a using(address_id)
join city c using(city_id)
join country co using (country_id)
where co.country = 'CANADA';

select f.title
from film f
join film_category using(film_id)
join category c using(category_id)
where c.name = 'Family';

select f.title, count(r.rental_id) as rents
from film f
join inventory using(film_id)
join rental r using(inventory_id)
group by f.title
order by rents desc;

select s.store_id, sum(p.amount)
from store s
join inventory i using(store_id)
join rental r using(inventory_id)
join payment p using(rental_id)
group by s.store_id;

select s.store_id, c.city, co.country
from store s
join address a using(address_id)
join city c using(city_id)
join country co using(country_iD);

select c.name, sum(p.amount) as gross
from film f
join film_category fc using(film_id)
join category c using(category_id)
join inventory i using(film_id)
join rental r using(inventory_id)
join payment p using(rental_id)
group by category_id
order by gross desc
limit 5;

-- 8
create view top_five_genres as 
select c.name, sum(p.amount) as gross
from film f
join film_category fc using(film_id)
join category c using(category_id)
join inventory i using(film_id)
join rental r using(inventory_id)
join payment p using(rental_id)
group by category_id
order by gross desc
limit 5;

select * 
from top_five_genres;

drop view top_five_genres;