-- This SP converts all cache_ tables into MyISAM engine
-- This should allow faster development speeds

DROP PROCEDURE IF EXISTS cacheTablesEngineChange;
delimiter $$
CREATE PROCEDURE cacheTablesEngineChange()

BEGIN
    DECLARE table_name VARCHAR(255);
    DECLARE end_of_tables INT DEFAULT 0;

    DECLARE cur CURSOR FOR
      SELECT t.table_name
      FROM information_schema.tables t
      WHERE t.table_schema = DATABASE() AND t.table_type='BASE TABLE' AND t.table_name like '%cache%';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_of_tables = 1;

    SET FOREIGN_KEY_CHECKS = 0;
    OPEN cur;

    tables_loop: LOOP
      FETCH cur INTO table_name;

      IF end_of_tables = 1 THEN
        LEAVE tables_loop;
      END IF;
      SET @s = CONCAT('ALTER TABLE ' , table_name, ' ENGINE = MYISAM;');
     -- select @s;
      PREPARE stmt FROM @s;
      EXECUTE stmt;

    END LOOP;

    CLOSE cur;
    SET FOREIGN_KEY_CHECKS = 1;
  END $$
delimiter ;

CALL cacheTablesEngineChange();
 select table_name, engine from information_schema.tables where table_name like '%cache%';
 DROP PROCEDURE IF EXISTS cacheTablesEngineChange;
