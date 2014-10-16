App.GamesController = Ember.ArrayController.extend(EmberPusher.Bindings, {
  logPusherEvents: true,

  PUSHER_SUBSCRIPTIONS: {
    game: ['stats-event']
  },

  actions: {
    statsEvent: function(data) {
      var game = this.get('liveGame')
      game.set('present', true);
      game.set('teams', data);
    },
    subscribe: function(game) {
      $.ajax({
        type: 'POST',
        url: '/api/v1/subscribe/' + game.id
      }).done(function(data) {
        if (data.status == "subscribed") {
          sweetAlert("Sweet!", "We'll let you know when the game gets started!\n\nYou can find a link to manage your notification preferences in your user menu.", "success");
        } else {
          sweetAlert("No problem.", "We'll no longer send you notifications about this game.", "success");
        }
      })
      .fail(function(data) {
        if (data.status == 401) {
          sweetAlert("Oops...", "You must be logged in to subscribe to games.\n\nTry clicking the 'Connect with Twitch' button first!", "error");
        } else if (data.status == 404) {
          sweetAlert("Oops...", "We weren't able to find the game you were looking for. :(");
        } else {
          sweetAlert(":(", "The site seems to be misbehaving.\nPerhaps you could refresh and try again?");
        }
      });
    }
  }
});
