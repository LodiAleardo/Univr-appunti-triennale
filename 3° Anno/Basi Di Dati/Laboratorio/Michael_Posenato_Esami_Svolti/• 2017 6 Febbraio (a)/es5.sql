# quanti indici sono stati usati?

# nope. non sono stati usanti indici. Non appaiono in nessun luogo
# INDEX SCAN, INDEX COND, o simili diciture che suggerirebbero l'utilizzo
# di indici da parte del query planner



# in base al piano di esecuzione, conviene creare degli indici?

# nope, JOIN e selezioni sono fatte utilizzando solo attributi chiave,
# pertanto gli indici necessari sono gia' stati creati. Il fatto che 
# il query planner preferisca non usarli indica probabilmente che 
# il subset di tuple del risultato e' sufficientemente grande da giustificare
# una scansione sequenziale della tabella TUT_T (che, in ogni caso, e'
# molto piccola in un contesto reale) e di esercizio (non cosi' fornita rispetto
# al numero di esercizi in ogni programma, evidentemente, se il query planner
# decide di scorrerla piuttosto che usare l'indice che postgres ha creato 
# sul suo identificatore)