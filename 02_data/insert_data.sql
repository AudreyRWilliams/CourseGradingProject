-- Students
INSERT INTO students VALUES
 (1,'Alice','Smith',2024),
 (2,'Bob','Johnson',2024),
 (3,'Cathy','Lee',2025),
 (4,'Diego','Martinez',2025);

-- Courses
INSERT INTO courses VALUES
 (1,'CS101','Intro to Computer Science'),
 (2,'MATH201','Discrete Mathematics');

-- Terms
INSERT INTO terms VALUES
 (1,'2025-Summer','2025-06-01','2025-08-15'),
 (2,'2025-Fall','2025-09-01','2025-12-15');

-- Sections
INSERT INTO sections VALUES
 (1,1,1,'A',30),  -- CS101, Summer, Section A
 (2,1,2,'A',30),  -- CS101, Fall, Section A
 (3,2,1,'A',25);  -- MATH201, Summer, Section A

-- Enrollments
INSERT INTO enrollments VALUES
 (1,1,1,'2025-06-02'),
 (2,2,1,'2025-06-02'),
 (3,3,1,'2025-06-03'),
 (4,1,3,'2025-06-02'),
 (5,4,3,'2025-06-05');

-- Assignments (points_possible)
INSERT INTO assignments VALUES
 (1,1,'HW1','2025-06-10',100),
 (2,1,'HW2','2025-06-20',100),
 (3,1,'Project','2025-07-10',200),

 (4,3,'HW1','2025-06-12',100),
 (5,3,'Midterm','2025-07-01',150);

-- Grades (scores)
-- CS101 Summer Section A (section_id=1)
INSERT INTO grades VALUES
 (1,1,1,90),   -- Alice HW1
 (2,1,2,70),   -- Bob   HW1
 (3,1,3,95),   -- Cathy HW1

 (4,2,1,88),   -- Alice HW2
 (5,2,2,78),   -- Bob   HW2
 (6,2,3,92),   -- Cathy HW2

 (7,3,1,180),  -- Alice Project (out of 200)
 (8,3,2,150),  -- Bob   Project
 (9,3,3,190);  -- Cathy Project

-- MATH201 Summer Section A (section_id=3)
INSERT INTO grades VALUES
 (10,4,1,85),    -- Alice HW1
 (11,4,4,90),    -- Diego HW1
 (12,5,1,120),   -- Alice Midterm (out of 150)
 (13,5,4,135);   -- Diego Midterm
