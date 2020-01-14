# domini e tabelle di supporto
CREATE TYPE LIVELLO_T AS ENUM('principiante', 'intermedio', 'avanzato');
CREATE TYPE GM_T AS ENUM('petto', 'schiena', 'spalle', 'braccia', 'gambe');
CREATE TYPE GIORNO_T AS ENUM('LUN', 'MAR', 'MER', 'GIO', 'VEN', 'SAB', 'DOM');

# tabella per tempo esecuzione (concentrico + pausa, eccentrico + pausa)
CREATE TABLE TEMPO_T(
	id 			VARCHAR PRIMARY KEY,
	ecc_mov 	INTEGER NOT NULL CHECK(ecc_mov>=0),
	ecc_pos 	INTEGER NOT NULL CHECK(ecc_pos>=0),
	conc_mov 	INTEGER NOT NULL CHECK(conc_mov>=0),
	conc_pos 	INTEGER NOT NULL CHECK(conc_pos>=0)
);

# tabelle principali
CREATE TABLE esercizio(
	nome 			VARCHAR PRIMARY KEY,
	livello 		LIVELLO_T NOT NULL,
	gruppoMuscolare GM_T NOT NULL
);

CREATE TABLE programma(
	nome 	VARCHAR PRIMARY KEY,
	livello LIVELLO_T NOT NULL
);

CREATE TABLE esercizio_in_programma(
	nomeProgramma 	VARCHAR NOT NULL REFERENCES programma,
	nomeEsercizio 	VARCHAR NOT NULL REFERENCES esercizio,
	giorno 			GIORNO_T NOT NULL,
	ordine 			INTEGER NOT NULL CHECK(ordine>0),
	serie 			INTEGER NOT NULL CHECK(serie>0),
	ripetizioni 	INTEGER NOT NULL CHECK(ripetizioni>0),
	TUT 			VARCHAR NOT NULL REFERENCES TEMPO_T,
	riposo 			INTEGER NOT NULL CHECK(riposo>=0),

	PRIMARY KEY(nomeProgramma,giorno,nomeEsercizio)
);