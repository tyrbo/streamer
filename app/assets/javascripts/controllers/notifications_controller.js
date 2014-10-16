App.NotificationsController = Ember.Controller.extend({
  actions: {
    notifyGameStart: function() {
      console.log('got game start');
    },
    notifyGameEnd: function() {
      console.log('got game end');
    }
  }
});
