
-- Assignment 3 - Task 3  (Group 17 example)
-- Three different INSERT styles for the `course` relation
-- Database: tutor_finder


USE tutor_finder;

INSERT INTO course (course_code, title)
VALUES ('SE3309', 'Database Management Systems');


INSERT INTO course (course_code, title)
VALUES 
  ('CS1026',  'Introduction to Computer Science'),
  ('MATH1600','Linear Algebra I');

.
INSERT INTO course (course_code, title)
SELECT 
  CONCAT(course_code, '_LAB')       AS course_code,
  CONCAT(title, ' - Lab Section')   AS title
FROM course
WHERE course_code IN ('SE3309', 'CS1026');


SELECT * FROM course;
