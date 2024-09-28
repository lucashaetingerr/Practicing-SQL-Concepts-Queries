create  table depto
(coddepto   integer,
 nomedepto  varchar(20)  not null,
 PRIMARY KEY (coddepto));

create table Disciplina
(coddepto  integer,
 NumDisc   integer,
 NomeDisc  varchar(20) not null,
 CreditosDisc integer,
 PRIMARY KEY (CodDepto, NumDisc),
 FOREIGN KEY (CodDepto) REFERENCES Depto (coddepto));

create table PreReq
(CodDepto integer,
 NumDisc integer,
 CodDeptoPreReq integer,
 NumDiscPreReq integer,
 PRIMARY KEY (CodDepto,NumDisc,CodDeptoPreReq,NumDiscPreReq),
 FOREIGN KEY (CodDepto, NumDisc) REFERENCES Disciplina (CodDepto, NumDisc),
 FOREIGN KEY (CodDeptoPreReq, NumDiscPreReq) REFERENCES Disciplina (CodDepto, NumDisc));

create table Turma
(AnoSem  char(10) Not Null,
 CodDepto integer,
 NumDisc integer,
 SiglaTur char(5) Not Null,
 CapacOfer integer,
 PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur),
 FOREIGN KEY (CodDepto, NumDisc) REFERENCES Disciplina (CodDepto, NumDisc));

create table Predio
(CodPred integer,
 Nomepred char(10) Not Null,
 PRIMARY KEY (CodPred));

create table Sala
(CodPred integer,
 NumSala integer,
 CapacSala integer,
PRIMARY KEY (CodPred, NumSala),
FOREIGN KEY (CodPred) REFERENCES Predio (CodPred));

create table Horario
(AnoSem char(10) Not Null,
 CodDepto integer,
 NumDisc integer,
 SiglaTur char(5) Not Null,
 DiaSem char(5) Not Null,
 HoraIncio char(5) Not Null,
 NumHoras integer,
 CodPred integer,
 NumSala integer,
PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur),
FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTur) REFERENCES Turma (AnoSem, CodDepto, NumDisc, SiglaTur),
FOREIGN KEY (CodPred, NumSala) REFERENCES Sala (CodPred, NumSala));


create table titulacao
(CodTit  integer,
 NomeTit  char(10) not null,
PRIMARY KEY (CodTit));



create table Professor
(CodProf integer,
 NomeProf char(20),
 CodTit integer,
 CodDepto integer,
 PRIMARY KEY (CodProf),
 FOREIGN KEY (CodTit) REFERENCES titulacao (CodTit),
 FOREIGN KEY (CodDepto) REFERENCES depto (CodDepto));


create  table ProfTurma
(AnoSem char(10) Not Null,
 CodDepto integer,
 NumDisc integer,
 SiglaTur char(5) Not Null,
 CodProf integer,
 PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf),
 FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTur) REFERENCES Turma (AnoSem, CodDepto, NumDisc, SiglaTur) ,
 FOREIGN KEY (CodProf) REFERENCES Professor (CodProf));