function adjustChatHeight() {
  var chat = document.getElementById('chat');
  var chatStyle = window.getComputedStyle(chat);
  var chatMessages = chat.getElementsByTagName('ul')[0];
  var messageForm = document.getElementById('create-message-form');
  var messageFormStyle = window.getComputedStyle(messageForm);

  var messageInput = document.getElementById('message_content');
  messageInput.style.height = 'auto';
  messageInput.style.height = (messageInput.scrollHeight + 2) + 'px';
  
  chatMessages.style.height = (parseInt(chatStyle.height) - parseInt(messageFormStyle.height)) + 'px';
}

function subscribeToChannel(chat) {
  App.chat = App.cable.subscriptions.create({channel: "ChatChannel", match_id: chat.dataset.matchid }, {
    received: function(data) {
      var chatMessages = chat.getElementsByTagName('ul')[0];

      if (data.sent_by === +chat.dataset.selfid) {
        chatMessages.innerHTML += '<li class="self"><div class="message-body">' + data.content + '</div></li>';
      } else if (data.sent_by === +chat.dataset.otherid) {
        chatMessages.innerHTML += '<li class="other"><div class="message-body">' + data.content + '</div></li>';
      }

      var messageInput = document.getElementById('message_content');
      messageInput.value = '';
      chatMessages.scrollTop = chatMessages.scrollHeight;
    }
  });

  return App.chat;
}

document.addEventListener('turbolinks:load', function() {
  var chat = document.getElementById('chat');
  
  // Subscribe to stream, and send text when form is submitted
  if (window.location.pathname.substr(0, 9) === '/matches/') {
    App.chat = subscribeToChannel(chat);

    // this is to send data to the rails app
    var messageForm = document.getElementById('create-message-form');
    messageForm.addEventListener('submit', function(e) {
      e.preventDefault();
      var messageContent = document.getElementById('message_content').value;
      
      if (messageContent !== '') {
        App.chat.send({sent_by: chat.dataset.selfid, content: messageContent});
      }
      return false;
    });
    
    // initial adjust + adjust height on input change
    adjustChatHeight();
    var messageInput = document.getElementById('message_content');
    messageInput.addEventListener('keydown', function() {
      adjustChatHeight();
    });

    // scroll all the way to the bottom of the chat
    var chatMessages = chat.getElementsByTagName('ul')[0];
    chatMessages.scrollTop = chatMessages.scrollHeight;
  }
});