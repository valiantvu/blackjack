class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    @checkBust()
    if @isDealer
      @trigger 'dealerHit'
    else
      @trigger 'playerHit'

  stand: ->
    @trigger 'stand', @

  bust: ->
    @trigger 'bust', @

  dealerScores: ->
    score = _.map @scores(), ((val) ->
      val + @at(0).get 'value'), @

  dealerChoice: ->
    if (_.every @dealerScores(), (val) -> val < 17) then @hit()
    else @stand()

  checkBust: ->
    if @isDealer
      @bust() if _.every @dealerScores(), (val) -> val > 21
    else
      @bust() if _.every @scores(), (val) -> val > 21

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

