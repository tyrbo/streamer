App.GamesRoute = Ember.Route.extend({
  model: function() {
    return this.get('store').find('game');
  }
});
