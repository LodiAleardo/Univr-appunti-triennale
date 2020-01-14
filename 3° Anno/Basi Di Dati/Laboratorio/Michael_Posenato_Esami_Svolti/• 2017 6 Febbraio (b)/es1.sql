# VINCOLI DI INTEGRITA REFERENZIALE
TELEFONATA.contratto -> CONTRATTO 
CONTRATTO.cliente -> CLIENTE 
CLIENTE.citta -> CITTA 
TELEFONATA.nTelChiamato -> CLIENTE.nTelefono

# DOMINI E TABELLE DI SUPPORTO
CREATE DOMAIN NUMTELEFONO AS VARCHAR(11)
	CHECK(VALUE SIMILAR TO '[+][0-9]{1,2}[0-9]{10}');
	-- formato da +(1-2 cifre prefisso internazionale)(10 cifre del numero)

CREATE TABLE tipoContratto(
	tipo VARCHAR PRIMARY KEY );
INSERT INTO tipoContratto VALUES('privato', 'business', 'corporate');

CREATE DOMAIN CODFISCALE AS VARCHAR(16)
	CHECK(VALUE SIMILAR TO '[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]');

# TABELLE
CREATE TABLE citta(
	codice VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>'')	
);

CREATE TABLE cliente(
	codice CODFISCALE PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	cognome VARCHAR NOT NULL CHECK(cognome<>''),
	nTelefono NUMTELEFONO UNIQUE NOT NULL, -- ragionevolmente lo pongo UNIQUE includendo il prefisso internazionale
	indirizzo VARCHAR NOT NULL CHECK(indirizzo<>''),
	citta VARCHAR NOT NULL REFERENCES citta
);

CREATE TABLE contratto(
	contratto VARCHAR PRIMARY KEY,
	cliente CODFISCALE NOT NULL REFERENCES cliente,
	tipo VARCHAR NOT NULL REFERENCES tipoContratto,
	dataInizio DATE NOT NULL,
	dataFine DATE CHECK(dataInizio < dataFine)
);

CREATE TABLE telefonata(
	contratto VARCHAR NOT NULL REFERENCES contratto,
	nTelChiamato NUMTELEFONO NOT NULL REFERENCES cliente(nTelefono),
	istanteInizio TIMESTAMP NOT NULL,
	durata INTERVAL NOT NULL CHECK(durata > INTERVAL'0 sec'),

	PRIMARY KEY(contratto, nTelChiamato, istanteInizio)
);

