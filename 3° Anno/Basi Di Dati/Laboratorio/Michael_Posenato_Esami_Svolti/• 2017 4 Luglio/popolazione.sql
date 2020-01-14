# almeno 1 utente con prestiti presso 2 biblioteche
# e almeno 1 utente con 2 prestiti presso la stessa biblioteca
# ogni dudo ha 1 prestito terminato a oggi, e uno no

INSERT INTO biblioteca VALUES
('BIB_SMRTA', 'biblioteca Santa Marta'),
('BIB_FRNZI', 'biblioteca Frinzi'),
('BIB_CIVIC', 'biblioteca Civica Verona');

INSERT INTO risorsa VALUES
('PLAT_REP', 'BIB_SMRTA', 'Repubblica', 'libro', 'disponibile'),
('PLAT_SIM', 'BIB_SMRTA', 'Simposio', 'libro', 'disponibile'),
('PLAT_GOR', 'BIB_FRNZI', 'Gorgia', 'libro', 'disponibile'),
('PLAT_PRO', 'BIB_FRNZI', 'Protagora', 'libro', 'disponibile'),
('PLAT_APO', 'BIB_CIVIC', 'Apologia di Socrate', 'libro', 'disponibile'),
('PLAT_CRI', 'BIB_CIVIC', 'Crizia', 'libro', 'disponibile');

INSERT INTO utente VALUES
('AAAAAA11B22C333D', 'Mario', 'Rossi', '+3334034955', '2017-01-01', 'abilitato'),
('BBBBBB11B22C333D', 'Luigi', 'Rossi', '+3331234955', '2016-02-01', 'abilitato'),
('CCCCCC11B22C333D', 'Carlo', 'Verdi', '+3334034123', '2016-03-01', 'abilitato'),
('DDDDDD11B22C333D', 'Franco', 'Verdi', '+3334012355', '2017-04-01', 'abilitato'),
('EEEEEE11B22C333D', 'Dario', 'Bianchi', '+3312344955', '2017-05-01', 'abilitato');

INSERT INTO prestito VALUES
('PLAT_REP', 'BIB_SMRTA', 'AAAAAA11B22C333D', '2018-01-01', INTERVAL'1 month'),
('PLAT_GOR', 'BIB_FRNZI', 'AAAAAA11B22C333D', '2018-01-01', INTERVAL'1 month'),
('PLAT_APO', 'BIB_CIVIC', 'AAAAAA11B22C333D', '2019-08-25', INTERVAL'3 months'),
('PLAT_APO', 'BIB_CIVIC', 'AAAAAA11B22C333D', '2019-08-27', INTERVAL'8 days'),
('PLAT_REP', 'BIB_SMRTA', 'BBBBBB11B22C333D', '2017-01-01', INTERVAL'6 months'),
('PLAT_SIM', 'BIB_SMRTA', 'BBBBBB11B22C333D', '2019-08-25', INTERVAL'3 months'),
('PLAT_APO', 'BIB_CIVIC', 'CCCCCC11B22C333D', '2018-01-01', INTERVAL'2 months'),
('PLAT_REP', 'BIB_SMRTA', 'CCCCCC11B22C333D', '2019-08-25', INTERVAL'7 months'),
('PLAT_CRI', 'BIB_CIVIC', 'DDDDDD11B22C333D', '2019-08-25', INTERVAL'8 days'),
('PLAT_REP', 'BIB_SMRTA', 'BBBBBB11B22C333D', '2017-04-02', INTERVAL'1 week'),
('PLAT_REP', 'BIB_SMRTA', 'BBBBBB11B22C333D', '2017-05-01', INTERVAL'1 day'),
('PLAT_REP', 'BIB_SMRTA', 'EEEEEE11B22C333D', '2016-08-25', INTERVAL'18 months'),
('PLAT_GOR', 'BIB_FRNZI', 'BBBBBB11B22C333D', '2018-01-01', INTERVAL'1 day'),
('PLAT_GOR', 'BIB_FRNZI', 'BBBBBB11B22C333D', '2018-03-01', INTERVAL'1 day');
