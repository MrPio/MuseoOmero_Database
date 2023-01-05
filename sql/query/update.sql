use museo_omero;
# op 36
set @opera_id = 1;
set @opera_descrizione =
        '“Il Partenone racchiude un’armonica sintesi di utilità, solidità e piacevolezza”, Vitruvio da “De Architectura”.';
set @opera_sala = ' Greco e Romano';
set @mostra_id = 19;
drop procedure assegna_rimuovi_opera_in_mostra;
create procedure assegna_rimuovi_opera_in_mostra(in opera_id int, in mostra_id int)
begin
    if exists(select * from esposizioni where opera = opera_id and mostra = mostra_id) then
        delete from esposizioni where opera = opera_id and mostra = mostra_id;
    else
        insert into esposizioni values (mostra_id, opera_id);
    end if;
end;
call assegna_rimuovi_opera_in_mostra(@opera_id, @mostra_id);
update opere
set descrizione=@opera_descrizione,
    sala=@opera_sala
where id = @opera_id;


# op 37
set @dipendente_id = 2;
set @new_username = 'pippo69';
set @new_password = 'non_hashed_password';
update credenziali
set username=@new_username,
    password=md5(@new_password)
where Dipendente = @dipendente_id;


# op 40
set @dipendente_id = 7;
set @turno = 'martedi';
set @nuovo_orario_inizio = '09:00:00';
set @nuovo_orario_fine = '19:45:00';
update turni
set ora_inizio=@nuovo_orario_inizio,
    ora_fine=@nuovo_orario_fine
where dipendente = @dipendente_id
  and giorno = @turno
  and data_inizio = all (select rr.data_inizio
                         from ruoli_reali rr
                         where rr.dipendente = @dipendente_id
                           and rr.is_storico = false)