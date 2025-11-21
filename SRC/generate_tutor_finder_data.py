import random
from datetime import datetime, timedelta
from collections import defaultdict

# -----------------------------
# CONFIGURATION
# -----------------------------
NUM_TUTORS = 100
NUM_STUDENTS = 400
NUM_COURSES = 100
NUM_LOCATIONS = 20

TUTOR_COURSES_MIN = 3
TUTOR_COURSES_MAX = 7

STUDENT_COURSES_MIN = 3
STUDENT_COURSES_MAX = 6

TUTOR_AVAIL_PER_TUTOR = 8
STUDENT_AVAIL_PER_STUDENT = 5

NUM_AVAILABILITY_ROWS = 3000
NUM_BOOKINGS = 2000

OUTPUT_SQL_FILE = "tutor_finder_data.sql"

# -----------------------------
# HELPER FUNCTIONS
# -----------------------------

def random_postal_code():
    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    digits = "0123456789"
    return (
        random.choice(letters)
        + random.choice(digits)
        + random.choice(letters)
        + random.choice(digits)
        + random.choice(letters)
        + random.choice(digits)
    )

def random_name(prefix, idx):
    return f"{prefix} {idx}"

def random_email(prefix, idx):
    return f"{prefix.lower()}{idx}@example.com"

def random_course_code(idx):
    subjects = ["CSE", "MAT", "PHY", "BIO", "ECO", "HIS", "ENG", "SE", "CS"]
    return f"{random.choice(subjects)}{100 + (idx % 400)}"

def random_datetime_in_range():
    # Random datetime in early 2025, 8am–8pm
    start_date = datetime(2025, 1, 1)
    days_offset = random.randint(0, 60)
    base = start_date + timedelta(days=days_offset)
    hour = random.randint(8, 19)    # last start time 7pm
    minute = random.choice([0, 15, 30, 45])
    return base.replace(hour=hour, minute=minute, second=0, microsecond=0)

def sql_datetime(dt):
    return dt.strftime("%Y-%m-%d %H:%M:%S")

def sql_string(s):
    return "'" + s.replace("'", "''") + "'"

def write_insert_many(f, table, columns, rows):
    if not rows:
        return
    f.write(f"INSERT INTO {table} ({', '.join(columns)}) VALUES\n")
    lines = []
    for r in rows:
        vals = []
        for col in columns:
            v = r[col]
            if v is None:
                vals.append("NULL")
            elif isinstance(v, str):
                vals.append(sql_string(v))
            elif isinstance(v, datetime):
                vals.append(sql_string(sql_datetime(v)))
            else:
                vals.append(str(v))
        lines.append("  (" + ", ".join(vals) + ")")
    f.write(",\n".join(lines))
    f.write(";\n\n")

# -----------------------------
# DATA CONTAINERS
# -----------------------------

tutors = []
students = []
courses = []
locations = []

tutor_courses = []
student_courses = []

tutor_availabilities = []
student_availabilities = []
availabilities = []

bookings = []
reviews = []
payments = []

# -----------------------------
# GENERATE BASE TABLES
# -----------------------------

# Locations
for loc_id in range(1, NUM_LOCATIONS + 1):
    locations.append({
        "location_id": loc_id,
        "postal_code": random_postal_code()
    })

# Tutors
for tid in range(1, NUM_TUTORS + 1):
    tutors.append({
        "tutor_id": tid,
        "full_name": random_name("Tutor", tid),
        "email": random_email("tutor", tid),
        "location_postal": random_postal_code()
        # ranking_score is calculated via view, not inserted here
    })

# Students
for sid in range(1, NUM_STUDENTS + 1):
    students.append({
        "student_id": sid,
        "full_name": random_name("Student", sid),
        "email": random_email("student", sid),
        "location_postal": random_postal_code()
    })

# Courses
for cid in range(1, NUM_COURSES + 1):
    courses.append({
        "course_id": cid,
        "course_code": random_course_code(cid),
        "title": f"Course Title {cid}"
    })

# -----------------------------
# RELATION TABLES
# -----------------------------

# tutor_course
tutor_courses_by_tutor = defaultdict(set)

for t in tutors:
    tutor_id = t["tutor_id"]
    num_tc = random.randint(TUTOR_COURSES_MIN, TUTOR_COURSES_MAX)
    course_ids = random.sample(range(1, NUM_COURSES + 1), num_tc)

    for cid in course_ids:
        hourly_rate = random.randint(20, 80)  # $20–$80/hr
        tutor_courses.append({
            "tutor_id": tutor_id,
            "course_id": cid,
            "experience_years": round(random.uniform(0.5, 15.0), 1),
            "hourly_rate": hourly_rate
        })
        tutor_courses_by_tutor[tutor_id].add(cid)

# student_courses
student_courses_by_student = defaultdict(set)
student_course_grade = {}   # (student_id, course_id) -> grade

for s in students:
    student_id = s["student_id"]
    num_sc = random.randint(STUDENT_COURSES_MIN, STUDENT_COURSES_MAX)
    course_ids = random.sample(range(1, NUM_COURSES + 1), num_sc)

    for cid in course_ids:
        grade = random.randint(50, 100)  # numeric grade out of 100
        student_courses.append({
            "student_id": student_id,
            "course_id": cid,
            "grade": grade
        })
        student_courses_by_student[student_id].add(cid)
        student_course_grade[(student_id, cid)] = grade

# -----------------------------
# AVAILABILITY TABLES
# -----------------------------

# Tutor availability: 3–5 hour windows
tutor_avail_id = 0
for t in tutors:
    tutor_id = t["tutor_id"]
    for _ in range(TUTOR_AVAIL_PER_TUTOR):
        tutor_avail_id += 1
        start = random_datetime_in_range()
        duration_hours = random.choice([3, 3.5, 4, 4.5, 5])
        end = start + timedelta(hours=duration_hours)
        tutor_availabilities.append({
            "tutor_availability_id": tutor_avail_id,
            "tutor_id": tutor_id,
            "start_time": start,
            "end_time": end
        })

# Student availability: 3–5 hour windows
student_avail_id = 0
for s in students:
    student_id = s["student_id"]
    for _ in range(STUDENT_AVAIL_PER_STUDENT):
        student_avail_id += 1
        start = random_datetime_in_range()
        duration_hours = random.choice([3, 3.5, 4, 4.5, 5])
        end = start + timedelta(hours=duration_hours)
        student_availabilities.append({
            "student_availability_id": student_avail_id,
            "student_id": student_id,
            "start_time": start,
            "end_time": end
        })

# availability: 1-hour overlapping slots
availability_id = 0
max_attempts = NUM_AVAILABILITY_ROWS * 5
attempts = 0

while len(availabilities) < NUM_AVAILABILITY_ROWS and attempts < max_attempts:
    attempts += 1
    ta = random.choice(tutor_availabilities)
    sa = random.choice(student_availabilities)

    overlap_start = max(ta["start_time"], sa["start_time"])
    overlap_end = min(ta["end_time"], sa["end_time"])

    if overlap_end - overlap_start < timedelta(hours=1):
        continue  # not enough overlap

    # choose random 1-hour slot inside overlap
    latest_start = overlap_end - timedelta(hours=1)
    if latest_start <= overlap_start:
        slot_start = overlap_start
    else:
        total_seconds = int((latest_start - overlap_start).total_seconds())
        offset_seconds = random.randint(0, total_seconds)
        slot_start = overlap_start + timedelta(seconds=offset_seconds)

    slot_end = slot_start + timedelta(hours=1)

    availability_id += 1
    availabilities.append({
        "availability_id": availability_id,
        "tutor_availability_id": ta["tutor_availability_id"],
        "student_availability_id": sa["student_availability_id"],
        "start_time": slot_start,
        "end_time": slot_end
    })

# Lookups for booking generation
tutor_avail_lookup = {ta["tutor_availability_id"]: ta for ta in tutor_availabilities}
student_avail_lookup = {sa["student_availability_id"]: sa for sa in student_availabilities}

# -----------------------------
# BOOKINGS, REVIEWS, PAYMENTS
# -----------------------------

booking_id = 0
review_id = 0
payment_id = 0

location_ids = [loc["location_id"] for loc in locations]

# shuffle availabilities so we don't always use the same
shuffled_avails = availabilities[:]
random.shuffle(shuffled_avails)

for avail in shuffled_avails:
    if booking_id >= NUM_BOOKINGS:
        break

    ta = tutor_avail_lookup[avail["tutor_availability_id"]]
    sa = student_avail_lookup[avail["student_availability_id"]]

    tutor_id = ta["tutor_id"]
    student_id = sa["student_id"]

    # courses this tutor teaches
    tutor_courses_set = tutor_courses_by_tutor.get(tutor_id, set())
    # courses this student is enrolled in
    student_courses_set = student_courses_by_student.get(student_id, set())

    common_courses = tutor_courses_set & student_courses_set

    # NO FALLBACK: skip if they don't share a course
    if not common_courses:
        continue

    course_id = random.choice(list(common_courses))
    location_id = random.choice(location_ids)

    booking_id += 1

    bookings.append({
        "booking_id": booking_id,
        "tutor_id": tutor_id,
        "student_id": student_id,
        "course_id": course_id,
        "location_id": location_id,
        "availability_id": avail["availability_id"]
        # price_dollars is set by SQL trigger
    })

    # ----- Review -----
    review_id += 1
    rating = random.randint(1, 5)
    helpful = rating >= 4
    engaged = random.choice([True, False])

    # grade_before from the student's course grade for that course
    grade_before = student_course_grade.get((student_id, course_id), random.randint(50, 90))

    # grade_after: up to 10% worse, 20% better, capped at 100
    max_drop = int(grade_before * 0.10)
    max_boost = int(grade_before * 0.20)
    delta = random.randint(-max_drop, max_boost)
    grade_after = grade_before + delta
    if grade_after > 100:
        grade_after = 100
    if grade_after < 0:
        grade_after = 0

    reviews.append({
        "review_id": review_id,
        "booking_id": booking_id,
        "rating": rating,
        "grade_before": grade_before,
        "grade_after": grade_after,
        "student_feedback": f"{rating}, {helpful}",
        "tutor_feedback": f"{engaged}"
        # total_hours and grade_change set by trigger
    })

    # ----- Payment -----
    payment_id += 1
    method = random.choice(["Credit Card", "Debit", "Cash", "E-Transfer", "PayPal"])
    status = random.choices(
        ["COMPLETED", "PENDING", "FAILED", "REFUNDED"],
        weights=[0.8, 0.1, 0.05, 0.05],
        k=1
    )[0]

    payments.append({
        "payment_id": payment_id,
        "booking_id": booking_id,
        "method": method,
        "status": status
    })

# -----------------------------
# WRITE SQL FILE
# -----------------------------

with open(OUTPUT_SQL_FILE, "w", encoding="utf-8") as f:
    f.write("-- Data for tutor_finder\n")
    f.write("USE tutor_finder;\n\n")

    # Core tables
    write_insert_many(
        f, "tutor",
        ["tutor_id", "full_name", "email", "location_postal"],
        tutors
    )

    write_insert_many(
        f, "student",
        ["student_id", "full_name", "email", "location_postal"],
        students
    )

    write_insert_many(
        f, "course",
        ["course_id", "course_code", "title"],
        courses
    )

    write_insert_many(
        f, "location",
        ["location_id", "postal_code"],
        locations
    )

    # Relations
    write_insert_many(
        f, "tutor_course",
        ["tutor_id", "course_id", "experience_years", "hourly_rate_dollars"],
        [
            {
                "tutor_id": tc["tutor_id"],
                "course_id": tc["course_id"],
                "experience_years": tc["experience_years"],
                "hourly_rate_dollars": tc["hourly_rate"],
            }
            for tc in tutor_courses
        ]
    )

    write_insert_many(
        f, "student_courses",
        ["student_id", "course_id", "grade"],
        student_courses
    )

    # Availability tables
    write_insert_many(
        f, "tutor_availability",
        ["tutor_availability_id", "tutor_id", "start_time", "end_time"],
        tutor_availabilities
    )

    write_insert_many(
        f, "student_availability",
        ["student_availability_id", "student_id", "start_time", "end_time"],
        student_availabilities
    )

    write_insert_many(
        f, "availability",
        ["availability_id", "tutor_availability_id", "student_availability_id", "start_time", "end_time"],
        availabilities
    )

    # Bookings (price_dollars handled by trigger)
    write_insert_many(
        f, "booking",
        ["booking_id", "tutor_id", "student_id", "course_id", "location_id", "availability_id"],
        bookings
    )

    # Reviews (total_hours & grade_change handled by trigger)
    write_insert_many(
        f, "review",
        ["review_id", "booking_id", "rating",
         "grade_before", "grade_after",
         "student_feedback", "tutor_feedback"],
        reviews
    )

    # Payments
    write_insert_many(
        f, "payment",
        ["payment_id", "booking_id", "method", "status"],
        payments
    )

print(f"Done. Wrote SQL data file: {OUTPUT_SQL_FILE}")
