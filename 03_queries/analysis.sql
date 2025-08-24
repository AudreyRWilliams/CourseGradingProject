.headers on
.mode column

-- A) Section averages (percent)
--   SUM(score) / SUM(points_possible) * 100
WITH section_totals AS (
  SELECT s.section_id, c.code AS course, t.name AS term,
         SUM(g.score) AS sum_score,
         SUM(a.points_possible) AS sum_possible
  FROM grades g
  JOIN assignments a ON g.assignment_id = a.assignment_id
  JOIN sections s    ON a.section_id = s.section_id
  JOIN courses c     ON s.course_id = c.course_id
  JOIN terms t       ON s.term_id   = t.term_id
  GROUP BY s.section_id, c.code, t.name
)
SELECT course, term,
       ROUND(100.0 * sum_score / sum_possible, 2) AS section_avg_pct
FROM section_totals
ORDER BY course, term;

-- B) Students at risk (avg across their sections < 70%)
--    Compute per-student percent across all their grades.
WITH student_totals AS (
  SELECT st.student_id, st.first_name || ' ' || st.last_name AS student,
         SUM(g.score) AS sum_score,
         SUM(a.points_possible) AS sum_possible
  FROM students st
  JOIN grades g      ON g.student_id = st.student_id
  JOIN assignments a ON a.assignment_id = g.assignment_id
  GROUP BY st.student_id, student
)
SELECT student,
       ROUND(100.0 * sum_score / sum_possible, 2) AS avg_pct
FROM student_totals
WHERE (100.0 * sum_score / sum_possible) < 70.0
ORDER BY avg_pct ASC;

-- C) Top 3 students per section (by percent) WITHOUT window functions
--    1) Compute per-student per-section totals
WITH per_section AS (
  SELECT s.section_id,
         c.code AS course,
         t.name AS term,
         st.student_id,
         st.first_name || ' ' || st.last_name AS student,
         SUM(g.score) AS sum_score,
         SUM(a.points_possible) AS sum_possible
  FROM grades g
  JOIN assignments a ON g.assignment_id = a.assignment_id
  JOIN sections s    ON a.section_id = s.section_id
  JOIN courses c     ON s.course_id = c.course_id
  JOIN terms t       ON s.term_id   = t.term_id
  JOIN students st   ON g.student_id = st.student_id
  GROUP BY s.section_id, c.code, t.name, st.student_id, student
),
with_pct AS (
  SELECT section_id, course, term, student_id, student,
         100.0 * sum_score / sum_possible AS pct
  FROM per_section
)
SELECT w1.course, w1.term, w1.student, ROUND(w1.pct,2) AS pct
FROM with_pct w1
WHERE (
  SELECT COUNT(*)
  FROM with_pct w2
  WHERE w2.section_id = w1.section_id
    AND (w2.pct > w1.pct
         OR (w2.pct = w1.pct AND w2.student_id < w1.student_id))
) < 3
ORDER BY w1.course, w1.term, w1.pct DESC;

-- D) Missing submissions:
--    For every (enrolled student, assignment) pair in a section,
--    show rows where no grade exists.
WITH roster AS (
  SELECT e.section_id, e.student_id
  FROM enrollments e
),
pairs AS (
  SELECT r.section_id, r.student_id, a.assignment_id, a.title
  FROM roster r
  JOIN assignments a ON a.section_id = r.section_id
)
SELECT c.code AS course, t.name AS term,
       st.first_name || ' ' || st.last_name AS student,
       a.title AS assignment_title
FROM pairs p
JOIN sections s  ON s.section_id = p.section_id
JOIN courses c   ON c.course_id = s.course_id
JOIN terms t     ON t.term_id   = s.term_id
JOIN students st ON st.student_id = p.student_id
JOIN assignments a ON a.assignment_id = p.assignment_id
LEFT JOIN grades g ON g.assignment_id = p.assignment_id AND g.student_id = p.student_id
WHERE g.grade_id IS NULL
ORDER BY course, term, student, assignment_title;
