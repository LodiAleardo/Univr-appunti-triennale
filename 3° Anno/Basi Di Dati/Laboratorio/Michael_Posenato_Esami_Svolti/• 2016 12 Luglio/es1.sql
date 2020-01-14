# RELAZIONI MANCANTI:
CREATE TABLE ospedale(
	id VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>'')
);

# VINCOLI DI CHIAVE ESTERNA:
DIVISIONE.idOspedale -> OSPEDALE.id 
RICOVERO.divisione -> DIVISIONE.id
RICOVERO.paziente -> PAZIENTE.coficeFiscale

# DOMINI / TABELLE DI SUPPORTO
CREATE DOMAIN CF_ITA AS VARCHAR(16) CHECK(
	VALUE SIMILAR TO '[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]');

CREATE TYPE REG_ITA AS ENUM('Veneto', 'Abruzzo', 'Sicilia', 'Calabria', 'Lombardia');
-- e le altre, non ho voglia di scriverle tutte tbh

# TABELLE
CREATE TABLE paziente(
	codiceFiscale CF_ITA PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	cognome VARCHAR NOT NULL CHECK(cognome<>''),
	regione REG_ITA NOT NULL,
	nazione VARCHAR NOT NULL CHECK(nazione SIMILAR TO '[A-Z]{3}')
);

CREATE TABLE divisione(
	id VARCHAR PRIMARY KEY,
	idOspedale VARCHAR NOT NULL REFERENCES ospedale,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	numeroAddetti INTEGER NOT NULL CHECK(numeroAddetti>=0) -- ipotizzando divisioni neonate a cui non e' ancora stato assegnato personale
);

CREATE TABLE ricovero(
	divisione VARCHAR NOT NULL REFERENCES divisione,
	paziente CF_ITA NOT NULL REFERENCES paziente,
	descrizione VARCHAR NOT NULL CHECK(descrizione<>''),
	urgenza VARCHAR NOT NULL CHECK(urgenza<>''), -- oppure sistema a codici colore: bianco, verde, giallo, rosso
	dataAmmissione DATE NOT NULL,
	dataDimissione DATE NOT NULL CHECK(dataAmmissione <= dataDimissione),

	PRIMARY KEY(divisione, paziente, dataAmmissione, dataDimissione)
);