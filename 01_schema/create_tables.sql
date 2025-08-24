PRAGMA foreign_keys = ON;

CREATE TABLE students (
  student_id   INTEGER PRIMARY KEY,
  first_name   TEXT NOT NULL,
  last_name    TEXT NOT NULL,
  start_year   INTEGER CHECK (start_year BETWEEN 1990 AND 2100)
);

CREATE TABLE courses (
  course_id  INTEGER PRIMARY KEY,
  code       TEXT NOT NULL UNIQUE,   -- e.g., CS101
  title      TEXT NOT NULL
);

CREATE TABLE terms (
  term_id     INTEGER PRIMARY KEY,
  name        TEXT NOT NULL,         -- e.g., 2025-Summer
  start_date  DATE NOT NULL,
  end_date    DATE NOT NULL,
  CHECK (start_date <= end_date)
);

CREATE TABLE sections (
  section_id    INTEGER PRIMARY KEY,
  course_id     INTEGER NOT NULL REFERENCES courses(course_id),
  term_id       INTEGER NOT NULL REFERENCES terms(term_id),
  section_code  TEXT NOT NULL,       -- e.g., A, B
  max_capacity  INTEGER NOT NULL CHECK (max_capacity > 0),
  UNIQUE (course_id, term_id, section_code)
);

CREATE TABLE enrollments (
  enrollment_id INTEGER PRIMARY KEY,
  student_id    INTEGER NOT NULL REFERENCES students(student_id),
  section_id    INTEGER NOT NULL REFERENCES sections(section_id),
  enrolled_on   DATE NOT NULL,
  UNIQUE (student_id, section_id)
);

CREATE TABLE assignments (
  assignment_id   INTEGER PRIMARY KEY,
  section_id      INTEGER NOT NULL REFERENCES sections(section_id),
  title           TEXT NOT NULL,
  due_date        DATE NOT NULL,
  points_possible INTEGER NOT NULL CHECK (points_possible > 0)
);

CREATE TABLE grades (
  grade_id      INTEGER PRIMARY KEY,
  assignment_id INTEGER NOT NULL REFERENCES assignments(assignment_id),
  student_id    INTEGER NOT NULL REFERENCES students(student_id),
  score         REAL NOT NULL CHECK (score >= 0),
  UNIQUE (assignment_id, student_id)
);
