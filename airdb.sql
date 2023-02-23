-- Prima di eseguire lo script, lanciare il commando: SET GLOBAL local_infile = true;
-- oppure aggiungere il parametro –-local_infile=1 al comando mysql.


DROP DATABASE IF EXISTS airdb;
CREATE DATABASE airdb;

DROP USER IF EXISTS 'airuser'@'localhost';
CREATE USER 'airuser'@'localhost' IDENTIFIED BY 'airuser';
GRANT ALL ON airdb.* TO 'airuser'@'localhost';

USE airdb;

DROP TABLE IF EXISTS aerei;
CREATE TABLE aerei (
  id char(20) primary key,
  produttore char(20) not null,
  modello char(10) not null,
  dataimm date,
  numposti int
);

LOAD DATA LOCAL INFILE 'datiaerei.sql'
INTO TABLE aerei (id,produttore,modello,dataimm,numposti);

LOAD DATA LOCAL INFILE 'datiaerei2.sql'
INTO TABLE aerei FIELDS TERMINATED BY ',' ENCLOSED BY '"'
IGNORE 1 LINES (id,produttore,modello,dataimm,numposti);

