/*
a->g
n->p
s->x
*/

/* a */
select * from Peca where custoUnitario < 10 and codigo like "%98%";

/* b */
select matricula 
from Reparacao left join Carro using(idCarro)
where dataFim like "2010-09-__";

/* c */
select nome
from Cliente natural join
(select distinct idCliente
from ((ReparacaoPeca left join Reparacao using(idReparacao)) left join Peca using(idPeca))
where custoUnitario > 10);

/* d */
select idCliente
from Cliente
except select idCliente from Carro;

/* e */
select idCarro, count(idReparacao)
from Reparacao group by idCarro;

/* f */
select idCarro, sum(diasReparacao)
from (
    select julianday(dataFim) - julianday(dataInicio) as diasReparacao, idCarro
    from Reparacao
) group by idCarro;

/* g */
select avg(custoUnitario) from Peca;
select idPeca, sum(quantidade*custoUnitario), quantidade from Peca group by idPeca;

--(h->m)

/* n */

