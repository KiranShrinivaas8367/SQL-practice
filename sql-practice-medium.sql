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

