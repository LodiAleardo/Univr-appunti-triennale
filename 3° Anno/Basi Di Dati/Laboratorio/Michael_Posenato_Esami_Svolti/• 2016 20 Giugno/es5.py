# Programma python che si connette al db e, chiesta in input una regione, 
# visualizza a monitor il risultato della query dell'es 2.

import psycopg2
from myConfig import myH, myD, myU, myP

with psycop2.connect(host=myH, database=myD, user=myU, password=myP) as conn:
	with conn.cursor() as cur:

		# richiesta e check sulla regione
		checking = True;
		regione = ''

		while(checking):
			regione = input('Regione: ')

			cur.execute('SELECT COUNT(*) FROM ricetta WHERE regione=%s',(regione,))
			status = cur.fetchone()

			if status == None or status[0] <= 0:
				print('regione non esistente. ripetere inserimento')
				continue
			else:
				checking = False

		# regione valida, eseguo query
		cur.execute(''' 
			SELECT 	DISTINCT r.nome, r.tempoPreparazione
			FROM 	ricetta r 
					JOIN composizione c ON c.ricetta = r.id 
					JOIN ingrediente i ON c.ingrediente = i.id
			WHERE 	r.regione = %s
		AND i.carboidrati > 40; ''', (regione,))

		# stampa risultati
		for entry in list(cur):
			print(entry)