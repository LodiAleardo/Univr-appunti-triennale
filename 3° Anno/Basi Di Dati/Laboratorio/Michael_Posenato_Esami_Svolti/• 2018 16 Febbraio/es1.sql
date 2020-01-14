# DOMINI / TABELLE DI SUPPORTO
CREATE TYPE TIPOCONVEGNO AS ENUM('seminario', 'simposio', 'conferenza');

# TABELLE
CREATE TABLE convegno (
	nome VARCHAR PRIMARY KEY,
	dataInizio DATE NOT NULL,
	dataFine DATE NOT NULL CHECK(dataFine>dataInizio));
	numeroSessioni INTEGER NOT NULL CHECK(numeroSessioni>0);
	tipo TIPOCONVEGNO NOT NULL,
	luogo VARCHAR NOT NULL CHECK(luogo<>'')
);

CREATE TABLE intervento(
	id VARCHAR PRIMARY KEY,
	titolo VARCHAR NOT NULL CHECK(titolo<>''),
	relatore VARCHAR NOT NULL CHECK(relatore<>''),
	durata INTERVAL NOT NULL CHECK(durata>INTERVAL'0 sec')
);

CREATE TABLE sessione(
	nome VARCHAR,
	nomeConvegno VARCHAR REFERENCES convegno,
	data DATE NOT NULL,
	orarioInizio TIME NOT NULL,	--Uso TIME in quanto il giorno e' gia' specificato dall'attributo 'data'
	orarioFine TIME NOT NULL CHECK(orarioFine > orarioInizio),

	PRIMARY KEY(nome, nomeConvegno)
);

CREATE TABLE intervento_in_convegno(
	nomeConvegno VARCHAR REFERENCES convegno,
	idIntervento VARCHAR REFERENCES intervento,
	nomeSessione VARCHAR REFERENCES sessione,
	orarioInizio TIME NOT NULL, --essendo l'orario di inizio all'interno della sessione, la data e' quella della sessione

	PRIMARY KEY(nomeConvegno, idIntervento, nomeSessione)
);

