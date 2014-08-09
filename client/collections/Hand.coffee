class window.Hand extends Backbone.Collection

  model: Card

  bestScore: 0

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    @setScore()
    ###
    console.log(@scores())
    @bestScore = @scores()[0]
    if @scores()[0] > 21
      @stand()
      @trigger('compare')###

  stand: ->
    #@bestScore = @scores()[0]

  dealerHit: ->
    @stand()
    if @bestScore < 17
      @hit()
      @dealerHit()

    @trigger('compare')

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
