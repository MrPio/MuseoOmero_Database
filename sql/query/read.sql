use museo_omero;

# op 20
SET @titolo = 'la voce, l''artista, il mito';

select a.*, scontrini + carrelli as acquisti_totali
from (select min(SumCo) as scontrini,
             sum(Ca)    as carrelli
      from (select sum(co.quantita)       as SumCo,
                   any_value(ca.quantita) as Ca

            from articoli a
                     left join cataloghi c on a.nome = c.nome
                     left join contenuti co on a.nome = co.articolo
                     left join carrelli ca on a.nome = ca.catalogo

            where a.nome = @titolo

            group by ca.ordine) as SCC) as SCC2,
     articoli a
where a.nome = @titolo;


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
       originale_della_copia.titolo,
       originale_della_copia.is_interna,
       originale_della_copia.città,
       originale_della_copia.altezza,
       originale_della_copia.larghezza,
       originale_della_copia.profondità,
       originale_della_copia.periodo_storico,
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


# op 28
select a.*,
       count(a.id) numero_opere_create
from artisti a
         left join realizzazioni r on a.id = r.artista
group by a.id
order by numero_opere_create desc;


# op 29
SET @start_ordini = '2021-06-05 0:0:0';
SET @end_ordini = '2021-06-07 0:0:0';
SET @id_cliente = '10';
select o.data, costo, is_spedito
from ordini o
where o.cliente = @id_cliente
  and o.data >= @start_ordini
  and o.data < @end_ordini;


# op 33
SET @mese = '2021-05-01';

# create view vendite_articoli(nome, prezzo, vendite_in_presenza, vendite_online) as
/*select nome, prezzo, any_value(coTot), sum(caTot)
from (select a_nome nome, a_prezzo prezzo, sum(co_quantita) as coTot, any_value(ca_quantita) as caTot
      from (select co.quantita as co_quantita,
                   ca.quantita as ca_quantita,
                   a.nome      as a_nome,
                   a.prezzo    as a_prezzo,
                   ca.ordine   as ca_ordine
            from articoli as a
                     left join carrelli as ca on a.nome = ca.catalogo
                     join ordini as o
                          on ca.ordine = o.id and o.data >= @mese and
                             o.data < date_add(@mese, INTERVAL 1 MONTH)
                     left join contenuti as co on a.nome = co.articolo
                     left join scontrini s
                          on co.scontrino = s.id and s.data >= @mese and
                             s.data < date_add(@mese, INTERVAL 1 MONTH)
            union all
            select co.quantita as co_quantita,
                   ca.quantita as ca_quantita,
                   a.nome      as a_nome,
                   a.prezzo    as a_prezzo,
                   ca.ordine   as ca_ordine
            from articoli as a
                     left join carrelli as ca on a.nome = ca.catalogo
                     join ordini as o
                          on ca.ordine = o.id and o.data >= @mese and
                             o.data < date_add(@mese, INTERVAL 1 MONTH)
                     right join contenuti as co on a.nome = co.articolo
                     join scontrini s
                          on co.scontrino = s.id and s.data >= @mese and
                             s.data < date_add(@mese, INTERVAL 1 MONTH)) as A


      group by a_nome, ca_ordine) as A
group by nome;*/
/*
select *
from vendite_articoli;

select (va.vendite_in_presenza + coalesce(vendite_online, 0)) * va.prezzo as incassi_totali
from vendite_articoli as va;*/


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




