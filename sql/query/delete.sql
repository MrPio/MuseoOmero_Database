use museo_omero;

# op 41
DELETE
FROM opere
WHERE id = 13;


# op 42
DELETE
FROM mostre
WHERE evento = 26;


# op 43
set @articolo = 'benda';
delete
from articoli
where nome = @articolo;


# op 44
set @ordine = '9';
drop procedure rimuovi_ordine_se_non_spedito;
create procedure rimuovi_ordine_se_non_spedito(in ordine int)
begin
    if exists(select * from ordini where id = ordine and is_spedito = false) then
        delete from ordini where id = ordine;
    end if;
end;
call rimuovi_ordine_se_non_spedito(@ordine);


# op 45
DELETE
FROM prenotazioni
WHERE gruppo = 2
  and attivita = 4;


# op 46
set @current_contract_date = (select max(data_inizio)
                              from ruoli_reali
                              where dipendente = 24);
update ruoli_reali
set is_storico = true and data_fine = current_date
where dipendente = 24
  and data_inizio = @current_contract_date;


# op 47
set @dipendente_id = 7;
set @turno = 'giovedi';
delete
from turni
where dipendente = @dipendente_id
  and giorno = @turno
  and data_inizio = all (select rr.data_inizio
                         from ruoli_reali rr
                         where rr.dipendente = @dipendente_id
                           and rr.is_storico = false)
