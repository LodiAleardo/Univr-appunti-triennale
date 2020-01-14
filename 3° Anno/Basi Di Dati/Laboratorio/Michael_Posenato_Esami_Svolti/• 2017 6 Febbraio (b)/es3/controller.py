''' metodo Py che legge i parametri inviati in richiesta GET/POST, 
	usi il metodo model.Clienti(citta,data) per fornire il risultato della query,
	corregga tutti i cognomi per renderli maiuscoli e usi render_template
	per ritornare un template html con il risultato. Se la lista ritornata e'
	vuota, ritorno 'erroreParametri.html' 	'''

@app.route('/telefonateCittaData', methods=['POST','GET'])
def telefonateCittaData():
	
	# fetch dei parametri
	if request.method == 'GET':
		data = request.args['data_in']
		citta = request.args['citta_in']
	if request.method == 'POST':
		data = request.form['data_in']
		citta = request.form['citta_in']

	# conversione del datatype per data e chiamata a funzione per i risultati
	data = datetime.strptime(data, '%d/%m/%Y').date()
	results = model.Clienti(citta, data)

	# controllo sul riempimento della lista
	if not results:
		return render_template('erroreParametri.html')
	
	# cognomi in maiuscolo
	for cliente in lista:
		cliente['cognome'] = cliente['cognome'].upper()

	# ritorno il risultato
	return render_template('view.html', lista=results, citta=citta, data=data)