CREATE TABLE `product`
(
  id    INT AUTO_INCREMENT PRIMARY KEY,
  name  VARCHAR(45) NOT NULL,
  stock INT         NOT NULL,
  price float       NOT NULL
);

CREATE TABLE user
(
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(45) NOT NULL,
  clear_pw    VARCHAR(45) NOT NULL,
  password    VARCHAR(45) NOT NULL,
  credit_card VARCHAR(45) NOT NULL,
  mail        VARCHAR(45) NOT NULL,
  `group`     VARCHAR(45) NOT NULL
);

INSERT INTO product (id, name, stock, price)
VALUES (1, 'Nägel 3x30mm (100)', 13, 14.95);
INSERT INTO product (id, name, stock, price)
VALUES (2, 'Schrauben 6x110mm (24)', 1000, 23.99);
INSERT INTO product (id, name, stock, price)
VALUES (3, 'Hammer (4kg)', 4, 13.75);
INSERT INTO product (id, name, stock, price)
VALUES (4, 'Nägel 3x25mm (100)', 550, 13.25);
INSERT INTO product (id, name, stock, price)
VALUES (5, 'Nägel 2x16mm (25)', 230, 7.95);
INSERT INTO product (id, name, stock, price)
VALUES (6, 'Nägel 2x14 mm (10)', 360, 4.95);
INSERT INTO product (id, name, stock, price)
VALUES (7, 'Hammer klein (1kg)', 96, 12.99);
INSERT INTO product (id, name, stock, price)
VALUES (8, 'Schrauben SPAX (universal)', 43, 5.55);
INSERT INTO product (id, name, stock, price)
VALUES (9, 'Schrauben & Nägel Set (1500)', 1337, 42.42);
INSERT INTO product (id, name, stock, price)
VALUES (10, 'Klebenband 3cmx50m', 80, 3.99);

INSERT INTO user (id, name, clear_pw, password, credit_card, mail, `group`)
VALUES (1, 'admin', '1234', '81dc9bdb52d04dc20036dbd8313ed055', '4916727416168337', 'admin@supershop.com', 'admin');
INSERT INTO user (id, name, clear_pw, password, credit_card, mail, `group`)
VALUES (2, 'bob', 'test', '098f6bcd4621d373cade4e832627b4f6', '5386540943324143', 'bob@tablesoccer.org', 'user');
INSERT INTO user (id, name, clear_pw, password, credit_card, mail, `group`)
VALUES (3, 'charly', 'secret', '5ebe2294ecd0e0f08eab7690d2a6ee69', '345531683096018', 'ch@rly.me', 'user');
