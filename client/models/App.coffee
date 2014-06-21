#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'winner', null
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # console.dir(@get('dealerHand'))
    @get('playerHand').on 'hit stand', () => @get('dealerHand').dealerChoice()
    @get('playerHand').on 'hit', () =>
      if @get('playerHand'.bust) == true then @set 'winner', @get 'dealerHand'
    @get('dealerHand').on 'hit', () =>
      if @get('dealerHand'.bust) == true then @set 'winner', @get 'playerHand'
    @get('dealerHand').on 'stand', () => @checkScores()

  checkScores: ->
    if @get('playerHand'.stood) and @get('dealerHand'.stood)
      if @get('playerHand').scores()[0] > @get('dealerHand'.dealerScore) then @set 'winner', @get 'playerHand'
      else @set 'winner', @get 'dealerHand'


