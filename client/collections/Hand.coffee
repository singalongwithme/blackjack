class window.Hand extends Backbone.Collection

  model: Card

  bestScore: ->
  # get scores array, check if scores' length = 1
    # set bestscore to array[0]
    # else, loop through array and check for best
    # number less than 21

    temp = @scores()
    if temp.length is 1
      return temp[0]
    else
      highest = temp[0]
      i = 0
      while i < temp.length
        highest = temp[i]  if temp[i] > highest and temp[i] <= 21
        i++
      return highest

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()

  stand: ->
    if @bestScore() < 17
      @hit()
      @stand()

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
