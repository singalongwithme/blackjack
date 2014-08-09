class window.Card extends Backbone.Model

  initialize: (params) ->
    @set
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'King'
        when 1 then 'Ace'
        when 11 then 'Jack'
        when 12 then 'Queen'
        else params.rank
      image: switch params.rank
        when 0 then "img/cards/" + "king-" + ['spades', 'diamonds', 'clubs', 'hearts'][params.suit] + ".png"
        when 1 then "img/cards/" + "ace-" + ['spades', 'diamonds', 'clubs', 'hearts'][params.suit] + ".png"
        when 11 then "img/cards/" + "jack-" + ['spades', 'diamonds', 'clubs', 'hearts'][params.suit] + ".png"
        when 12 then "img/cards/" + "queen-" + ['spades', 'diamonds', 'clubs', 'hearts'][params.suit] + ".png"
        else "img/cards/" + params.rank + "-" + ['spades', 'diamonds', 'clubs', 'hearts'][params.suit] + ".png"


  flip: ->
    @set 'revealed', !@get 'revealed'
    @


