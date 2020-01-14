# script che popoli SEZIONE e RICERCATORE con 1 sezione e 2 ricercatori che lavorano
# nella sezione, di cui 1 direttore della sezione
BEGIN;
INSERT INTO ricercatore(codicefiscale, nome, cognome, sezApp) VALUES
('GGGGGG95P27G642S', 'CARLO', 'NERI', 'SEZ_E'),
('HHHHHH95P27G642S', 'MARIA', 'VIOLA', 'SEZ_E');
INSERT INTO sezione(codice, nome, direttore) VALUES
('SEZ_E', 'LABORATORIO BELLO', 'GGGGGG95P27G642S');
COMMIT;

# script che cambia la sezione al direttore che dirige X e assegna
# un nuovo direttore alla sezione x
BEGIN;
UPDATE ricercatore SET sezApp=2 WHERE codiceFiscale IN (SELECT direttore FROM sezione WHERE codice='x');
UPDATE sezione SET direttore='HHHHHH95P27G642S' WHERE codice='x';
COMMIT;