# domini / tabelle ausiliarie
CREATE DOMAIN CODFISCALE AS VARCHAR(16) CHECK(
	VALUE SIMILAR TO '[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]');

CREATE DOMAIN NUMTELEFONO AS VARCHAR(11) CHECK(
	VALUE SIMILAR TO '[+][0-9]{10}');

CREATE TYPE STATOUTENTE AS ENUM('abilitato', 'ammonito', 'sospeso');

CREATE TABLE TIPORISORSA(tipo VARCHAR PRIMARY KEY);
INSERT INTO TIPORISORSA VALUES ('libro'), ('rivista');

CREATE TYPE STATORISORSA AS ENUM('solo consultazione', 'on-line', 'disponibile');

# vincoli di integrita'
PRESTITO.(idRisorsa, idBibilioteca) -> RISORSA(id, biblioteca)
PRESTITO.idUtente -> UTENTE.id 
RISORSA.Biblioteca -> BIBLIOTECA.id 
RISORSA.tipo -> TIPORISORSA.tipo

# tabelle
CREATE TABLE biblioteca(
	id VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>'')
);

CREATE TABLE utente(
	codiceFiscale CODFISCALE PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	cognome VARCHAR NOT NULL CHECK(cognome<>''),
	telefono NUMTELEFONO NOT NULL,
	dataIscrizione DATE NOT NULL,
	stato STATOUTENTE NOT NULL
);

CREATE TABLE risorsa(
	id VARCHAR,
	biblioteca VARCHAR REFERENCES biblioteca,
	titolo VARCHAR NOT NULL CHECK(titolo <>''),
	tipo VARCHAR NOT NULL REFERENCES TIPORISORSA,
	stato STATORISORSA NOT NULL,

	PRIMARY KEY(id, biblioteca)
);

CREATE TABLE prestito(
	idRisorsa VARCHAR NOT NULL,
	idBiblioteca VARCHAR NOT NULL,
	idUtente CODFISCALE NOT NULL REFERENCES utente,
	dataInizio DATE NOT NULL,
	durata INTERVAL NOT NULL CHECK(durata > '00:00:00'::INTERVAL),

	FOREIGN KEY(idRisorsa, idBiblioteca) REFERENCES risorsa(id,biblioteca),
	PRIMARY KEY(idRisorsa, idBiblioteca, idUtente, dataInizio)
);

