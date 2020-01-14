# Programma python che da console legga tuple composte di (nomeConvegno, nomeSessione, idIntervento, orarioInizio) e inserisca una o piu tuple nella tabella 
# INTERVENTO_IN_CONVEGNO. Soliti accorgimenti, vincoli e controlli

import psycopg2
from myConfig import myHost, myDatabase, myUser, myPassword
from datetime import time

iteration = s;
while(iteration == s):
	with psycopg2.connect(host=myHost, database=myDatabase, user=myUser, password=myPassword) as conn:
		with conn.cursor() as cur:

			# verifica validita su nomeConvegno
			checking = True
			nomeConvegno = ''
			while(checking):
				nomeConvegno = input('inserisci nomeConvegno: ')
				cur.execute('SELECT COUNT(*) FROM convegno WHERE nome=%s',(nomeConvegno,))
				status = cur.fetchone();

				if status == None or status[0] != 1:
					print('nomeConvegno inserito non valido. riprovare')
					continue
				else:
					checking = False

			# verifica validita su nomeSessione
			checking = True
			nomeSessione = ''
			while(checking):
				nomeSessione = input('inserisci nomeSessione: ')
				cur.execute('SELECT COUNT(*) FROM sessione WHERE nome=%s',(nomeSessione,))
				status = cur.fetchone();

				if status == None or status[0] != 1:
					print('nomeSessione inserito non valido. riprovare')
					continue
				else:
					checking = False

			# verifica idIntervento
			checking = True
			idIntervento = ''
			while(checking):
				idIntervento = input('inserisci idIntervento: ')
				cur.execute('SELECT COUNT(*) FROM intervento WHERE ID=%s',(idIntervento,))
				status = cur.fetchone()

				if status == None or status[0] != 1:
					print('idSessione inserito non valido. riprovare')
					continue
				else:
					checking = False

			# verifica orarioInizio
			checking = True
			orarioInizio = ''
			while(checking):
				orarioInizio = input('inserisci orarioInizio: ')
				orarioInizio = datetime.strptime(orarioInizio, '%H:%M:%S')

				cur.execute('SELECT orarioInizio, orarioFine FROM sessione WHERE nomeSessione=? AND nomeConvegno=?',(nomeSessione, nomeConvegno))
				lowerLimit, upperLimit = cur.fetchone()

				if orarioInizio > lowerLimit and orarioInizio < upperLimit:
					checking = False
				else:
					print('Orario inserito non valido. riprovare.')
					continue

			# condizioni verificate, effettuo insert:
			cur.execute('''
				BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
				INSERT INTO INTERVENTO_IN_CONVEGNO(nomeConvegno, idIntervento, nomeSessione, orarioInizio) VALUES(?,?,?,?);
				COMMIT;
				''',(nomeConvegno, idIntervento, nomeSessione, orarioInizio))

			print('esito inserimento: ', cur.statusmessage)

	iteration = ('Vuoi inserire un altro intervento? [s/n]')