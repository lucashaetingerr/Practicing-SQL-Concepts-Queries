/*  Criação de Tabelas para o Modelo de Venda de Passagens     */ 

-- Inserts de dados de teste de algumas tabelas.

create table cliente(
id int not null auto_increment primary key,
nome varchar(100) not null
) engine = Innodb;

create table localidade(
cod int not null primary key,
nome varchar(100)
) engine = Innodb;

create table veiculo(
id int not null primary key,
capacidade int
) engine = Innodb;

create table linha(
cod_linha int not null primary key,
cid_ori int,
cid_des int,
foreign key (cid_ori) references localidade(cod),
foreign key (cid_des) references localidade(cod)
) engine = Innodb;

create table horario(
id int not null,
hora time,
id_veiculo int not null,
cod_lin int not null,
tempo_viagem int,
valor decimal(10,2),
primary key (id,cod_lin),
foreign key (cod_lin) references linha(cod_linha),
foreign key (id_veiculo) references veiculo(id)
) engine = Innodb;


create table passagem(
num int not null primary key,
data_passagem date,
valor decimal(10,2),
banco int,
id_cli int null,
cod_linha int not null,
cod_horario int not null,
foreign key(cod_linha) references linha(cod_linha),
foreign key (cod_horario, cod_linha) references horario(id, cod_lin),
foreign key(id_cli) references cliente(id)
) engine = Innodb;


create table ocupacao(
data_ocupacao date not null,
id_horario int not null,
cod_lin int not null, 
banco int not null,
status_ocup char(1),
primary key (data_ocupacao,id_horario, cod_lin, banco),
foreign key(id_horario, cod_lin) references horario(id, cod_lin)
) engine = Innodb;


insert into cliente (nome) values ('Ana Maria'), ('João Carlos'), ('Andre Pereira');

insert into localidade values (1,'Santa Cruz do Sul'), (2,'Venâncio Aires'), (3,'Porto Alegre'), (4,'Santa Maria');

insert into veiculo values (1, 30), (2, 45), (3, 60);

insert into linha values (1, 1, 3), (2, 1, 2), (3, 3, 4);

insert into horario values (1, '08:00', 3, 1, 120, 45), (2, '14:00', 2, 1, 160, 42);

insert into horario values (3, '06:00', 1, 2, 30, 15), (4, '12:00', 1, 2, 30, 15), (5, '16:00', 1, 2, 30, 15);

insert into horario values (6, '08:00', 3, 3 ,240, 70);

insert into veiculo values (4, 50);