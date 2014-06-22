class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'playerHit', => @renderPlayer()
    @collection.on 'dealerHit', => @renderDealer()
    @render()

  render: ->
    # @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  renderPlayer: ->
    @$el.append new CardView(model: @collection.last()).$el
    @$('.score').text @collection.scores()[0]

  renderDealer: ->
    setTimeout (=> @$el.append new CardView(model: @collection.last()).$el), 1000
    @$('.score').text @collection.scores()[0]


