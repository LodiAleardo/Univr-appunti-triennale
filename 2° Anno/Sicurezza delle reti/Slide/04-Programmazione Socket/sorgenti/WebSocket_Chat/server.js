
//Server

var express = require('express');
var socket = require('socket.io');

//Chat setup
var app = express();
// in questo momento il server è in attesa delle connessioni HTTP sulla porta 4000
var server = app.listen(4000, function(){
   console.log('waiting for HTTP requests on port 4000,');
});

// Static files
/*con questa funzione viene specificato a Nodejs che
una volta ricevuta una connessione deve andare a
cercare nella cartella public il file html da fornire
al client
*/
app.use(express.static('public'));

// Socket setup & pass server
/*una volta che la connessione è stata ricevuta qui
qui viene effettuato l'upgrade ad una connessione
websocket e il server si mette in attesa degli
eventi ai quali rispondere
*/
var io = socket(server);
io.on('connection', function(webSocket){

   console.log('made webSocket connection', webSocket.id);

   // Ricezione di un messaggio da inoltrare ai client
   webSocket.on('message', function(data){
       io.sockets.emit('UploadChat', data);
   });
});

