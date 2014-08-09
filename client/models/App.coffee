#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  restart: ->
    temp = @get('deck')
    @set 'playerHand', temp.dealPlayer()
    @set 'dealerHand', temp.dealDealer()

  playerHit: ->
    @get('playerHand').hit()
    @playerCheck()

  playerCheck: ->
    temp = @get('playerHand').bestScore()
    if temp > 21
      @trigger 'busted'

  compare: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    if (playerScore > dealerScore && playerScore <= 21) || dealerScore > 21
      @trigger 'win'
    else
      @trigger 'lose'
