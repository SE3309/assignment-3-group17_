USE tutor_finder;

--
-- PART 7 – CREATE TWO VIEWS
--

-- Clean drop for reruns
DROP VIEW IF EXISTS tutor_ratings_overall;
DROP VIEW IF EXISTS tutor_course_ratings;

-------------------------------------------------------
-- VIEW 1: Overall tutor rating across all bookings
-------------------------------------------------------
CREATE VIEW tutor_ratings_overall AS
SELECT
    t.tutor_id,
    t.full_name,
    t.email,
    t.location_postal,
    AVG(r.rating) AS ranking_score
FROM tutor t
LEFT JOIN booking b ON b.tutor_id = t.tutor_id
LEFT JOIN review  r ON r.booking_id = b.booking_id
GROUP BY
    t.tutor_id,
    t.full_name,
    t.email,
    t.location_postal;

-------------------------------------------------------
-- VIEW 2: Tutor-course pair rating
-------------------------------------------------------
CREATE VIEW tutor_course_ratings AS
SELECT
    tc.tutor_id,
    tc.course_id,
    tc.experience_years,
    tc.hourly_rate_dollars,
    AVG(r.rating) AS rating_avg
FROM tutor_course tc
LEFT JOIN booking b ON b.tutor_id = tc.tutor_id
LEFT JOIN review  r ON r.booking_id = b.booking_id
GROUP BY
    tc.tutor_id,
    tc.course_id,
    tc.experience_years,
    tc.hourly_rate_dollars;

-------------------------------------------------------
-- QUERIES USING BOTH VIEWS
-------------------------------------------------------

-- Query using View 1
SELECT *
FROM tutor_ratings_overall
LIMIT 3;

-- Query using View 2
SELECT *
FROM tutor_course_ratings
LIMIT 3;

-------------------------------------------------------
-- TEST: ATTEMPT TO MODIFY VIEW
-------------------------------------------------------

INSERT INTO tutor_ratings_overall (
    tutor_id,
    full_name,
    email,
    location_postal,
    ranking_score
)
VALUES (999, 'Fake Tutor', 'fake@example.com', 'Z9Z 9Z9', 5.0);

INSERT INTO tutor_course_ratings (
    tutor_id,
    course_id,
    experience_years,
    hourly_rate_dollars,
    rating_avg
)
VALUES (999, 999, 10, 100.00, 5.0);

