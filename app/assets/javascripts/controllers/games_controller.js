App.GamesController = Ember.ObjectController.extend(EmberPusher.Bindings, {
  logPusherEvents: true,
  PUSHER_SUBSCRIPTIONS: {
    game: ['stats-event', 'pusher:subscription_succeeded']
  },
  actions: {
    'pusher:subscriptionSucceeded': function() {
      console.log('Connected');
    },
    statsEvent: function(data) { console.log(data); }
  }
});
