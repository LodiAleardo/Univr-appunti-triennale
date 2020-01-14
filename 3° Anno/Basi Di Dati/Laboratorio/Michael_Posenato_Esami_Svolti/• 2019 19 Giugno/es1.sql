# VINCOLI DI INTEGRITA
SEZIONE.direttore -> RICERCATORE.codiceFiscale
RICERCATORE.sezApp -> SEZIONE.codice
PARTECIPA.ricercatore -> RICERCATORE.codiceFiscale
PARTECIPA.progetto -> PROGETO.codice 
PROGETTO.codRespProg -> RICERCATORE.codiceFiscale

# DOMINI
CREATE DOMAIN CODFISCALE AS VARCHAR(16) CHECK(
	VALUE SIMILAR TO '[A-Z]{6}[0-9]{2}[0-9]{2}[0-9]{3}[A-Z]');

# TABELLE
CREATE TABLE sezione(
	codice VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	direttore CODFISCALE NOT NULL
);

CREATE TABLE ricercatore(
	codiceFiscale CODFISCALE PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	cognome VARCHAR NOT NULL CHECK(cognome<>''),
	sezApp VARCHAR NOT NULL REFERENCES sezione
);

ALTER TABLE sezione ADD FOREIGN KEY(direttore) REFERENCES ricercatore DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE progetto(
	codice VARCHAR PRIMARY KEY,
	obiettivo VARCHAR NOT NULL CHECK(obiettivo<>''),
	codRespProg CODFISCALE NOT NULL REFERENCES ricercatore(codiceFiscale),
	dataInizio DATE NOT NULL,
	dataFine DATE NOT NULL CHECK(dataInizio < dataFine)
);

CREATE TABLE partecipa(
	ricercatore VARCHAR NOT NULL REFERENCES ricercatore(codiceFiscale),
	progetto VARCHAR NOT NULL REFERENCES progetto(codice),

	PRIMARY KEY(ricercatore, progetto)
);