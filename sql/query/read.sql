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
  and t.dipendente = 10;


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
where a.data_scadenza >= current_date
group by ve.venditore;


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




