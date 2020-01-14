# DOMINI E TABELLE DI SUPPORTO
CREATE DOMAIN TARGA_ITA AS VARCHAR(8)
	CHECK(VALUE SIMILAR TO '[A-Z]{2}[0-9]{3}[A-Z]{2}');

CREATE DOMAIN PATENTE_ITA AS VARCHAR
	CHECK(VALUE SIMILAR TO '[A-Z][0-9][A-Z][0-9]{6}[A-Z]');

# si potrebbero fare ENUM o tabelle di supporto per auto.marca, auto.modello,
# e cliente.paeseProvenienza

# TABELLE
CREATE TABLE auto(
	targa TARGA_ITA PRIMARY KEY,
	marca VARCHAR NOT NULL CHECK(marca<>''),
	modello VARCHAR NOT NULL CHECK(modello<>''),
	posti INTEGER NOT NULL CHECK(posti>0),
	cilindrata INTEGER NOT NULL CHECK(cilindrata>0)
);

CREATE TABLE cliente(
	nPatente PATENTE_ITA PRIMARY KEY,
	cognome VARCHAR NOT NULL CHECK(cognome<>''),
	nome VARCHAR NOT NULL CHECK(nome<>''),
	paeseProvenienza VARCHAR NOT NULL CHECK(paeseProvenienza<>''),
	nInfrazioni INTEGER NOT NULL CHECK(nInfrazioni>=0) DEFAULT 0
);

CREATE TABLE noleggio(
	targa TARGA_ITA REFERENCES auto,
	cliente PATENTE_ITA REFERENCES cliente,
	inizio TIMESTAMP NOT NULL,
	fine TIMESTAMP CHECK(inizio<fine),

	PRIMARY KEY(targa, cliente, inizio)
);