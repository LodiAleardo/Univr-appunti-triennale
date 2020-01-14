# vincoli di integrita
RAGGIUNGE.autostrada -> AUTOSTRADA.codice
RAGGIUNGE.comune -> COMUNE.codiceISTAT

# generazione tabelle
CREATE TABLE autostrada(
	codice VARCHAR PRIMARY KEY CHECK(codice SIMILAR TO 'A[0-9]+'),
	nome VARCHAR NOT NULL CHECK(nome<>''),
	gestore VARCHAR NOT NULL CHECK(gestore<>''),
	lunghezza NUMERIC(7,3) NOT NULL CHECK(lunghezza > 0)
);

CREATE TABLE comune(
	codiceISTAT VARCHAR PRIMARY KEY CHECK(codiceISTAT SIMILAR TO '[0-9]{6}'),
	nome VARCHAR NOT NULL CHECK(nome<>''),
	numeroAbitanti INTEGER NOT NULL CHECK(numeroAbitanti > 0),
	superficie NUMERIC(7,3) NOT NULL CHECK(superficie > 0)
);

CREATE TABLE raggiunge(
	autostrada VARCHAR REFERENCES autostrada,
	comune VARCHAR REFERENCES comune,
	numeroCaselli INTEGER NOT NULL CHECK(numeroCaselli>=0),
	PRIMARY KEY(autostrada, comune)	
);