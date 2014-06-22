class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @model.on 'change:winner', => @renderWin()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html(@template(@model.get('attributes')))
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderWin: ->
    setTimeout (=>
      $('body').append('<div class="gameover"></div>')
      $('.gameover').append('<h1 class="winner">' + @model.get('winner') + '</h1>')), 1000



 # <% if (winner) { %><h1><%= winner %></h1><% } %>
