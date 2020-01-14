# programma Python che leggendo da console i dati inserisce una o piu tuple
# nella tabella RAGGIUNGE. Se un dato non e' valido, deve ri-chiederlo.
# Si visualizzi l'esito di ogni INSERT. Il programma deve suggerire i tipi
# di dato e deve essere protetto da SQL Injection

import psycopg2
from myConfig import myHost, myDb, myUsr, myPsw 

autostrada=''
comune=''
numeroCaselli=''
totalRows = 0
iteration = 's'

with psycopg2.connect(host=myHost, database=myDb, user=myUsr, password=myPsw) as conn:
	with conn.cursor() as cur:

		while (iteration == 's'):
			# richiesta e controllo su autostrada
			checking = True
			while(checking):
				autostrada = input("inserisci autostrada [sigla]: ")

				cur.execute('SELECT COUNT(*) FROM AUTOSTRADA WHERE codice=%s',(autostrada,))
				status = cur.fetchone()

				if status == None or status[0] < 1:
					print('Autostrada inserita non valida. Ripetere inserimento')
					continue
				else:
					checking = False

			# richiesta e controllo comune
			checking = True
			while(checking):
				comune = input("inserisci comune [codice ISTAT]: ")

				cur.execute('SELECT COUNT(*) FROM COMUNE WHERE codiceIstat=%s',(comune,))
				status = cur.fetchone()

				if status == None or status[0] < 1:
					print('codice ISTAT comune non valido. Ripetere inserimento')
					continue
				else:
					checking = False

			# richiesta e controllo numero caselli
			checking = True
			while(checking):
				numeroCaselli = input('Inserisci numero caselli (int): ')

				if int(numeroCaselli) < 0:
					print('numero inserito non valido, ripete inserimento')
					continue
				else:
					checking = False

			# parametri validi, eseguo inserimento
			cur.execute('''
				INSERT INTO raggiunge(autostrada, comune, numerocaselli)
				VALUES (%s,%s,%s)''', (autostrada, comune, numeroCaselli))

			# stampa esito
			print('Esito inserimento: ' + cur.statusmessage)
			totalRows += cur.rowCount

		iteration = 'Altro inserimento? [n/s] '


print('in questa sessione sono state inserite ' + str(totalRows) + 'righe')