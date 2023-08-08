#1
Show unique birth years from patients and order them by ascending.

select distinct year(birth_date) as birth_year
from patients 
order by birth_date;

#2
Show unique first names from the patients table which only occurs once in the list.

select first_name 
from patients 
group by first_name 
having count(first_name)=1;

(or)

select first_name 
from patients 
group by first_name 
having count(first_name) < 2;
