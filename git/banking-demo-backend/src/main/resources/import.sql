CREATE TABLE IF NOT EXISTS customers (
  id int unsigned NOT NULL AUTO_INCREMENT,
  firstname varchar(255) NOT NULL DEFAULT '',
  surname varchar(255) NOT NULL DEFAULT '',
  address varchar(255) NOT NULL DEFAULT '',
  email varchar(255) NOT NULL DEFAULT '',
  username varchar(255) NOT NULL,
  balance decimal(10, 2) unsigned NOT NULL,
  PRIMARY KEY(id),
  UNIQUE KEY k_username(username)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS transactions (
  id int unsigned NOT NULL AUTO_INCREMENT,
  fromid int unsigned NULL,
  payee int unsigned NULL,
  amount decimal(10, 2) unsigned NOT NULL,
  details varchar(255),
  txdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
) DEFAULT CHARSET=utf8;

INSERT IGNORE INTO customers VALUES (1, 'Gareth', 'Healy', '200 Fowler Avenue, Farnborough', 'ghealy@redhat.com', 'ghealy', 100.00);
INSERT IGNORE INTO customers VALUES (2, 'Nabeel','Saad', '64 Baker Street, London', 'nsaad@redhat.com', 'nsaad', 100.00);
INSERT IGNORE INTO customers VALUES (3, 'Costas', 'Sterpis', '200 Fowler Avenue, Farnborough', 'csterpis@redhat.com','sterpis', 100.00);
INSERT IGNORE INTO customers VALUES (4, 'Chris', 'Milsted', '200 Fowler Avenue, Farnborough', 'cmilsted@redhat.com', 'cmilsted', 100.00);
INSERT IGNORE INTO customers VALUES (5, 'Jim', 'Minter', '64 Baker Street, London', 'jminter@redhat.com', 'jminter', 100.00);
