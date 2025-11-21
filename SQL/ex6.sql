USE tutor_finder;

-- 1) INSERT: force inserting 1 new review
INSERT INTO review (booking_id, rating, grade_before, grade_after, student_feedback, tutor_feedback)
SELECT 
    b.booking_id,
    5,
    70,
    85,
    'Task 6 forced insert – system generated review',
    NULL
FROM booking AS b
ORDER BY b.booking_id DESC
LIMIT 2;

-- 2) UPDATE: same as before (15 rows affected)
UPDATE tutor_course AS tc
JOIN tutor_course_ratings AS tcr
  ON tc.tutor_id = tcr.tutor_id
 AND tc.course_id = tcr.course_id
SET tc.hourly_rate_dollars = ROUND(tc.hourly_rate_dollars * 1.10, 2)
WHERE tcr.rating_avg >= 4.5;


-- 3) DELETE: delete a small subset of bookings
DELETE FROM booking
ORDER BY booking_id
LIMIT 5;
