@app.route('/prestitiUtente', methods=['GET', 'POST']) 
def getResultsPage():

	# fetch parametri 
	if request.method == 'GET':
		idUtente = request.args['CF_IN']
		idBiblioteca = request.args['BIBLIOTECA_IN']
	if request.method == 'POST':
		idUtente = request.form['CF_IN']
		idBiblioteca = request.form['BIBLIOTECA_IN']

	# connessione al database 'X'
	with psycopg2.connect(host=myHost, database='X', user=myUsr, password=myPsw) as conn:
		with conn.cursor() as cur:

			# fetch da database di tutti i prestiti associati al CF nella biblioteca
			cur.execute('SELECT idRisorsa, dataInizio, durata FROM prestito WHERE idUtente=%s AND idBiblioteca=%s', (idUtente, idBiblioteca))
			results = list(cur)

			# ritorno risultato se la lista e' non vuota
			if !results:
				return render_template('nessunPrestitoOErrore.html')

			return render_template('view.html', results=results)