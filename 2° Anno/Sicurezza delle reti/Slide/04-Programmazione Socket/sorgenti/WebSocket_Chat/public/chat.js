
//Client

var name= prompt("What's your name?");
while(name==""){
    name=prompt("You have to choose a name. \n What's your name?")
}

// Query DOM
var message = document.getElementById('message'),
   sender = document.getElementById('sender'),
   btn = document.getElementById('send'),
   output = document.getElementById('output'),
   feedback = document.getElementById('feedback');

sender.innerHTML=name;  
sender.value=name;

// Invio richiesta di connessione al server
var webSocket = io.connect();

// Listen for events
btn.addEventListener('click', function(){
   if (message.value!="" ){    
 	   webSocket.emit('message', {
        message: message.value,
 	   sender: sender.value,
 	   });
 	   message.value = "";
   }
});

webSocket.on('UploadChat', function(data){
   feedback.innerHTML = '';
   output.innerHTML += '<p><strong>' + data.sender + ': </strong>' + data.message + '</p>';
});

