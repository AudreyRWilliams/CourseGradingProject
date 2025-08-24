-- Ensure a grade's score does not exceed the assignment's points_possible
CREATE TRIGGER trg_score_not_over_max
BEFORE INSERT ON grades
FOR EACH ROW
WHEN NEW.score > (SELECT points_possible FROM assignments WHERE assignment_id = NEW.assignment_id)
BEGIN
  SELECT RAISE(ABORT, 'Score exceeds points_possible');
END;

-- Same validation on update
CREATE TRIGGER trg_score_not_over_max_upd
BEFORE UPDATE OF score ON grades
FOR EACH ROW
WHEN NEW.score > (SELECT points_possible FROM assignments WHERE assignment_id = NEW.assignment_id)
BEGIN
  SELECT RAISE(ABORT, 'Score exceeds points_possible');
END;
