# Multiple Choice

- **i** b
- **ii** d
- **iii** c
- **iv** a
- **v** c
- **vi** b (?)
- **vii** b
- **viii** (?)
- **ix** (?)
- **x** b

? - don't think we learned that


# Practical

## 1

in progress...

## 2

R(A, B, C, D, E)<br/>
A->B<br/>
AC->D<br/>
BD->C<br/>
B->CE<br/>
E->A

### Normalizing to 3NF

**Obtaining the minimal basis**

1) Singleton right side attributes<br/>
A->B<br/>
AC->D<br/>
BD->C<br/>
B->C<br/>
B->E<br/>
E->A

2) Checking if there are redundant FDs<br/>
Without A->B, {A}+ = {A}, so this FD is **not** redundant.<br/>
Without AC->D, {AC}+ = {A, B, C, E}, so this FD is **not** redundant.<br/>
Without BD->C, {BD}+ = {B, D, C, E}, so this FD *is* redundant. (removed from now on)<br/>
Without B->C, {B}+ = {B, E, A}, so this FD is **not** redundant.<br/>
Without B->E, {B}+ = {B, C}, so this FD is **not** redundant.<br/>
Without E->A, {E}+ = {E}, so this FD is **not** redundant.

Basis without the redundant FDs:<br/>
A->B<br/>
AC->D<br/>
B->C<br/>
B->E<br/>
E->A

3) Checking if there are redundant left side attributes<br/>
AC->D:<br/>
Without the C, A->D. But {A}+ = {B, C, E, A}, so the C can't be removed.

AC->D:<br/>
Without the A, C->D. But {C}+ = {C}, so the A can't be removed.

**Minimal basis**<br/>
A->B<br/>
AC->D<br/>
B->C<br/>
B->E<br/>
E->A


**Making the relations**<br/>
Merging FDs with the same left side attributes.

R1(A, B)<br/>
R2(A, C, D)<br/>
R2(B, C, E)<br/>
R2(E, A)

{A, C, D}+ = {A, B, C, D, E}, therefore R2 is a super key.

Because there is at least one relation with a super key schema, we won't need to add one.

## 3

### a

```sql
SELECT hostname, nome
FROM Servidor JOIN Pessoa ON idResponsavel = idPessoa
WHERE vulneravel = "sim";
```

### b

```sql
SELECT hostname, descricao, nome
FROM ((AplicacaoServidor NATURAL JOIN Bug) 
    NATURAL JOIN Servidor) 
    JOIN Pessoa ON idPessoa = idResponsavel
ORDER BY hostname;
```

### c

```sql
SELECT hostname
FROM Servidor JOIN Pessoa ON idPessoa = idResponsavel
WHERE hostname LIKE 'alu%' AND mail = 'joao.almeida@cica.pt' AND idServidor IN (SELECT idServidor FROM Bug NATURAL JOIN AplicacaoServidor);
```

### d

```sql
SELECT nome
FROM
    (SELECT nome, max(cnt)
    FROM
        (SELECT nome, count(idBug) as cnt
        FROM Bug JOIN Aplicacao using(idAplicacao)
        GROUP BY idAplicacao));
```

### e

```sql
DROP TRIGGER IF EXISTS ServerAddApp;

CREATE TRIGGER ServerAddApp
AFTER INSERT ON AplicacaoServidor
FOR EACH ROW
BEGIN
    UPDATE Servidor SET vulneravel = "sim"
    WHERE New.idAplicacao in (SELECT idAplicacao FROM Bug) AND New.idServidor = Servidor.idServidor;
END;
```

### f

```sql
DROP TRIGGER IF EXISTS ServerAddBug;

CREATE TRIGGER ServerAddBug
AFTER INSERT ON Bug
FOR EACH ROW
BEGIN
    UPDATE Servidor SET vulneravel = "sim"
    WHERE idServidor in 
        (SELECT idServidor 
         FROM AplicacaoServidor
         WHERE idAplicacao = New.idAplicacao);
    UPDATE Bug SET prioridade = 1
    WHERE idBug = New.idBug;
END;
```
