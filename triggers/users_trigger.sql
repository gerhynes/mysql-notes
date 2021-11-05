DELIMITER $$

CREATE TRIGGER must_be_adult
  BEFORE INSERT ON users FOR EACH ROW
  BEGIN
    IF NEW.age < 18
    THEN
      SIGNAL SQLSTATE '4500'
        SET MESSAGE_TEXT = 'Must be an adult!';
    END IF;
  END;
$$
DELIMITER ;