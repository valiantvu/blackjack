class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @set 'stood', false
    # @set 'bust', false
    @set 'dealerScore', 0

  hit: ->
    @set 'stood', false
    console.log(@scores()[0] + @at(0).get 'value')
    @set 'dealerScore', (@scores()[0] + @at(0).get 'value')
    # if @isDealer
    #   if @get 'dealerScore' > 21 then @set 'bust', true
    # else
    #   if @scores() > 21 then @set 'bust', true
    @trigger 'hit'
    # console.log(@scores())
    @add(@deck.pop()).last()

  stand: ->
    @trigger 'stand', @
    @set 'stood', true

  dealerChoice: ->
    console.log('hi')
    if @get 'dealerScore' >= 17 then @stand()
    else @hit()

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

