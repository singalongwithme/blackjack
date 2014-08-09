class window.AppView extends Backbone.View

  template: _.template '
    <span class="buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="next-button">Next Hand</button></span>
    <div class="scoreResult"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()
      temp = @model.get('playerHand').bestScore()
      if @model.get('playerHand').bestScore() > 21
        $(".scoreResult").html('BUST! You lose.')
        $(".covered img").css "display", 'inline'
        $(".hit-button").css "display", 'none'
        $(".stand-button").css "display", 'none'
        $(".next-button").css "display", 'inline'

    "click .next-button": ->
      $(".scoreResult").html()
      $(".hit-button").css "display", 'inline'
      $(".stand-button").css "display", 'inline'
      $(".next-button").css "display", 'none'
      $(".covered img").css "display", 'none'

      @model.restart()
      @render()

    "click .stand-button": ->
      @model.get('dealerHand').models[0].flip()
      @model.get('dealerHand').stand()

      console.log("Dealer best: " + @model.get('dealerHand').bestScore())
      console.log("Player best: " + @model.get('playerHand').bestScore())

      $(".covered img").css "display", 'inline'
      $(".hit-button").css "display", 'none'
      $(".stand-button").css "display", 'none'
      $(".next-button").css "display", 'inline'


      playerScore = @model.get('playerHand').bestScore()
      dealerScore = @model.get('dealerHand').bestScore()
      if (playerScore > dealerScore && playerScore <= 21) || dealerScore > 21
        $(".scoreResult").html('You win.')
      else
        $(".scoreResult").html('You lose.')
      # handle if playerscore < dealerscore but dealerscore > 21

      ###
      if @model.get('dealerHand').bestScore >= @model.get('playerHand').bestScore
        console.log('you lost')
      else
        console.log('you win')###
      # turn these below back on to reset
      #@model.restart()
      #@render()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
