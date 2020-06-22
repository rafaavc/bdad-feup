
# Question 11

R(A, B, C, D, E, F)<br/>
A -> B<br/>
B -> CD<br/>
AD -> E

### Decomposition into 3NF:

**Finding a minimal basis**

Making right sides with only one atribute:

A -> B<br/>
B -> C<br/>
B -> D<br/>
AD -> E

**Checking FD redundancy:**

Without A -> B, {A}+ = {A}, so A -> B is not redundant.<br/>
Without B -> C, {B}+ = {B, D}, so B -> C is not redundant.<br/>
Without B -> D, {B}+ = {B, C}, so B -> D is not redundant.<br/>
Without AD -> E, {AD}+ = {A, B, C, D}, so AD -> E is not redundant.

**Checking left side attributes redundancy:**

Removing D from AD -> E:<br/>
A -> E, and {A}+ = {A, B, C, D, E}, so D can be removed.<br/>
Removing A from AD -> E:<br/>
D -> E, but {D}+ = {D}, so A can't be removed.

**Minimal basis obtained:**

A -> B<br/>
A -> E<br/>
B -> D<br/>
B -> C

**Relations obtained (merging the left side of the functional dependencies):**

R1(A, B, E)<br/>
R2(B, C, D)

{A, B, E}+ = {A, B, C, D, E}  -> not a super key<br/>
{B, C, D}+ = {A, B, C, D, E}  -> not a super key

We need to add a key schema:<br/>
{A, F}+ = {A, B, C, D, E, F} so it is a super key.<br/>
R3(A, F)

The final relations, in 3NF, are:<br/>
    R1(A, B, E)<br/>
    R2(B, C, D)<br/>
    R3(A, F)

For each of the functional dependencies in each relation, the left side is either a super key for the relation or the attributes from the right side that aren't also on the left side are prime.

# Question 12

R1:<br/>
A -> BE

The left side of the FD is a super key, so it is in BCNF.

R2:<br/>
B -> CD

The left side of the FD is a super key, so it is in BCNF.

Both the relations are in BCNF.

# Question 13

in progress...

# Question 14

```sql
SELECT caption
FROM Photo JOIN User on user = User.id
WHERE julianday(uploadDate) - julianday(creationDate) = 2 AND name = 'Daniel Ramos';
```

# Question 15

```sql
SELECT name
FROM User
WHERE id NOT IN (SELECT user FROM Photo);
```

# Question 16

```sql
SELECT cast(sum(cnt) as float)/count(photo) as Media
FROM
    (SELECT photo, count(*) as cnt
     FROM AppearsIn
     WHERE photo in
        (SELECT photo
         FROM Likes
         GROUP BY photo
         HAVING count(*) > 3)
     GROUP BY photo);
```

# Question 17

```sql
DROP VIEW IF EXISTS PossibleUserIDs;

CREATE VIEW PossibleUserIDs AS
SELECT F1.user1 as u1, F1.user2 as u2, F2.user2 as u3
FROM (SELECT * FROM Friend WHERE user1 in (SELECT DISTINCT id FROM User WHERE name = "Daniel Ramos")) as F1 JOIN Friend as F2 on F1.user2 = F2.user1;

SELECT caption
FROM Photo JOIN
    (SELECT DISTINCT photo
     FROM AppearsIn
     WHERE user in (SELECT u1 FROM PossibleUserIDs) or user in (SELECT u2 FROM PossibleUserIDs) or user in (SELECT u3 FROM PossibleUserIDs)) ON id = photo;
```

# Question 18

```sql
DELETE FROM Photo
WHERE julianday(uploadDate) < julianday(DATE("2010-01-01")) 
    AND id in (SELECT photo
               FROM AppearsIn
               GROUP BY photo
               HAVING count(user) < 2);
```

# Question 19

```sql
DROP TRIGGER IF EXISTS enforceLike;

CREATE TRIGGER enforceLike
AFTER INSERT ON AppearsIn
FOR EACH ROW
BEGIN
    INSERT INTO Likes VALUES(New.user, New.Photo);
END;
```
