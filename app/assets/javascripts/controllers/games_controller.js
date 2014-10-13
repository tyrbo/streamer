App.GamesController = Ember.ArrayController.extend(EmberPusher.Bindings, {
  logPusherEvents: true,

  PUSHER_SUBSCRIPTIONS: {
    game: ['stats-event']
  },

  actions: {
    statsEvent: function(data) { console.log(data); }
  }
});
