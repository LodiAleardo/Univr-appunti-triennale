# T1: aumenta del 5% il prezzo a tutti i prodotti dei negozi di Verona
# T2: abbassa del 10% il prezzo ai prodotti con prezzo >= 1050

# che tipo di errore puo' verificarsi nella concorrenza?
# che tipo di isolamento, per quale transazione, devo imporre per garantire 
# l'assenza di errori?

#T1
BEGIN;
	UPDATE listino 
	SET prezzo = prezzo + ((prezzo/100)*5) 
	WHERE negozio IN (SELECT codice FROM negozio WHERE citta='Verona');
COMMIT;

#T2
BEGIN TRANSACTION SET ISOLATION LEVEL REPEATABLE READ;
	UPDATE listino
	SET prezzo = prezzo - (prezzo/10) 
	WHERE prezzo >= 1050
COMMIT;

# Che tipo di errore si puo' verificare?
#
#	puo' accadere una situazione come segue (a sinistra il tempo)
#
# 	------------------PRODOTTO ------------------
# 	| IDPRODOTTO	| PREZZO 	| VENDUTO_A 	|
#	| 				| 			| 				|
#	| P1			| 1049 		| VERONA 		|
#	| P2 			| 1100 		| VERONA 		|
# 	| P3 			| 1200		| PADOVA		|	
# 	---------------------------------------------
#			
#		T1 										T2
#1 		BEGIN 									BEGIN
#	
#2 		SET RIGHE INTERESSATE:					SET RIGHE INTERESSATE:
#			{P1, P2} 								{P2, P3}
#
#3 		SET P1.prezzo = 1102					SET P2.prezzo = 1000
#		SET P2.prezzo = 1155 					SET P3.prezzo = 1080
#
#4 		COMMIT
#
#5												SEGNALE CHE IL SET E' STATO
#												MODIFICATO, CORREZIONE SNAPSHOT
#
#6												SET P2.prezzo = 1039
#
#7												COMMIT
######

# Il prezzo di P1, che avrebbe dovuto essere abbassato da T2, viene invece ignorato.
# Questo accade perche' le transazioni, in modalita' READ COMMITTED, vengono 
# "notificate" solo in caso di cambiamento da parte del commit di altre transazioni
# a RIGHE appartenenti al SET delle righe interessate dalla transazione stessa.
#
# P1, nonostante sia stata modificata e, dopo la modifica, il suo valore la avrebbe
# dovuta fare rientrare nel SET di righe modificabili da T2, era gia' stata ignorata.
#
# Un esempio simile si puo' trovare nella documentazione di postgresql sui livelli
# di isolamento, nel paragrafo dedicato alla READ COMMITTED.
######

# Il problema puo' essere risolto imponendo a T2 il livello di isolamento
# REPEATABLE READ: in tal modo, ogni comando interno a T2 fa fronte a una 
# istantanea della base di dati catturata al momento del BEGIN TRANSACTION.
######

BEGIN TRANSACTION SET ISOLATION LEVEL REPEATABLE READ;
	# T2
COMMIT;