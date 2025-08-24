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


