DROP SCHEMA IF EXISTS MondoPokemon;
CREATE SCHEMA MondoPokemon;
USE MondoPokemon;

create table Allenatore
(
    cf int(6) PRIMARY KEY NOT NULL, 
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    soprannome varchar(20) NOT NULL,
    datadinascita date
);

create table Palestra
(
   nomepalestra varchar(20) PRIMARY KEY NOT NULL,
   città varchar(25) NOT NULL,
   tipopalestra varchar(20) NOT NULL
);

create table Capopalestra
(
    cf int(6) NOT NULL,
    livello int(1) NOT NULL,
    nomepalestra varchar(20) NOT NULL,
    PRIMARY KEY(cf),
    FOREIGN KEY(cf) REFERENCES Allenatore(cf) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY(nomepalestra) REFERENCES Palestra(nomepalestra) ON UPDATE cascade ON DELETE cascade
);

create table Pokemon
(
   codicepokemon int(7) PRIMARY KEY NOT NULL,
   altezza float(5) NOT NULL,
   generazione int(1) NOT NULL,
   peso float(5) NOT NULL,
   nomepokemon varchar(20) NOT NULL,
   sesso char(1) NOT NULL,
   cf int(6) NOT NULL,
   FOREIGN KEY(cf) REFERENCES Allenatore(cf) ON UPDATE cascade ON DELETE cascade
);

create table CentroPokemon
(
   codicecentro int(7) PRIMARY KEY NOT NULL,
   tipocentropokemon varchar(20) NOT NULL,
   numeropokemonassistiti bigint(5) NOT NULL,
   nomecentro varchar(20) NOT NULL
);

DROP TABLE IF EXISTS Sfida;
create table Sfida
(
   codicesfida int(7) PRIMARY KEY NOT NULL,
   tiposfida varchar(20) NOT NULL,
   vincitore bigint(6) NOT NULL,
   nomepalestra varchar(20),
   FOREIGN KEY(nomepalestra) REFERENCES Palestra(nomepalestra) ON UPDATE cascade ON DELETE cascade
);

create table Zaino 
(
   cf int(6) NOT NULL,
   capacità int(3) NOT NULL,
   PRIMARY KEY(cf),
   FOREIGN KEY(cf) REFERENCES Allenatore(cf) ON UPDATE cascade ON DELETE cascade
);

create table Strumento
(
   EAN int(7) PRIMARY KEY NOT NULL,
   nomestrumento varchar(20) NOT NULL,
   tipostrumento varchar(20) NOT NULL
);

create table Medaglia
(
   nomemedaglia varchar(20) NOT NULL,
   codicemedaglia int(5) NOT NULL,
   nomepalestra varchar(20) NOT NULL,
   PRIMARY KEY(nomemedaglia,nomepalestra),
   FOREIGN KEY(nomepalestra) REFERENCES Palestra(nomepalestra) ON UPDATE cascade ON DELETE cascade
);

create table Mossa
(
   nomemossa varchar(20) PRIMARY KEY NOT NULL,
   tipo varchar(20) NOT NULL,
   potenza int(3) NOT NULL
);

create table VieneAssistitoDal
(
   codicepokemon int(7) NOT NULL,
   codicecentro int(7) NOT NULL,
   PRIMARY KEY(codicepokemon,codicecentro),
   FOREIGN KEY(codicepokemon) REFERENCES Pokemon(codicepokemon) ON UPDATE cascade ON DELETE cascade,
   FOREIGN KEY(codicecentro) REFERENCES CentroPokemon(codicecentro) ON UPDATE cascade ON DELETE cascade
);

create table Conosce
(
   codicepokemon int(7) NOT NULL,
   nomemossa varchar(20) NOT NULL,
   PRIMARY KEY(codicepokemon,nomemossa),
   FOREIGN KEY(codicepokemon) REFERENCES Pokemon(codicepokemon) ON UPDATE cascade ON DELETE cascade,
   FOREIGN KEY(nomemossa) REFERENCES Mossa(nomemossa) ON UPDATE cascade ON DELETE cascade
);

DROP TABLE IF EXISTS Affronta;
create table Affronta
(
    codicesfida int(7) NOT NULL,
    cf int(6) NOT NULL,
    PRIMARY KEY(codicesfida,cf),
    FOREIGN KEY(codicesfida) REFERENCES Sfida(codicesfida) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY(cf) REFERENCES Allenatore(cf) ON UPDATE cascade ON DELETE cascade
);

create table Contiene
(
    EAN int(7) NOT NULL,
    cf int(6) NOT NULL,
    PRIMARY KEY(EAN,cf),
    FOREIGN KEY(EAN) REFERENCES Strumento(EAN) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY(cf) REFERENCES Zaino(cf) ON UPDATE cascade ON DELETE cascade
);

create table Tipo
(
    nometipo varchar(20)  NOT NULL,
    codicepokemon int(7) NOT NULL,
    PRIMARY KEY(nometipo,codicepokemon),
    FOREIGN KEY(codicepokemon) REFERENCES Pokemon(codicepokemon) ON UPDATE cascade ON DELETE cascade
);

create table SiIdentificaIN
(
   nometipo varchar(20) NOT NULL,
   codicepokemon int(7) NOT NULL,
   PRIMARY KEY(nometipo,codicepokemon),
   FOREIGN KEY(nometipo) REFERENCES Tipo(nometipo) ON UPDATE cascade ON DELETE cascade,
   FOREIGN KEY(codicepokemon) REFERENCES Pokemon(codicepokemon) ON UPDATE cascade ON DELETE cascade
);
   
 DROP TABLE IF EXISTS avviene;  
create table avviene
(
nomepalestra varchar(20) NOT NULL,
codicesfida int(7) NOT NULL,
PRIMARY KEY(nomepalestra,codicesfida),
FOREIGN KEY(nomepalestra) REFERENCES Palestra(nomepalestra) ON UPDATE cascade ON DELETE cascade,
FOREIGN KEY(codicesfida) REFERENCES Sfida(codicesfida) ON UPDATE cascade ON DELETE cascade
);

/*dati allenatore*/
INSERT INTO Allenatore(cf,nome,cognome,soprannome,datadinascita) VALUES
(012345,'Ash','Ketchum','protagonista',11/03/1998),
(100000,'Paolo','Cannone','bullo',22/02/1982),
(345621,'Elena','Fausti','diabolica',16/11/2003),
(111111,'Matteo','Golia','campione',09/11/2001),
(222222,'Giada','Leotta','modella',07/07/1980),
(333333,'Federico','Ariosto','giustiziere',14/05/2000),
(444444,'Giovanni','Giolitti','eroe',25/12/1999),
(555555,'Cecilia','Rossi','signora',28/08/1993),
(457586,'Diana','Cortellesi','bella',26/04/2002);

/*dati palestra*/
INSERT INTO Palestra(nomepalestra,città,tipopalestra) VALUES

('Plumbeo','Plumbeopoli','Roccia'),
('Celeste','Celestopoli','Acqua'),
('Neve','Neveopoli','Ghiaccio'),
('Astra','Austropoli','Coleottero');

/*dati capopalestra*/
INSERT INTO Capopalestra(cf,livello,nomepalestra) VALUES
(100000,2,'Plumbeo'),
(012345,4,'Neve'),
(345621,3,'Astra'),
(444444,1,'Celeste');

/* dati pokemon*/
INSERT INTO Pokemon(codicepokemon,altezza,generazione,peso,nomepokemon,sesso,cf) VALUES
(1000001,1.80,1,60,'Mew','M',100000),
(1234567,0.60,1,15,'Pikachu','F',012345),       
(0707070,0.80,4,25,'Bidoof','M',100000),
(1251241,1.50,6,81.5,'Pyroar','M',457586),
(5555555,2.10,1,100,'Charmander','M',345621),
(0707071,0.80,4,25,'Bidoof','M',222222),
(0707072,0.80,4,25,'Bidoof','F',333333),
(0707073,0.80,4,25,'Bidoof','F',444444),
(0707074,0.80,4,25,'Bidoof','M',111111),
(0707075,0.80,4,25,'Bidoof','M',555555);


INSERT INTO CentroPokemon(codicecentro,tipocentropokemon,numeropokemonassistiti,nomecentro) VALUES
(8456791,'cittadino',15,'SanFranco'),
(7775463,'cittadino',85,'MariaRosaria'),
(0014758,'esterno',33,'GrottaTundra');


INSERT INTO Tipo(nometipo,codicepokemon) VALUES
('Fuoco', 1251241),
('Psycho',1000001),
('Elettro',1234567),
('Normale',0707070),
('Fuoco',5555555),
('Normale',0707072),
('Normale',0707073),
('Normale',0707074),
('Normale',0707075);

INSERT INTO Sfida(codicesfida,tiposfida,vincitore,nomepalestra) VALUES
(0000000,'singola',012345,'Neve'),
(0000001,'singola',100000,NULL),
(0000002,'doppia',100000,'Plumbeo'),
(0000003,'singola',457586,NULL),
(0000004,'singola',012345,NULL);

INSERT INTO Zaino(cf,capacità) VALUES
(012345,300),
(100000,200),
(345621,100),
(111111,150),
(222222,150),
(333333,150),
(444444,100),
(555555,200),
(457586,250);

INSERT INTO Strumento(EAN,nomestrumento,tipostrumento) VALUES
(6789123,'pozione','curativo'),
(6789124,'pozione','curativo'),
(6789125,'iperpozione','curativo'),
(6789126,'rivitalizzante','curativo'),
(6789127,'pietratuono','evolutivo'),
(6789128,'pietrafuoco','evolutivo'),
(6789129,'pozione','curativo'),
(6789130,'pietratuono','evolutivo'),
(6789131,'baccarancione','bacca'),
(6789132,'baccabanana','bacca'),
(6789133,'baccananas','bacca');

INSERT INTO Medaglia(nomemedaglia,codicemedaglia,nomepalestra) VALUES
('Medagliarocciosa',11111,'Plumbeo'),
('Medagliapalude',22222,'Celeste'),
('Medagliaghiacciata',33333,'Neve'),
('Medagliabocciolo',44444,'Astra');

INSERT INTO Mossa(nomemossa,tipo,potenza) VALUES
('Braciere','Fuoco',15),
('PistolAcqua','Acqua',15),
('Azione','Normale',20),
('Fulmine','Elettrico',35),
('Iperraggio','Normale',45),
('Foglielama','Erba',35),
('Idropompa','Acqua',35),
('Lanciafiamme','Fuoco',40),
('Confusione','Psycho',20);

INSERT INTO VieneAssistitoDal(codicepokemon,codicecentro) VALUES
(0707070,8456791),
(1251241,8456791),
(5555555,8456791),
(1234567,7775463),
(0707070,7775463),
(0707070,0014758);

INSERT INTO Conosce(codicepokemon,nomemossa) VALUES
(1000001,'Confusione'),
(1000001,'Idropompa'),
(1000001,'Iperraggio'),
(0707070,'Azione'),
(1234567,'Fulmine'),
(1234567,'Azione'),
(1251241,'Foglielama'),
(1251241,'Braciere'),
(5555555,'Lanciafiamme'),
(0707071,'Azione'),
(0707072,'Iperraggio'),
(0707073,'Azione'),
(0707074,'Azione'),
(0707075,'Azione'),
(5555555,'Iperraggio');

INSERT INTO Affronta(codicesfida,cf) VALUES
(0000000,012345),
(0000000,555555),
(0000001,444444),
(0000001,012345),
(0000002,333333),
(0000002,100000),
(0000003,222222),
(0000003,444444),
(0000004,457586),
(0000004,111111);

INSERT INTO Contiene(EAN,cf) VALUES
(6789123,100000),
(6789124,345621),
(6789125,012345),
(6789126,012345),
(6789127,012345),
(6789128,333333),
(6789129,444444),
(6789130,555555),
(6789131,100000),
(6789132,222222),
(6789133,111111);

INSERT INTO SiIdentificaIn(nometipo,codicepokemon) VALUES
('Fuoco',1251241),
('Psycho',1000001),
('Elettro',1234567),
('Normale',0707070),
('Normale',0707071),
('Normale',0707072),
('Normale',0707073),
('Normale',0707074),
('Normale',0707075),
('Fuoco',5555555);

INSERT INTO Avviene(nomepalestra,codicesfida) VALUES
('Neve',0000000),
('Plumbeo',0000002);