/* 1 */
select nr from ALUNO;

/* 2 */
select cod, Design from CADEIRA where curso = "AC";

/* 3 */
select DISTINCT ALUNO.Nome from ALUNO, PROF where ALUNO.Nome = PROF.Nome;
select DISTINCT Nome from ALUNO intersect select Nome from PROF;

/* 4 */
select DISTINCT Nome from ALUNO where Nome not in (select Nome from PROF);
select DISTINCT Nome from ALUNO except select Nome from PROF;

/* 5 */
select Nome from ALUNO union select Nome from PROF;

/* 6 */
select Nome from
(select DISTINCT ALUNO.nr from ALUNO, PROVA where cod = "TS1" and ALUNO.nr = PROVA.nr)
natural join ALUNO;

/* 7 */
select Nome from ALUNO where nr in
(select DISTINCT nr from ((select cod from CADEIRA where curso = "IS") natural join PROVA));

/* 8 */
SELECT DISTINCT nome FROM Aluno WHERE nr NOT IN
(SELECT nr AS alunonr
FROM Aluno, Cadeira
WHERE curso='IS' AND NOT (cod IN
(SELECT cod
FROM Prova
WHERE nota>=10 AND nr=alunonr))
);

/* 9 */
select DISTINCT p1.nota from PROVA as p1 
where not exists (select p2.nota from prova as p2 where p2.nota > p1.nota);

/* 10 */
select AVG(nota) from PROVA where cod = "BD";

/* 11 */
select COUNT(nr) from ALUNO;

/* 12 */
select COUNT(cod), curso from CADEIRA group by curso;

/* 13 */
select nr, COUNT(cod) from PROVA group by nr;

/* 14 */
select AVG(cod) from
(select nr, COUNT(cod) as cod from PROVA group by nr);

/* 15 */
select Nome, nota from
(select nr, AVG(nota) as nota from PROVA where nota >= 9.5 group by nr)
natural join ALUNO;

/* 16 */
select cod, Nome, nota from
(select cod, nr, MAX(nota) as nota from PROVA group by cod)
natural join ALUNO;

/* 17 */


