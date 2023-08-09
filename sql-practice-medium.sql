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

#3
Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

select patient_id,first_name 
from patients 
where first_name like 's%____s';

(or)

SELECT patient_id,first_name
FROM patients
WHERE first_name LIKE 's%s'
AND len(first_name) >= 6;

#4
Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table.

select patients.patient_id,first_name,last_name 
from admissions join patients 
on patients.patient_id=admissions.patient_id 
where diagnosis is 'Dementia';

(or)

SELECT  patient_id,  first_name,  last_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM admissions
    WHERE diagnosis = 'Dementia');
     
#5
Display every patient's first_name.
Order the list by the length of each name and then by alphbetically

select first_name 
from patients 
order by len(first_name),first_name;

#6
Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.

select
(select count(*) as male_count from patients where gender = 'M')as male_count,
(select count(*) as female_count from patients where gender = 'F')as female_count;

(or)

SELECT 
SUM(Gender = 'M') as male_count, 
SUM(Gender = 'F') AS female_count
FROM patients

#7
Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

select first_name,last_name,allergies 
from patients 
where allergies = 'Penicillin' or allergies = 'Morphine' 
order by 
allergies,first_name,last_name;

(or)

SELECT  first_name,  last_name,  allergies
FROM patients
WHERE  allergies IN ('Penicillin', 'Morphine')
ORDER BY  allergies,  first_name,  last_name;

#8
Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

select patient_id,diagnosis 
from admissions 
group by diagnosis,patient_id 
having count(*) > 1;

#9
Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.

select city,count(*) as num_patients 
from patients 
group by city
order by 
num_patients desc,city asc;

#10
Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"

select first_name,last_name,'Patient' as role from patients
union all
select first_name,last_name,'Doctor' as role from doctors

#11
Show all allergies ordered by popularity. Remove NULL values from query.

select allergies,count(*) as total_diagnosis 
from patients 
where allergies is not null 
group by allergies 
order by total_diagnosis desc;

#12
Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

select first_name,last_name,birth_date 
from patients 
where year(birth_date) 
between 1970 and 1979 
order by birth_date;

(or)

SELECT  first_name,  last_name,  birth_date
FROM patients
WHERE year(birth_date) LIKE '197%'
ORDER BY birth_date ASC;

#13
We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane

select concat(upper(last_name),',',lower(first_name)) as new_name_format 
from patients 
order by first_name desc;

#14
Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

select province_id,sum(height) as sum_height 
from patients 
group by province_id
having sum_height >=7000;

#15
Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

select (max(weight) - min(weight)) as weight_delta 
from patients 
where last_name like 'Maroni';

#16
Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

select day(admission_date) as day_number,count(*) as number_of_admissions 
from admissions 
group by day_number 
order by number_of_admissions desc;

#17
Show all columns for patient_id 542's most recent admission_date.

select * 
from admissions 
where patient_id=542 
order by admission_date desc limit 1;

(or)

SELECT *
FROM admissions
GROUP BY patient_id
HAVING  patient_id = 542
AND max(admission_date)
