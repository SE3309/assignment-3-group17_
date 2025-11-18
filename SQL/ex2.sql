DROP DATABASE IF EXISTS tutor_finder;
CREATE DATABASE tutor_finder
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE tutor_finder;

-- Core Entities

CREATE TABLE tutor (
  tutor_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name       VARCHAR(100) NOT NULL,
  email           VARCHAR(255) NOT NULL,
  location_postal VARCHAR(16),
  ranking_score   DECIMAL(4,2),
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

CREATE TABLE location (
  location_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  postal_code VARCHAR(16)
);

-- Relations

CREATE TABLE tutor_course (
  tutor_id           INT UNSIGNED NOT NULL,
  course_id          INT UNSIGNED NOT NULL,
  experience_years   DECIMAL(3,1),
  hourly_rate_dollars  INT UNSIGNED NOT NULL,
  rating_avg         DECIMAL(3,2),
  PRIMARY KEY (tutor_id, course_id),
  CONSTRAINT fk_tutor_course_tutor
    FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_tutor_course_course
    FOREIGN KEY (course_id) REFERENCES course(course_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE student_courses (
  student_id   INT UNSIGNED NOT NULL,
  course_id    INT UNSIGNED NOT NULL,
  grade        VARCHAR(5),
  PRIMARY KEY (student_id, course_id),
  CONSTRAINT fk_student_courses_student
    FOREIGN KEY (student_id) REFERENCES student(student_id)
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_student_courses_course
    FOREIGN KEY (course_id) REFERENCES course(course_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

-- Availability

CREATE TABLE tutor_availability (
  tutor_availability_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tutor_id              INT UNSIGNED NOT NULL,
  start_time            DATETIME NOT NULL,
  end_time              DATETIME NOT NULL,
  CONSTRAINT fk_tutor_availability_tutor
    FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE student_availability (
  student_availability_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id              INT UNSIGNED NOT NULL,
  start_time              DATETIME NOT NULL,
  end_time                DATETIME NOT NULL,
  CONSTRAINT fk_student_availability_student
    FOREIGN KEY (student_id) REFERENCES student(student_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

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

-- Bookings, Reviews, Payments

CREATE TABLE booking (
  booking_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tutor_id          INT UNSIGNED NOT NULL,
  student_id        INT UNSIGNED NOT NULL,
  location_id       INT UNSIGNED NOT NULL,
  availability_id   INT UNSIGNED,
  price_dollars       INT UNSIGNED NOT NULL,
  CONSTRAINT fk_booking_tutor
    FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_student
    FOREIGN KEY (student_id) REFERENCES student(student_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_location
    FOREIGN KEY (location_id) REFERENCES location(location_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_booking_availability
    FOREIGN KEY (availability_id) REFERENCES availability(availability_id)
      ON UPDATE CASCADE ON DELETE SET NULL,
  INDEX idx_booking_tutor (tutor_id),
  INDEX idx_booking_student (student_id)
);

CREATE TABLE review (
  review_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  booking_id       INT UNSIGNED NOT NULL,
  rating           INT NOT NULL,
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