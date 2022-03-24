## BEFOR DELETE TRIGGER
USE MYSQLPRPOJECT
DELIMITER $$
USE `mysqlproject`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mysqlproject`.`cab_fare_BEFORE_DELETE` BEFORE DELETE ON `cab_fare` FOR EACH ROW
BEGIN
	INSERT INTO `mysqlproject`.`cab_fare_BEFORE_DELETE` (`CAB_ID`,`UP_STATION`,`DOWN_STATION`, `CAB_FARE`)
	VALUES (OLD.`CAB_ID`,OLD.`UP_STATION`,OLD.`DOWN_STATION`, OLD.`CAB_FARE`);
END$$
DELIMITER ;

## BEFORE UPDATE TRIGGER

use mysqlproject;
DELIMITER $$
CREATE TRIGGER `mysqlproject`.`before_cab_fare_update`
    BEFORE UPDATE 
    ON `mysqlproject`.`cab_fare` FOR EACH ROW
BEGIN
     DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new cab fare ',
                        NEW.cab_fare,
                        ' cannot be 2 times greater than the current cab_fare ',
                        OLD.Cab_fare);
                        
    IF new.cab_fare > old.cab_fare * 2 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END$$    
DELIMITER ;

