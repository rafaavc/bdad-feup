drop trigger if exists IncrementStock;
drop trigger if exists SetClient;

-- 1c
Create Trigger IncrementStock
After insert on ReparacaoPeca
for each row
begin
    Update Peca
    set quantidade = quantidade - New.quantidade
    where idPeca = New.idPeca;
end;

-- 1a
Create Trigger SetClient
After insert on Reparacao
for each row
when New.idCliente is null
begin
    Update Reparacao
    set idCliente = (select Carro.idCliente from Carro where Carro.idCarro = New.idCarro)
    where idReparacao = New.idReparacao;
end;

-- 1b
-- select case

