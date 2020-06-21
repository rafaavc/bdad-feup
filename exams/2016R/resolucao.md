
# Question 15

```sql
SELECT nome
FROM Estudante
WHERE ID in 
    (SELECT ID1
     FROM Amizade JOIN Estudante on ID2 = ID
     WHERE nome LIKE "Gabriel%");
```

# Question 16

```sql
SELECT nome
FROM Estudante
WHERE ID in
    (SELECT ID1
    FROM Amizade JOIN Estudante on ID2 = ID
    GROUP BY ID1
    HAVING count(DISTINCT anoCurricular) = 5);
```

# Question 17

```sql
SELECT DISTINCT A1.ID1 as ID1, A2.ID2 as ID2
FROM Amizade as A1 JOIN Amizade as A2 on A1.ID2 = A2.ID1
WHERE A1.ID1 <> A2.ID2 AND A2.ID2 NOT IN 
    (SELECT ID2 FROM Amizade WHERE ID1 = A1.ID1)
ORDER BY ID1;
```

# Question 18

```sql
SELECT E1.nome, E2.nome
FROM (Amizade JOIN Estudante as E1 on ID1 = E1.ID) JOIN Estudante as E2 on ID2 = E2.ID
WHERE E1.curso <> E2.curso AND E1.ID < E2.ID;
```

# Question 19

```sql
DROP TRIGGER IF EXISTS InsereAmizade;
DROP TRIGGER IF EXISTS RemoveAmizade;
DROP TRIGGER IF EXISTS AlteraAmizade;

CREATE TRIGGER InsereAmizade
AFTER INSERT ON Amizade
FOR EACH ROW
BEGIN
    INSERT INTO Amizade VALUES(New.ID2, New.ID1);
END;

CREATE TRIGGER RemoveAmizade
AFTER DELETE ON Amizade
FOR EACH ROW
BEGIN
    DELETE FROM Amizade WHERE ID1 = Old.ID2 AND ID2 = Old.ID1;
END;

CREATE TRIGGER AlteraAmizade
AFTER UPDATE ON Amizade
FOR EACH ROW
BEGIN
    SELECT raise(FAIL, "You can't modify a friendship")
END;
```

