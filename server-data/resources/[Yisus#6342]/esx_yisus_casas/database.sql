ALTER TABLE users ADD COLUMN house LONGTEXT;
ALTER TABLE users ADD COLUMN bought_furniture LONGTEXT;

CREATE TABLE IF NOT EXISTS `bought_houses` (
  `houseid` INT(50),
  PRIMARY KEY (`houseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('housing', 'Housing', 0)
;

INSERT INTO `datastore` (name, label, shared) VALUES
  ('housing', 'Housing', 0)
;

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('housing_black_money', 'Dinero Negro de las Casas' ,0)
;