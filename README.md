# MuseoOmero_Database
Progetto per la creazione di un database per il museo tattile Statale Omero (AN)

---

# Tesi completa -> [MuseoOmero_Database.pdf](https://github.com/MrPio/MuseoOmero_Database/files/11069638/MuseoOmero_Database.pdf)


## Analisi processi interni
![immagine](https://user-images.githubusercontent.com/22773005/227732562-5deb281b-4def-4423-8ed2-287b1f5a6d02.png)

## Diagramma Entity-Reletionship finale
![PartizionamentiAccorpamenti](https://user-images.githubusercontent.com/22773005/227732492-bef81bde-97f4-4cb4-b531-b7e6cad9131e.png)

## MySql

### Insert

```mysql
use museo_omero;

# op 1
use museo_omero;

# op 1
set @new_id = (select max(id)
               from visitatori) + 1;
insert into visitatori
values (@new_id, 'intero');
insert into informazioni_visitatori
values (@new_id, 'ITALIA', 'F', '1989-05-15');
insert into adesioni
values (26, @new_id);
update gruppi
set num_partecipanti = num_partecipanti + 1
where Id = 26;


# op 2
set @new_id = (select max(id)
               from visitatori) + 1;
insert into visitatori
values (@new_id, 'intero');
insert into clienti
values (@new_id, 'Francesco', 'Rivera', false, '+39 3658878774', 'frariv55@gmail.com');


# op 3
insert into biglietti(id, gruppo, evento, costo)
values ('AAB4', 6, 3, 40);


# op 4
insert into abbonamenti
values (73, current_timestamp, date_add(current_timestamp, interval 3 month), 18.90, 'trimestrale');


# op 5
insert into questionari(visitatore, tipologia_visita, accompagnatori_visita, motivazione_visita, titolo_studi,
                        numero_visite, ritorno, valutazione_visita, valutazione_esperienza, valutazione_struttura)
values (8, 'visita libera', 'famiglia', 'passare un momento personale piacevole', 'Diploma', 1, NULL, 10, 9, 7);


# op 6
set @id_event = (select max(id)
                 from eventi) + 1;
insert into eventi
values (@id_event, '2023/01/31 11:30:00');
insert into attivita
values (@id_event, false, 20);
insert into laboratori_reali
values (@id_event, 'Impronte', 1, 'A');


# op 7
set @id_event = (select max(id)
                 from eventi) + 1;
insert into eventi
values (@id_event, '2023/01/31 11:30:00');
insert into attivita
values (@id_event, true, 6);


# op 8
insert into opere(data, tipologia, descrizione, sala)
    value (current_date, 'Bassorilievo', 'Descrizione opera', 'sala');


# op 9
set @new_id = (select max(id)
               from eventi) + 1;
insert into eventi
    value (@new_id, '2023-01-06 16:30:00');
insert into mostre
    value (@new_id, 2, 'Ripercorri le strade dell\'antico impero romano!', 'Strade di Roma', 'Greco Romano', default,
           '2023-01-13 19:30:00');
insert into esposizioni
values (@new_id, 1),
       (@new_id, 2);

# op 10
insert into articoli
values ('La vita del Vasari', 'Ripercorri la vita di Giorgio Vasari in questa galleria fotografica!', 12, 8.90);


# op 11
set @new_id = (select max(id)
               from ordini) + 1;
insert into ordini
values (@new_id, current_timestamp, 17.80, false, 69);
insert into carrelli
values (@new_id, 'La vita del Vasari', 2)


# op 12
insert into prenotazioni
values (26, 5, current_timestamp);


# op 13
set @new_id = (select max(id)
               from gruppi) + 1;
insert into gruppi
values (@new_id, 3);
insert into adesioni (gruppo, visitatore)
values (@new_id, 88),
       (@new_id, 89),
       (@new_id, 90);


# op 14
set @new_id = (select max(id)
               from dipendentiè) + 1;
insert into dipendenti
values (@new_id, 'Maurizio', 'Del Monte', '1976-12-15', 'Ascoli Piceno', 'M', 'mauroodelmon88@gmail.com',
        '+39 (33) 8510 3', 'https://linkedin.com//851189', current_timestamp);


# op 15
insert into turni
values (23, '2023-01-08', 'lunedi', '08:30:00', '19:00:00');

```

### Read

```mysql
use museo_omero;

# op 16
select c.nome, c.cognome, a.data_rilascio, a.data_scadenza, a.tipologia, a.costo
from clienti as c
         left join abbonamenti as a on c.id = a.cliente
where c.id = 25;


# op 17
select *
from questionari
where data_compilazione = '2021-04-28';


# op 18
set @id_lab = 18;
select l.*, lr.piano, e.data_inizio, lr.stanza, sum(g.num_partecipanti) as numero_partecipanti, a.capienza
from laboratori_reali lr
         join laboratori l on l.nome = lr.laboratorio
         join attivita a on a.evento = lr.attivita
         join eventi e on e.id = lr.attivita
         left join prenotazioni p on lr.attivita = p.attivita
         join gruppi g on p.gruppo = g.Id
where lr.attivita = @id_lab
group by lr.attivita;


# op 19
set @giorno = '2021-01-01';
select e.data_inizio,
       a.capienza,
       coalesce(sum(g.num_partecipanti), 0)  as numero_prenotati,
       coalesce(sum(g2.num_partecipanti), 0) as numero_partecipanti_effettivi
from attivita a
         join eventi e on a.evento = e.id
         left join prenotazioni p on p.attivita = a.evento
         left join gruppi g on g.Id = p.gruppo
         left join biglietti b on a.evento = b.evento
         left join gruppi g2 on b.gruppo = g2.Id
where a.is_tour_guidato = true
  and date(e.data_inizio) = @giorno
group by e.id;


# op 20
SET @titolo = 'la voce, l''artista, il mito';

select c.*
from cataloghi c
where c.nome = @titolo;


# op 21
SET @start = '2021-11-11 0:0:0';
select p.data_prenotazione,
       a.is_tour_guidato,
       capienza,
       g.num_partecipanti,
       lr.laboratorio,
       piano,
       stanza
from prenotazioni p
         join gruppi g on p.gruppo = g.Id
         join attivita a on p.attivita = a.evento
         left join laboratori_reali lr on p.attivita = lr.attivita
where p.data_prenotazione >= @start
  and p.data_prenotazione < DATE_ADD(@start, INTERVAL 1 WEEK);


# op 22
select t.*
from turni as t,
     ruoli_reali as r
where r.data_inizio = t.data_inizio
  and r.dipendente = t.dipendente
  and r.is_storico = false
  and t.dipendente = 7;


# op 23
select e.id,
       m.titolo,
       m.descrizione,
       m.artista,
       m.tema,
       m.num_opere,
       e.data_inizio as inizio,
       m.data_fine   as fine
from eventi as e,
     mostre as m
where e.id = m.evento;


# op 24
SET @id_opera = 2;
select opera.data,
       opera.tipologia,
       opera.descrizione,
       opera.sala,
       originale.titolo,
       originale.is_interna,
       originale.città,
       originale.altezza,
       originale.larghezza,
       originale.profondità,
       originale.periodo_storico,
       c.numero,
       is_calco,
       scala,
       originale,
       originale_della_copia.titolo as titolo_originale_copia,
       originale_della_copia.is_interna as is_interna_originale_copia,
       originale_della_copia.città as citta_originale_copia,
       originale_della_copia.altezza as alt_originale_copia,
       originale_della_copia.larghezza as lar_originale_copia,
       originale_della_copia.profondità as prof_originale_copia,
       originale_della_copia.periodo_storico as ps_originale_copia,
       ma.is_smontabile,
       is_pieno,
       opera_originale.data,
       opera_originale.tipologia,
       opera_originale.descrizione,
       opera_originale.sala

from opere opera
         left join copie c on opera.id = c.id
         join originali originale_della_copia on c.originale = originale_della_copia.id
         join opere opera_originale on originale_della_copia.id = opera_originale.id
         left join modelli_architettonici ma on c.id = ma.copia
         left join originali originale on opera.id = originale.id

where opera.id = @id_opera;


# op 25
SET @id_artista = '2';
select o.data,
       tipologia,
       descrizione,
       sala,
       o1.titolo,
       is_interna,
       città,
       altezza,
       larghezza,
       profondità,
       periodo_storico
from autori a
         join realizzazioni r on a.id = r.artista
         join opere o on r.opera = o.id
         join originali o1 on o.id = o1.id
where a.id = @id_artista;


# op 26
select *
from clienti as c
where c.id = 10;


# op 27
select c.disabilita, count(c.visitatore) as quantita
from certificati as c
group by c.disabilita
order by quantita desc;


# op 28
select a.*,
       count(a.id) numero_opere_create
from artisti a
         left join realizzazioni r on a.id = r.artista
group by a.id
order by numero_opere_create desc;


# op 29
SET @start_ordini = '2021-01-05 0:0:0';
SET @end_ordini = '2021-09-07 0:0:0';
SET @id_cliente = '10';
select o.data, costo, is_spedito
from ordini o
where o.cliente = @id_cliente
  and o.data >= @start_ordini
  and o.data < @end_ordini;


# op 30
select v.*, count(ve.opera) as vendute
from venditori as v
         join clienti as c on v.nome = c.nome and v.cognome = c.cognome
         join abbonamenti as a on c.id = a.cliente
         left join vendite as ve on v.id = ve.venditore
where a.data_scadenza >= '2021-1-1'
group by v.id;


# op 31
select avg(DATE_FORMAT(FROM_DAYS(DATEDIFF(e.data_inizio, '2001-05-09')), '%Y') + 0) as media
from visitatori as v,
     informazioni_visitatori as inf,
     questionari as q,
     adesioni as a,
     gruppi as g,
     biglietti as b,
     mostre as m,
     eventi as e

where v.id = inf.visitatore
  and v.id = q.visitatore
  and v.id = a.visitatore
  and a.gruppo = g.Id
  and g.Id = b.gruppo
  and b.evento = m.evento
  and e.id = m.evento;



# op 32
create view cataloghi_piu_venduti(catalogo, vendite_totali) as
select catalogo, sum(quantita) as vendite_totali
from (select c.nome as catalogo, co.quantita as quantita
      from cataloghi c
               left join contenuti co on c.nome = co.articolo
      union all
      select c.nome, ca.quantita
      from cataloghi c
               left join carrelli ca on c.nome = ca.catalogo) as vendite_ordini
group by catalogo
order by vendite_totali desc;
select cpv.*, numero_pag, rilegatura
from cataloghi_piu_venduti as cpv
         join cataloghi c on cpv.catalogo = c.nome;


# op 33
SET @mese = '2021-05-01';
select sum(ricavo) incassi_totali
from (select sum(s.costo) as ricavo
      from scontrini s
      where s.data >= @mese
        and s.data < DATE_ADD(@mese, INTERVAL 1 MONTH)

      union all
      select sum(o.costo) as ricavo
      from ordini o
      where o.data >= @mese
        and o.data < DATE_ADD(@mese, INTERVAL 1 MONTH)

      union all
      select sum(b.costo) as ricavo
      from biglietti b
      where b.data_stampa >= @mese
        and b.data_stampa < DATE_ADD(@mese, INTERVAL 1 MONTH)) as acquisti_del_mese;
```

### Update

```mysql
use museo_omero;

# op 34
update articoli
set disponibilita = disponibilita - 1
where nome = 'benda';


# op 35
update abbonamenti
set data_rilascio = now(),
    data_scadenza = ADDDATE(current_date, INTERVAL 1 month),
    tipologia     = 'mensile',
    costo         = 10.00
where cliente = 2;


# op 36
set @opera_id = 1;
set @opera_descrizione =
        '“Il Partenone racchiude un’armonica sintesi di utilità, solidità e piacevolezza”, Vitruvio da “De Architectura”.';
set @opera_sala = ' Greco e Romano';
set @mostra_id = 19;
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


# op 38
update ruoli_reali
set reparto = 'UfficioProgettazione'
where dipendente = 9
  and is_storico = false;


# op 39
update eventi
set data_inizio = '2023-01-13'
where id = 3;


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
```

### Delete

```mysql
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

```
