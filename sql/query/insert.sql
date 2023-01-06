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
