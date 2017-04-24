App.chat = App.cable.subscriptions.create({channel: "ChatChannel"}, {
  received: function(data) {
    // this is when data is received from the rails app
  }
});

// this is to send data to the rails app
App.chat.send({});