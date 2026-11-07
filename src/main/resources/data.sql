-- =====================================================================
-- Dati di esempio per SIW Festival.
--
-- Gli INSERT sono idempotenti (WHERE NOT EXISTS): lo script gira a ogni
-- avvio (spring.sql.init.mode=always) senza duplicare nulla.
-- Le password sono cifrate con BCrypt: admin/admin, mario/mario, luca/luca.
-- =====================================================================

-- ---------------------------------------------------------------------
-- UTENTI E CREDENZIALI
-- ---------------------------------------------------------------------
INSERT INTO users (id, name, surname, email)
SELECT nextval('users_seq'), 'Admin', 'Festival', 'admin@siw.it'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@siw.it');

INSERT INTO users (id, name, surname, email)
SELECT nextval('users_seq'), 'Mario', 'Rossi', 'mario@siw.it'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'mario@siw.it');

INSERT INTO users (id, name, surname, email)
SELECT nextval('users_seq'), 'Luca', 'Bianchi', 'luca@siw.it'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'luca@siw.it');

INSERT INTO credentials (id, username, password, role, user_id)
SELECT nextval('credentials_seq'), 'admin',
       '$2b$10$XcM5.tpht48Fwx3DkHPZe.3CohIc/tyB0Jz/ixjNwCL.dnBmK0YM.', 'ADMIN', id
FROM users WHERE email = 'admin@siw.it'
AND NOT EXISTS (SELECT 1 FROM credentials WHERE username = 'admin');

INSERT INTO credentials (id, username, password, role, user_id)
SELECT nextval('credentials_seq'), 'mario',
       '$2b$10$rz3Jm1W/XEG8mx9Wh3ATsO.aWlw1XRNSK1YedeKtTs9XI9Bp/TxH.', 'DEFAULT', id
FROM users WHERE email = 'mario@siw.it'
AND NOT EXISTS (SELECT 1 FROM credentials WHERE username = 'mario');

INSERT INTO credentials (id, username, password, role, user_id)
SELECT nextval('credentials_seq'), 'luca',
       '$2b$10$BdApzqbnw6Lf1f0TEIchrO5w2bzpm2apvav27QlXDM0MDZDoqDu0C', 'DEFAULT', id
FROM users WHERE email = 'luca@siw.it'
AND NOT EXISTS (SELECT 1 FROM credentials WHERE username = 'luca');

-- ---------------------------------------------------------------------
-- ATTORI
-- ---------------------------------------------------------------------
INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Toni', 'Servillo', DATE '1959-01-25', 'Italiana'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Toni' AND cognome = 'Servillo');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Carlo', 'Verdone', DATE '1950-11-17', 'Italiana'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Carlo' AND cognome = 'Verdone');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Luisa', 'Ranieri', DATE '1973-12-16', 'Italiana'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Luisa' AND cognome = 'Ranieri');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Alba', 'Rohrwacher', DATE '1979-02-27', 'Italiana'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Alba' AND cognome = 'Rohrwacher');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Monica', 'Bellucci', DATE '1964-09-30', 'Italiana'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Monica' AND cognome = 'Bellucci');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Josh', 'O''Connor', DATE '1990-05-20', 'Britannica'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Josh' AND cognome = 'O''Connor');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Amy', 'Adams', DATE '1974-08-20', 'Statunitense'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Amy' AND cognome = 'Adams');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Jeremy', 'Renner', DATE '1971-01-07', 'Statunitense'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Jeremy' AND cognome = 'Renner');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Timothee', 'Chalamet', DATE '1995-12-27', 'Statunitense'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Timothee' AND cognome = 'Chalamet');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Zendaya', 'Coleman', DATE '1996-09-01', 'Statunitense'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Zendaya' AND cognome = 'Coleman');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Saoirse', 'Ronan', DATE '1994-04-12', 'Irlandese'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Saoirse' AND cognome = 'Ronan');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Florence', 'Pugh', DATE '1996-01-03', 'Britannica'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Florence' AND cognome = 'Pugh');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Rumi', 'Hiiragi', DATE '1987-08-01', 'Giapponese'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Rumi' AND cognome = 'Hiiragi');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Miyu', 'Irino', DATE '1988-02-19', 'Giapponese'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Miyu' AND cognome = 'Irino');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Masaki', 'Suda', DATE '1993-02-21', 'Giapponese'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Masaki' AND cognome = 'Suda');

INSERT INTO attore (id, nome, cognome, data_nascita, nazionalita)
SELECT nextval('attore_seq'), 'Takuya', 'Kimura', DATE '1972-11-13', 'Giapponese'
WHERE NOT EXISTS (SELECT 1 FROM attore WHERE nome = 'Takuya' AND cognome = 'Kimura');

-- ---------------------------------------------------------------------
-- SALE
-- ---------------------------------------------------------------------
INSERT INTO sala (id, nome, indirizzo, capienza)
SELECT nextval('sala_seq'), 'Sala Fellini', 'Via Tuscolana 1055, Roma', 320
WHERE NOT EXISTS (SELECT 1 FROM sala WHERE nome = 'Sala Fellini');

INSERT INTO sala (id, nome, indirizzo, capienza)
SELECT nextval('sala_seq'), 'Sala Visconti', 'Via Ostiense 106, Roma', 180
WHERE NOT EXISTS (SELECT 1 FROM sala WHERE nome = 'Sala Visconti');

INSERT INTO sala (id, nome, indirizzo, capienza)
SELECT nextval('sala_seq'), 'Sala Antonioni', 'Piazza Verdi 8, Bologna', 140
WHERE NOT EXISTS (SELECT 1 FROM sala WHERE nome = 'Sala Antonioni');

INSERT INTO sala (id, nome, indirizzo, capienza)
SELECT nextval('sala_seq'), 'Arena Estiva', 'Parco della Musica, Torino', 500
WHERE NOT EXISTS (SELECT 1 FROM sala WHERE nome = 'Arena Estiva');

-- ---------------------------------------------------------------------
-- FILM
-- ---------------------------------------------------------------------
INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'La Grande Bellezza', 2013, 141, 'DRAMMATICO', 'Italia'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'La Grande Bellezza' AND anno = 2013);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'E stata la mano di Dio', 2021, 130, 'DRAMMATICO', 'Italia'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'E stata la mano di Dio' AND anno = 2021);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'Le Meraviglie', 2014, 111, 'DRAMMATICO', 'Italia'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'Le Meraviglie' AND anno = 2014);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'La Chimera', 2023, 130, 'DRAMMATICO', 'Italia'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'La Chimera' AND anno = 2023);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'Arrival', 2016, 116, 'FANTASCIENZA', 'Stati Uniti'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'Arrival' AND anno = 2016);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'Dune', 2021, 155, 'FANTASCIENZA', 'Stati Uniti'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'Dune' AND anno = 2021);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'Lady Bird', 2017, 94, 'COMMEDIA', 'Stati Uniti'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'Lady Bird' AND anno = 2017);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'Piccole Donne', 2019, 135, 'DRAMMATICO', 'Stati Uniti'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'Piccole Donne' AND anno = 2019);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'La Citta Incantata', 2001, 125, 'ANIMAZIONE', 'Giappone'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'La Citta Incantata' AND anno = 2001);

INSERT INTO film (id, titolo, anno, durata, genere, paese_produzione)
SELECT nextval('film_seq'), 'Il Ragazzo e lAirone', 2023, 124, 'ANIMAZIONE', 'Giappone'
WHERE NOT EXISTS (SELECT 1 FROM film WHERE titolo = 'Il Ragazzo e lAirone' AND anno = 2023);

-- ---------------------------------------------------------------------
-- INTERPRETAZIONI (cast dei film: attore + personaggio interpretato)
-- Al massimo una interpretazione per (film, attore): il vincolo di unicita'
-- uk_interpretazione_film_attore lo garantisce anche a livello di database.
-- ---------------------------------------------------------------------
INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Jep Gambardella', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'La Grande Bellezza' AND f.anno = 2013 AND a.nome = 'Toni' AND a.cognome = 'Servillo'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Romano', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'La Grande Bellezza' AND f.anno = 2013 AND a.nome = 'Carlo' AND a.cognome = 'Verdone'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Saverio Schisa', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'E stata la mano di Dio' AND f.anno = 2021 AND a.nome = 'Toni' AND a.cognome = 'Servillo'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Patrizia', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'E stata la mano di Dio' AND f.anno = 2021 AND a.nome = 'Luisa' AND a.cognome = 'Ranieri'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Angelica', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Le Meraviglie' AND f.anno = 2014 AND a.nome = 'Alba' AND a.cognome = 'Rohrwacher'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Milly Catena', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Le Meraviglie' AND f.anno = 2014 AND a.nome = 'Monica' AND a.cognome = 'Bellucci'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Arthur', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'La Chimera' AND f.anno = 2023 AND a.nome = 'Josh' AND a.cognome = 'O''Connor'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Spartaco', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'La Chimera' AND f.anno = 2023 AND a.nome = 'Alba' AND a.cognome = 'Rohrwacher'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Louise Banks', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Arrival' AND f.anno = 2016 AND a.nome = 'Amy' AND a.cognome = 'Adams'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Ian Donnelly', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Arrival' AND f.anno = 2016 AND a.nome = 'Jeremy' AND a.cognome = 'Renner'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Paul Atreides', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Dune' AND f.anno = 2021 AND a.nome = 'Timothee' AND a.cognome = 'Chalamet'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Chani', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Dune' AND f.anno = 2021 AND a.nome = 'Zendaya' AND a.cognome = 'Coleman'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Christine Lady Bird McPherson', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Lady Bird' AND f.anno = 2017 AND a.nome = 'Saoirse' AND a.cognome = 'Ronan'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Kyle Scheible', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Lady Bird' AND f.anno = 2017 AND a.nome = 'Timothee' AND a.cognome = 'Chalamet'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Jo March', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Piccole Donne' AND f.anno = 2019 AND a.nome = 'Saoirse' AND a.cognome = 'Ronan'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Amy March', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Piccole Donne' AND f.anno = 2019 AND a.nome = 'Florence' AND a.cognome = 'Pugh'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Laurie', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Piccole Donne' AND f.anno = 2019 AND a.nome = 'Timothee' AND a.cognome = 'Chalamet'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Chihiro Ogino', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'La Citta Incantata' AND f.anno = 2001 AND a.nome = 'Rumi' AND a.cognome = 'Hiiragi'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Haku', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'La Citta Incantata' AND f.anno = 2001 AND a.nome = 'Miyu' AND a.cognome = 'Irino'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Airone cenerino', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Il Ragazzo e lAirone' AND f.anno = 2023 AND a.nome = 'Masaki' AND a.cognome = 'Suda'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

INSERT INTO interpretazione (id, personaggio, film_id, attore_id)
SELECT nextval('interpretazione_seq'), 'Shoichi Maki', f.id, a.id
FROM film f, attore a
WHERE f.titolo = 'Il Ragazzo e lAirone' AND f.anno = 2023 AND a.nome = 'Takuya' AND a.cognome = 'Kimura'
AND NOT EXISTS (SELECT 1 FROM interpretazione i WHERE i.film_id = f.id AND i.attore_id = a.id);

-- ---------------------------------------------------------------------
-- FESTIVAL
-- ---------------------------------------------------------------------
INSERT INTO festival (id, nome, anno, citta, data_inizio, data_fine, descrizione)
SELECT nextval('festival_seq'), 'Roma Film Fest', 2026, 'Roma',
       DATE '2026-10-15', DATE '2026-10-25',
       'Rassegna internazionale dedicata al cinema d autore, con proiezioni in tre sale storiche della citta.'
WHERE NOT EXISTS (SELECT 1 FROM festival WHERE nome = 'Roma Film Fest' AND anno = 2026);

INSERT INTO festival (id, nome, anno, citta, data_inizio, data_fine, descrizione)
SELECT nextval('festival_seq'), 'Bologna Cinema Ritrovato', 2026, 'Bologna',
       DATE '2026-06-20', DATE '2026-06-28',
       'Festival dedicato ai restauri e alle riscoperte, con una sezione competitiva per il cinema di animazione.'
WHERE NOT EXISTS (SELECT 1 FROM festival WHERE nome = 'Bologna Cinema Ritrovato' AND anno = 2026);

INSERT INTO festival (id, nome, anno, citta, data_inizio, data_fine, descrizione)
SELECT nextval('festival_seq'), 'Torino Sci-Fi Days', 2026, 'Torino',
       DATE '2026-07-03', DATE '2026-07-08',
       'Cinque giorni di fantascienza sotto le stelle, con proiezioni serali all Arena Estiva.'
WHERE NOT EXISTS (SELECT 1 FROM festival WHERE nome = 'Torino Sci-Fi Days' AND anno = 2026);

-- ---------------------------------------------------------------------
-- ASSOCIAZIONE FILM - FESTIVAL (molti-a-molti)
-- ---------------------------------------------------------------------
INSERT INTO festival_film (festival_id, film_id)
SELECT f.id, m.id
FROM festival f, film m
WHERE f.nome = 'Roma Film Fest' AND f.anno = 2026
  AND m.titolo IN ('La Grande Bellezza', 'E stata la mano di Dio', 'La Chimera', 'Piccole Donne')
  AND NOT EXISTS (SELECT 1 FROM festival_film ff WHERE ff.festival_id = f.id AND ff.film_id = m.id);

INSERT INTO festival_film (festival_id, film_id)
SELECT f.id, m.id
FROM festival f, film m
WHERE f.nome = 'Bologna Cinema Ritrovato' AND f.anno = 2026
  AND m.titolo IN ('La Citta Incantata', 'Il Ragazzo e lAirone', 'Le Meraviglie', 'Lady Bird')
  AND NOT EXISTS (SELECT 1 FROM festival_film ff WHERE ff.festival_id = f.id AND ff.film_id = m.id);

INSERT INTO festival_film (festival_id, film_id)
SELECT f.id, m.id
FROM festival f, film m
WHERE f.nome = 'Torino Sci-Fi Days' AND f.anno = 2026
  AND m.titolo IN ('Arrival', 'Dune', 'Il Ragazzo e lAirone')
  AND NOT EXISTS (SELECT 1 FROM festival_film ff WHERE ff.festival_id = f.id AND ff.film_id = m.id);

-- ---------------------------------------------------------------------
-- PROIEZIONI
-- Nessuna sovrapposizione nella stessa sala: gli orari tengono conto della
-- durata dei film, esattamente come fa il controllo in ProiezioneService.
-- ---------------------------------------------------------------------

-- Roma Film Fest 2026
INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-10-16', TIME '18:00', 'SCHEDULED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Roma Film Fest' AND m.titolo = 'La Grande Bellezza' AND s.nome = 'Sala Fellini'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-10-16' AND p.ora = TIME '18:00');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-10-16', TIME '21:00', 'SCHEDULED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Roma Film Fest' AND m.titolo = 'E stata la mano di Dio' AND s.nome = 'Sala Fellini'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-10-16' AND p.ora = TIME '21:00');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-10-17', TIME '17:30', 'SCHEDULED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Roma Film Fest' AND m.titolo = 'La Chimera' AND s.nome = 'Sala Visconti'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-10-17' AND p.ora = TIME '17:30');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-10-17', TIME '20:30', 'SCHEDULED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Roma Film Fest' AND m.titolo = 'Piccole Donne' AND s.nome = 'Sala Visconti'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-10-17' AND p.ora = TIME '20:30');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-10-18', TIME '19:00', 'CANCELLED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Roma Film Fest' AND m.titolo = 'La Chimera' AND s.nome = 'Sala Fellini'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-10-18' AND p.ora = TIME '19:00');

-- Bologna Cinema Ritrovato 2026
INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-06-21', TIME '16:00', 'COMPLETED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Bologna Cinema Ritrovato' AND m.titolo = 'La Citta Incantata' AND s.nome = 'Sala Antonioni'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-06-21' AND p.ora = TIME '16:00');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-06-21', TIME '19:00', 'COMPLETED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Bologna Cinema Ritrovato' AND m.titolo = 'Il Ragazzo e lAirone' AND s.nome = 'Sala Antonioni'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-06-21' AND p.ora = TIME '19:00');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-06-22', TIME '17:00', 'COMPLETED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Bologna Cinema Ritrovato' AND m.titolo = 'Le Meraviglie' AND s.nome = 'Sala Antonioni'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-06-22' AND p.ora = TIME '17:00');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-06-22', TIME '20:00', 'COMPLETED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Bologna Cinema Ritrovato' AND m.titolo = 'Lady Bird' AND s.nome = 'Sala Antonioni'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-06-22' AND p.ora = TIME '20:00');

-- Torino Sci-Fi Days 2026
INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-07-04', TIME '21:00', 'COMPLETED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Torino Sci-Fi Days' AND m.titolo = 'Arrival' AND s.nome = 'Arena Estiva'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-07-04' AND p.ora = TIME '21:00');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-07-05', TIME '21:00', 'COMPLETED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Torino Sci-Fi Days' AND m.titolo = 'Dune' AND s.nome = 'Arena Estiva'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-07-05' AND p.ora = TIME '21:00');

INSERT INTO proiezione (id, data, ora, stato, festival_id, film_id, sala_id)
SELECT nextval('proiezione_seq'), DATE '2026-07-06', TIME '21:00', 'COMPLETED', f.id, m.id, s.id
FROM festival f, film m, sala s
WHERE f.nome = 'Torino Sci-Fi Days' AND m.titolo = 'Il Ragazzo e lAirone' AND s.nome = 'Arena Estiva'
AND NOT EXISTS (SELECT 1 FROM proiezione p WHERE p.festival_id = f.id AND p.film_id = m.id
                AND p.data = DATE '2026-07-06' AND p.ora = TIME '21:00');

-- ---------------------------------------------------------------------
-- RECENSIONI
-- Al massimo una recensione per (utente, film): il vincolo di unicita'
-- uk_recensione_film_autore lo garantisce anche a livello di database.
-- ---------------------------------------------------------------------
INSERT INTO recensione (id, testo, voto, data, autore_id, film_id)
SELECT nextval('recensione_seq'),
       'Un affresco malinconico e barocco su Roma. La fotografia da sola vale il biglietto.',
       9, TIMESTAMP '2026-07-01 10:15:00', u.id, m.id
FROM users u, film m
WHERE u.email = 'mario@siw.it' AND m.titolo = 'La Grande Bellezza'
AND NOT EXISTS (SELECT 1 FROM recensione r WHERE r.autore_id = u.id AND r.film_id = m.id);

INSERT INTO recensione (id, testo, voto, data, autore_id, film_id)
SELECT nextval('recensione_seq'),
       'Bellissimo da guardare ma un po troppo lungo nella parte centrale.',
       7, TIMESTAMP '2026-07-02 18:40:00', u.id, m.id
FROM users u, film m
WHERE u.email = 'luca@siw.it' AND m.titolo = 'La Grande Bellezza'
AND NOT EXISTS (SELECT 1 FROM recensione r WHERE r.autore_id = u.id AND r.film_id = m.id);

INSERT INTO recensione (id, testo, voto, data, autore_id, film_id)
SELECT nextval('recensione_seq'),
       'Fantascienza che sceglie il linguaggio invece delle esplosioni. Finale memorabile.',
       10, TIMESTAMP '2026-07-05 23:30:00', u.id, m.id
FROM users u, film m
WHERE u.email = 'mario@siw.it' AND m.titolo = 'Arrival'
AND NOT EXISTS (SELECT 1 FROM recensione r WHERE r.autore_id = u.id AND r.film_id = m.id);

INSERT INTO recensione (id, testo, voto, data, autore_id, film_id)
SELECT nextval('recensione_seq'),
       'Visivamente imponente, ma e chiaramente meta di una storia.',
       8, TIMESTAMP '2026-07-06 09:05:00', u.id, m.id
FROM users u, film m
WHERE u.email = 'luca@siw.it' AND m.titolo = 'Dune'
AND NOT EXISTS (SELECT 1 FROM recensione r WHERE r.autore_id = u.id AND r.film_id = m.id);

INSERT INTO recensione (id, testo, voto, data, autore_id, film_id)
SELECT nextval('recensione_seq'),
       'Un classico che regge benissimo alla riproiezione in sala. Da vedere almeno una volta al cinema.',
       10, TIMESTAMP '2026-06-22 08:00:00', u.id, m.id
FROM users u, film m
WHERE u.email = 'mario@siw.it' AND m.titolo = 'La Citta Incantata'
AND NOT EXISTS (SELECT 1 FROM recensione r WHERE r.autore_id = u.id AND r.film_id = m.id);

INSERT INTO recensione (id, testo, voto, data, autore_id, film_id)
SELECT nextval('recensione_seq'),
       'Commedia asciutta e sincera, con una protagonista scritta molto bene.',
       8, TIMESTAMP '2026-06-23 21:10:00', u.id, m.id
FROM users u, film m
WHERE u.email = 'luca@siw.it' AND m.titolo = 'Lady Bird'
AND NOT EXISTS (SELECT 1 FROM recensione r WHERE r.autore_id = u.id AND r.film_id = m.id);
