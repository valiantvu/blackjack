#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'winner', null
    @set 'playerStood', false
    @set 'dealerStood', false
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # Event listeners

    @get('playerHand').on 'bust', () =>
      console.log('PLAYER BUST');
      @set 'winner', @

    @get('dealerHand').on 'bust', () =>
      console.log('DEALER BUST');
      @set 'winner', @

    @get('playerHand').on 'hit stand', () => @get('dealerHand').dealerChoice()

    @get('dealerHand').on 'stand', () =>
      @set 'dealerStood', true
      if @get 'playerStood' then @checkScores()

    @get('playerHand').on 'stand', () =>
      @set 'playerStood', true
      if @get 'dealerStood' then @checkScores()

  checkScores: ->
    playerMax = 0
    dealerMax = 0

    _.each @get('playerHand').scores(), (val) ->
      if val <= 21
        if val > playerMax then playerMax = val

    _.each @get('dealerHand').dealerScores(), (val) ->
      if val <= 21
        if val > dealerMax then dealerMax = val

    if dealerMax > playerMax then @set 'winner', @get 'dealerHand'
    else @set 'winner', @get 'playerHand'


