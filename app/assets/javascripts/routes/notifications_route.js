App.NotificationsRoute = Ember.Route.extend({
  model: function() {
    if (window.user_id) {
      return this.get('store').find('user', window.user_id);
    } else {
      return null
    }
  },
});
