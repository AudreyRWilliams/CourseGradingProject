# Course Enrollment & Grading (SQLite)

This project creates a small student/course database with constraints, triggers, views, CTEs, and practical analytics:

- Tables created: students, courses, terms, sections, enrollments, assignments, grades
- Triggers: validate grade ranges vs. assignment max points
- Queries:
     - Course/section averages
     - Students “at risk” (avg < 70%)
     - Top 3 students per section (without window functions)
     - Missing submissions

The script builds school.db and prints results for the queries. 

## What it shows
- Relational modeling with constraints
- Triggers for business rules
- Views/CTEs and multi-join analytics
- “Top N per group” without window functions
- Missing-submission detection

## How to run
-  use a bash Terminal
-  chmod +x run.sh
-  ./run.sh

## 1) Create the project structure
<img width="612" height="220" alt="Screen Shot 2025-08-25 at 8 05 12 PM" src="https://github.com/user-attachments/assets/6b807008-116c-44ad-bc4c-d9a7cc5ea096" /> <br>

## 2) Schema (tables + constraints)
01_schema/create_tables.sql

## 3) Triggers (business rules)
01_schema/triggers.sql

## 4) Sample data
02_data/insert_data.sql

## 5) Indexes (performance)
04_perf/indexes.sql

## 6) Analysis queries (intermediate, no window functions)
03_queries/analysis.sql
