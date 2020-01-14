# vincoli di integrita' referenziale
NEGOZIO.citta -> CITTA.nome 
PRODOTTO.marca -> MARCA.nome 
LISTINO.prodotto -> PRODOTTO.codice
LISTINO.negozio -> NEGOZIO.codice

# generazione tabelle SENZA vincoli di integrita' referenziale
CREATE TABLE citta(
	nome VARCHAR PRIMARY KEY
);

CREATE TABLE marca(
 	nome VARCHAR PRIMARY KEY
);

CREATE TABLE prodotto(
	codice VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	marca VARCHAR NOT NULL
);

CREATE TABLE negozio(
	codice VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	citta VARCHAR NOT NULL
);

CREATE TABLE listino(
	negozio VARCHAR NOT NULL,
	prodotto VARCHAR NOT NULL,
	prezzo NUMERIC NOT NULL CHECK(prezzo>0),

	PRIMARY KEY(negozio, prodotto)
);

# vincoli di integrita' referenziale
ALTER TABLE negozio ADD FOREIGN KEY(citta) REFERENCES citta;
ALTER TABLE prodotto ADD FOREIGN KEY(marca) REFERENCES marca;
ALTER TABLE listino ADD FOREIGN KEY(negozio) REFERENCES negozio;
ALTER TABLE listino ADD FOREIGN KEY(prodotto) REFERENCES prodotto;