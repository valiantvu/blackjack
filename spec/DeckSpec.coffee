assert = chai.assert

describe 'deck', ->
  deck = null
  handPlayer = null
  handDealer = null

  beforeEach ->
    deck = new Deck()
    handPlayer = deck.dealPlayer()
    handDealer = deck.dealDealer()

  describe 'hit', ->
    it "should give the last card from the deck", ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), handPlayer.hit()
      assert.strictEqual deck.length, 47
      handPlayer.playable && (assert.strictEqual deck.last(), handPlayer.hit())
      handPlayer.playable && (assert.strictEqual deck.length, 46)

    it "should update stood boolean", ->
      handPlayer.hit()
      assert.strictEqual handPlayer.stood, false

    it "should update dealer score", ->
      oldScore = handDealer.dealerScore
      handDealer.hit()
      assert.notStrictEqual handDealer.dealerScore, oldScore

    it "should update playable", ->
      handPlayer.hit() for num in [0...10]
      assert.strictEqual handPlayer.playable, false

  describe 'stand', ->
    it "should update stood boolean", ->
      handPlayer.stand()
      assert.strictEqual handPlayer.stood, true

