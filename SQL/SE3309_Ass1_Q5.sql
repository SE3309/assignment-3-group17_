-- USE tutor_finder
-- query 1
-- SELECT *
-- FROM student
-- WHERE Student_id = 67

-- query 2

-- SELECT 
-- t.tutor_id,
-- full_name,
-- email,
-- start_time,
-- end_time
-- FROM tutor AS t
-- join tutor_availability AS ta
-- WHERE t.tutor_id IN (10,100,600) AND ta.start_time like '2025-02-16 13%'

-- query 3
/*
SELECT *
FROM student
WHERE student_id REGEXP '^35[0-7]$' 
ORDER BY location_postal DESC

*/

-- query 4

/*
SELECT *
FROM booking
WHERE EXISTS (
    SELECT booking_id
    FROM booking b2
    WHERE b2.tutor_id = 8
);
*/

-- query 5
/*
SELECT tutor_id,
student_id,
availability_id,
price_dollars,
price_dollars * 1.05 AS price_with_tax 

FROM booking
WHERE tutor_id > student_id 
*/

-- query 6
/*
SELECT tutor_id,
student_id,
availability_id,
price_dollars

FROM booking
WHERE (tutor_id <= student_id && price_dollars < 50)
ORDER BY price_dollars

*/

-- querry 7
/*
SELECT 
    p.payment_id,
    t.tutor_id,
    t.full_name,
    b.price_dollars,
    p.method,
    p.status
FROM payment AS p
JOIN booking AS b
    ON p.booking_id = b.booking_id      
JOIN tutor AS t
    ON b.tutor_id = t.tutor_id          
WHERE b.price_dollars = 77 

*/       
-- querry 8
SELECT 
b.booking_id,
t.full_name AS tutor_name,
t.email AS tutor_email,
s.full_name AS student_name,
s.email AS student_email
FROM booking b
JOIN tutor t
	on b.tutor_id = t.tutor_id
JOIN student s
	on b.student_id = s.student_id
WHERE t.tutor_id BETWEEN 10 AND 30






 