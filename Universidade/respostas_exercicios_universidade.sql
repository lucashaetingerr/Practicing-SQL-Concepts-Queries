-- Respostas Modelo Universidade
--
-- 1 - Obtenha os nomes das disciplinas que possuem mais de três créditos.
select
    nomedisc
from
    disciplina
where
    creditosdisc > 3;

-- 2 Obtenha os códigos dos professores que ministraram aulas em 2009/1.
select
    professor.codprof,
    nomeProf
from
    professor,
    profturma
where
    profturma.codprof = professor.codprof
    and profturma.anosem = '20091';

-- 3 Obtenha os nomes das disciplinas seguidas do nome de seu departamento. 
-- (Resolver com produto cartesiano, com junção e com junção natural)
select
    nomedisc,
    nomedepto
from
    disciplina,
    depto
where
    depto.coddepto = disciplina.coddepto;

/* JUNÇÃO */
SELECT
    NOMEDISC,
    NOMEDEPTO
FROM
    DISCIPLINA
    JOIN DEPTO ON DISCIPLINA.CODDEPTO = DEPTO.CODDEPTO;

/* JUNÇÃO NATURAL */
SELECT
    NOMEDISC,
    NOMEDEPTO
FROM
    DISCIPLINA
    NATURAL JOIN DEPTO;

-- 4 Obtenha os nomes dos professores que possuem titulação de ‘Dr‘.
--  (Resolver com produto cartesiano e com junção)
select
    *
from
    titulacao;

select
    nomeprof
from
    professor,
    titulacao
where
    titulacao.codtit = professor.codtit
    and titulacao.nometit = 'DOUTORADO';

/* JUNÇÃO */
SELECT
    NOMEPROF
FROM
    PROFESSOR
    JOIN TITULACAO ON PROFESSOR.codtit = TITULACAO.CODTIT
    AND NOMETIT = 'DOUTORADO';

-- 5 Obtenha os nomes dos professores que ministraram aulas em 2008/2.
select
    nomeprof
from
    professor,
    profturma
where
    profturma.codprof = professor.codprof
    and profturma.anosem = '20082';

/* JUNÇÃO */
SELECT DISTINCT
    NOMEPROF
FROM
    PROFESSOR
    JOIN PROFTURMA ON PROFESSOR.CODPROF = PROFTURMA.CODPROF
    AND ANOSEM = '20082';

-- 6 Obtenha os números das salas do prédio de nome ’PREDIO 1’ 
-- cuja capacidade seja maior que 30.
select
    numsala
from
    sala,
    predio
where
    predio.codpred = sala.codpred
    and predio.nomepred = 'PREDIO 1'
    and sala.capacsala >= 30;

/* JUNÇÃO */
SELECT
    NUMSALA
FROM
    SALA
    JOIN PREDIO ON SALA.CODPRED = PREDIO.CODPRED
    AND NOMEPRED = 'PREDIO 2'
    AND CAPACSALA > 30;

-- 7 Obtenha os nomes das disciplinas que foram oferecidas em 2009/1.
select
    nomedisc
from
    disciplina,
    turma
where
    turma.coddepto = disciplina.coddepto
    and turma.numdisc = disciplina.numdisc
    and turma.anosem = '20091';

/* JUNÇÃO */
SELECT DISTINCT
    NOMEDISC
FROM
    DISCIPLINA
    JOIN TURMA ON TURMA.CODDEPTO = DISCIPLINA.CODDEPTO
    AND TURMA.NUMDISC = DISCIPLINA.NUMDISC
    AND ANOSEM = '20091';

-- 8 Obtenha os números das salas do prédio "PREDIO 1". 
select
    predio.codpred,
    numsala
from
    predio,
    sala
where
    sala.codpred = predio.codpred
    and predio.nomepred = 'PREDIO 1';

/* JUNÇÃO */
SELECT
    NUMSALA
FROM
    SALA
    JOIN PREDIO ON SALA.CODPRED = PREDIO.CODPRED
    AND NOMEPRED = 'PREDIO 1';

-- 9 Obtenha os nomes dos professores seguidos do nome de seu departamento
select
    nomeprof,
    nomedepto
from
    professor,
    depto
where
    depto.coddepto = professor.coddepto;

-- 10 Obtenha os códigos dos professores que não possuem turma em 2008/2.
-- Todos os professores com turma mas que não deram aula em '20082' */
select
    professor.codprof
from
    professor,
    profturma
where
    profturma.codprof = professor.codprof
    and profturma.anosem <> '20082';

/* resolução: COM IN */
select
    professor.codprof
from
    professor,
    profturma
where
    profturma.codprof = professor.codprof
    and professor.codprof not in (
        select
            professor.codprof
        from
            professor,
            profturma
        where
            profturma.codprof = professor.codprof
            and profturma.anosem = '20082'
    );

/* Todos os professores menos os professores que deram aula em '20082' */
select
    nomeprof,
    codprof
from
    professor
where
    Codprof not in (
        select
            codprof
        from
            profturma
        where
            anosem = '20082'
    );

/* resolução: COM EXISTS */
SELECT
    CODPROF
FROM
    PROFESSOR
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            PROFTURMA
        WHERE
            ANOSEM = '20082'
            AND PROFTURMA.CODPROF = PROFESSOR.CODPROF
    );

-- 11 Nomes dos departamentos que possuem disciplinas que não apresentam pré-requisito.
select
    depto.coddepto,
    nomedepto,
    numdisc
from
    disciplina,
    depto
where
    depto.coddepto = disciplina.coddepto
    and not exists (
        select
            prereq.coddepto
        from
            prereq
        where
            prereq.coddepto = disciplina.coddepto
            and prereq.numdisc = disciplina.numdisc
    );

/* Not in */
select
    coddepto,
    numdisc,
    nomedisc
from
    disciplina
where
    (coddepto, numdisc) not in (
        Select
            coddepto,
            numdisc
        from
            prereq
    );

-- 12 Obtenha os códigos dos professores que ministraram aulas em 2008/2 e 2009/1.
select
    codprof
from
    profturma
where
    profturma.anosem = '20082'
    and profturma.codprof in (
        select
            codprof
        from
            profturma
        where
            profturma.anosem = '20091'
    );

SELECT
    CODPROF
FROM
    PROFTURMA T1
WHERE
    ANOSEM = '20082'
    AND EXISTS (
        SELECT
            *
        FROM
            PROFTURMA T2
        WHERE
            ANOSEM = '20091'
            AND T2.CODPROF = T1.CODPROF
    );

-- 13 Obtenha os nomes dos departamentos em que há pelo menos 
-- uma disciplina com mais que três créditos.
select
    nomedepto
from
    depto
where
    exists (
        select
            coddepto
        from
            disciplina
        where
            disciplina.coddepto = depto.coddepto
            and disciplina.creditosdisc > 3
    );

SELECT DISTINCT
    NOMEDEPTO
FROM
    DEPTO,
    DISCIPLINA
WHERE
    CREDITOSDISC > 3
    AND DISCIPLINA.CODDEPTO = DEPTO.CODDEPTO;

-- 14 Para cada disciplina que tem pré-requisito, obtenha o nome da disciplina
--  e o nome de cada um de seus pré-requisitos. 
-- Obtenha os dados em uma tabela com duas colunas, uma com o nome da disciplina 
-- e outra com o do pré-requisito.
select
    disciplina.nomedisc as Disciplina,
    disciplinapre.nomedisc as 'Pré-Requisito'
from
    disciplina,
    prereq,
    disciplina as disciplinapre
where
    prereq.coddepto = disciplina.coddepto
    and prereq.numdisc = disciplina.numdisc
    and disciplinapre.coddepto = prereq.coddeptoprereq
    and disciplinapre.numdisc = prereq.numdiscprereq;

select
    *
from
    prereq;

select
    *
from
    Disciplina;

SELECT
    DISC.NOMEDISC,
    DISC2.NOMEDISC
FROM
    (
        DISCIPLINA DISC
        JOIN PREREQ PRE ON DISC.CODDEPTO = PRE.CODDEPTO
        AND DISC.NUMDISC = PRE.NUMDISC
    )
    JOIN DISCIPLINA DISC2 ON DISC2.CODDEPTO = PRE.CODDEPTOPREREQ
    AND DISC2.NUMDISC = PRE.NUMDISCPREREQ;

-- 15 Obtenha o nome de todas as disciplinas e seus pré-requisitos, 
-- em uma tabela com duas colunas, uma com o nome da disciplina e outra com o nome 
-- do pré-requisito. Caso a disciplina não possua pré-requisito, ele deve aparecer vazio.
select
    disciplina.coddepto,
    disciplina.nomedisc as Disciplina,
    disciplinapre.coddepto,
    disciplinapre.nomedisc as 'Pré-Requisito'
from
    disciplina
    left join prereq on (
        disciplina.coddepto = prereq.coddepto
        and disciplina.numdisc = prereq.numdisc
    )
    left join disciplina as disciplinapre on (
        disciplinapre.coddepto = prereq.coddeptoprereq
        and disciplinapre.numdisc = prereq.numdiscprereq
    );