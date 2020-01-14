# la societa prevede di scontare le telefonate a determinati clienti
# facendo un update automatico ogni tot giorni delle durate

# inoltre, la societa azzera alcune telefonate che rispettano certi requisiti
# di durata, usando un'altra procedura ogni tot giorni

# simulo l'esecuzione concorrente. Qual e' il livello di isolamento minimo perche' 
# le due possano funzionare bene?


# LE DUE TRANSAZIONI POTREBBERO AVERE CIRCA QUESTA FORMA
#T1
BEGIN;
UPDATE telefonata SET durata = durata-(durata/2) WHERE contratto 
				IN (SELECT contratto FROM lista_contratti_persone_importanti);
COMMIT;

#T2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE telefonata SET durata = 0 WHERE durata > INTERVAL'45 min';
COMMIT;


Il controllo di durata nella seconda transazione potrebbe causare PHANTOM READ,
pertanto e opportuno impostare il livello di isolamento REPEATABLE READ a T2