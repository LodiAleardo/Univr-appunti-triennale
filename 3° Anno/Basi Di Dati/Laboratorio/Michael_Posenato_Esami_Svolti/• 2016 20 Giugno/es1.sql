# DOMINI E TABELLE DI SUPPORTO
CREATE TYPE REGIONE_ITA AS ENUM('Veneto', 'Puglia', 'Sardegna', 'Lombardia');
--etc etc

# TABELLE
CREATE TABLE ingrediente(
	id VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	calorie NUMERIC NOT NULL CHECK(calorie>0),
	grassi NUMERIC NOT NULL CHECK(grassi<100),
	proteine NUMERIC NOT NULL CHECK(proteine<100),
	carboidrati NUMERIC NOT NULL CHECK(carboidrati<100),

	CONSTRAINT totNutritionValue CHECK(
		grassi + proteine + carboidrati = 100)
);


CREATE TABLE ricetta(
	id VARCHAR PRIMARY KEY,
	nome VARCHAR NOT NULL CHECK(nome<>''),
	regione REGIONE_ITA NOT NULL,
	porzioni INTEGER NOT NULL CHECK(porzioni>0),
	tempoPreparazione INTEGER NOT NULL CHECK(tempoPreparazione>0)
);

CREATE TABLE composizione(
	ricetta VARCHAR REFERENCES ricetta,
	ingrediente VARCHAR REFERENCES ingrediente,
	quantita INTEGER NOT NULL CHECK(quantita>0),
	
	PRIMARY KEY(ricetta,ingrediente)
);