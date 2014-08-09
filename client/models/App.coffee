#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  events = {'compare': -> do @compare}

  compare: ->
    console.log("here");
    @get('playerHand').bestScore > @get('dealerHand').bestScore

