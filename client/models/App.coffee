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
      console.log('BUST');
      @set 'winner', @

    @get('dealerHand').on 'bust', () =>
      @set 'winner', @

    @get('playerHand').on 'hit stand', () => @get('dealerHand').dealerChoice()

    @get('dealerHand').on 'stand', () =>
      @set 'dealerStood', true
      if @get 'playerStood' then @checkScores()

    @get('playerHand').on 'stand', () =>
      @set 'playerStood', true
      if @get 'dealerStood' then @checkScores()

  checkScores: ->
    if @get('playerHand').scores()[0] > @get('dealerHand'.dealerScores()) then @set 'winner', @get 'playerHand'
    else @set 'winner', @get 'dealerHand'


