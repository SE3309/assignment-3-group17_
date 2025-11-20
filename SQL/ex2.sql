-- =========================================================
-- Drop & Create Database
-- =========================================================
DROP DATABASE IF EXISTS tutor_finder;
CREATE DATABASE tutor_finder
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE tutor_finder;


-- =========================================================
-- Core Entities
-- =========================================================

CREATE TABLE tutor (
  tutor_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name       VARCHAR(100) NOT NULL,
  email           VARCHAR(255) NOT NULL,
  location_postal VARCHAR(16),
  ranking_score   DECIMAL(4,2),           -- will be calculated via view in practice
  UNIQUE KEY uq_tutor_email (email)
);

CREATE TABLE student (
  student_id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name       VARCHAR(100) NOT NULL,
  email           VARCHAR(255) NOT NULL,
  location_postal VARCHAR(16),
  UNIQUE KEY uq_student_email (email)
);

CREATE TABLE course (
  course_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  course_code VARCHAR(32)  NOT NULL,
  title       VARCHAR(255) NOT NULL
);

-- ensure each course_code is unique
ALTER TABLE course
  ADD CONSTRAINT uq_course_code UNIQUE (course_code);

CREATE TABLE location (
  location_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  postal_code VARCHAR(16)
);

-- =========================================================
-- Relations
-- =========================================================

CREATE TABLE tutor_course (
  tutor_id             INT UNSIGNED NOT NULL,
  course_id            INT UNSIGNED NOT NULL,
  experience_years     DECIMAL(3,1),
  hourly_rate_dollars  DECIMAL(6,2) NOT NULL,  -- changed to DECIMAL for nicer pricing
  rating_avg           DECIMAL(3,2),           -- will be calculated via view in practice
  PRIMARY KEY (tutor_id, course_id),
  CONSTRAINT fk_tutor_course_tutor
    FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_tutor_course_course
    FOREIGN KEY (course_id) REFERENCES course(course_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx_tutor_course_tutor  ON tutor_course(tutor_id);
CREATE INDEX idx_tutor_course_course ON tutor_course(course_id);

CREATE TABLE student_courses (
  student_id   INT UNSIGNED NOT NULL,
  course_id    INT UNSIGNED NOT NULL,
  grade        INT,
  PRIMARY KEY (student_id, course_id),
  CONSTRAINT fk_student_courses_student
    FOREIGN KEY (student_id) REFERENCES student(student_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_student_courses_course
    FOREIGN KEY (course_id) REFERENCES course(course_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx_student_courses_student ON student_courses(student_id);
CREATE INDEX idx_student_courses_course  ON student_courses(course_id);

-- =========================================================
-- Availability
-- =========================================================

CREATE TABLE tutor_availability (
  tutor_availability_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tutor_id              INT UNSIGNED NOT NULL,
  start_time            DATETIME NOT NULL,
  end_time              DATETIME NOT NULL,
  CONSTRAINT fk_tutor_availability_tutor
    FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx_tutor_availability_tutor
  ON tutor_availability(tutor_id, start_time, end_time);

CREATE TABLE student_availability (
  student_availability_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id              INT UNSIGNED NOT NULL,
  start_time              DATETIME NOT NULL,
  end_time                DATETIME NOT NULL,
  CONSTRAINT fk_student_availability_student
    FOREIGN KEY (student_id) REFERENCES student(student_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx_student_availability_student
  ON student_availability(student_id, start_time, end_time);

CREATE TABLE availability (
  availability_id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tutor_availability_id   INT UNSIGNED NOT NULL,
  student_availability_id INT UNSIGNED NOT NULL,
  start_time              DATETIME NOT NULL,
  end_time                DATETIME NOT NULL,
  CONSTRAINT fk_availability_tutor_availability
    FOREIGN KEY (tutor_availability_id)
      REFERENCES tutor_availability(tutor_availability_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_availability_student_availability
    FOREIGN KEY (student_availability_id)
      REFERENCES student_availability(student_availability_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx_availability_tutor
  ON availability(tutor_availability_id);

CREATE INDEX idx_availability_student
  ON availability(student_availability_id);

-- =========================================================
-- Bookings, Reviews, Payments
-- =========================================================

CREATE TABLE booking (
  booking_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tutor_id          INT UNSIGNED NOT NULL,
  student_id        INT UNSIGNED NOT NULL,
  course_id         INT UNSIGNED NOT NULL,  
  location_id       INT UNSIGNED NOT NULL,
  availability_id   INT UNSIGNED,
  price_dollars     DECIMAL(8,2) NOT NULL,
  CONSTRAINT fk_booking_tutor
    FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_student
    FOREIGN KEY (student_id) REFERENCES student(student_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_course                    
    FOREIGN KEY (course_id) REFERENCES course(course_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_location
    FOREIGN KEY (location_id) REFERENCES location(location_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_availability
    FOREIGN KEY (availability_id) REFERENCES availability(availability_id)
      ON UPDATE CASCADE ON DELETE SET NULL,
  INDEX idx_booking_tutor (tutor_id),
  INDEX idx_booking_student (student_id),
  INDEX idx_booking_availability (availability_id)
);


CREATE TABLE review (
  review_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  booking_id       INT UNSIGNED NOT NULL,
  rating           INT NOT NULL,
  grade_before     INT,
  grade_after      INT,
  total_hours      DECIMAL(4,2),
  grade_change     DECIMAL(5,2),
  student_feedback TEXT,
  tutor_feedback   TEXT,

  CONSTRAINT fk_review_booking
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE payment (
  payment_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  booking_id   INT UNSIGNED NOT NULL,
  method       VARCHAR(30) NOT NULL,
  status       VARCHAR(20) NOT NULL,
  CONSTRAINT fk_payment_booking
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_payment_booking (booking_id)
);

-- =========================================================
-- TRIGGERS
-- =========================================================

DELIMITER $$

-- ---------------------------------------------------------
-- Trigger: calculate booking.price_dollars BEFORE INSERT
-- ---------------------------------------------------------
CREATE TRIGGER trg_booking_set_price
BEFORE INSERT ON booking
FOR EACH ROW
BEGIN
  DECLARE v_duration_hours DECIMAL(5,2);
  DECLARE v_hourly_rate DECIMAL(6,2);

  -- duration in hours, based on availability
  SELECT
    TIMESTAMPDIFF(MINUTE, a.start_time, a.end_time) / 60.0
  INTO v_duration_hours
  FROM availability a
  WHERE a.availability_id = NEW.availability_id;

  -- pick any hourly rate for this tutor
  SELECT tc.hourly_rate_dollars
  INTO v_hourly_rate
  FROM tutor_course tc
  WHERE tc.tutor_id = NEW.tutor_id
  LIMIT 1;

  IF v_duration_hours IS NULL THEN
    SET v_duration_hours = 1.0;
  END IF;

  IF v_hourly_rate IS NULL THEN
    SET v_hourly_rate = 40.00; -- fallback
  END IF;

  SET NEW.price_dollars = ROUND(v_duration_hours * v_hourly_rate, 2);
END$$

-- ---------------------------------------------------------
-- Trigger: calculate review.total_hours & grade_change
-- ---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_review_set_hours_and_grade;
DELIMITER $$

CREATE TRIGGER trg_review_set_hours_and_grade
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
  DECLARE v_start DATETIME;
  DECLARE v_end   DATETIME;
  DECLARE v_duration_hours DECIMAL(5,2);

  -- 1) Get the booking slot from availability via booking
  SELECT a.start_time, a.end_time
  INTO v_start, v_end
  FROM booking b
  JOIN availability a ON a.availability_id = b.availability_id
  WHERE b.booking_id = NEW.booking_id;

  -- 2) Compute duration in hours
  IF v_start IS NULL OR v_end IS NULL THEN
    SET v_duration_hours = 1.0;
  ELSE
    SET v_duration_hours =
      TIMESTAMPDIFF(MINUTE, v_start, v_end) / 60.0;
  END IF;

  SET NEW.total_hours = ROUND(v_duration_hours, 2);

  -- 3) grade_change = grade_after - grade_before
  IF NEW.grade_before IS NOT NULL AND NEW.grade_after IS NOT NULL THEN
    SET NEW.grade_change = NEW.grade_after - NEW.grade_before;
  ELSE
    SET NEW.grade_change = NULL;
  END IF;
END$$

DELIMITER ;


-- =========================================================
-- VIEWS FOR RATINGS
-- =========================================================

-- Overall tutor rating, based on all reviews per tutor
CREATE OR REPLACE VIEW tutor_ratings_overall AS
SELECT
  t.tutor_id,
  t.full_name,
  t.email,
  t.location_postal,
  AVG(r.rating) AS ranking_score
FROM tutor t
LEFT JOIN booking b ON b.tutor_id = t.tutor_id
LEFT JOIN review r  ON r.booking_id = b.booking_id
GROUP BY
  t.tutor_id,
  t.full_name,
  t.email,
  t.location_postal;


-- Per tutor-course rating (here: average tutor rating repeated per course)
CREATE OR REPLACE VIEW tutor_course_ratings AS
SELECT
  tc.tutor_id,
  tc.course_id,
  tc.experience_years,
  tc.hourly_rate_dollars,
  AVG(r.rating) AS rating_avg
FROM tutor_course tc
LEFT JOIN booking b ON b.tutor_id = tc.tutor_id
LEFT JOIN review r  ON r.booking_id = b.booking_id
GROUP BY
  tc.tutor_id,
  tc.course_id,
  tc.experience_years,
  tc.hourly_rate_dollars;
  


