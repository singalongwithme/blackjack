class window.AppView extends Backbone.View

  template: _.template '
    <div class="buttons"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="next-button">Next Hand</button></div>
    <div class="scoreResult"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      @model.playerHit()

    "click .next-button": ->
      @resetCss

      @model.restart()
      @render()

    "click .stand-button": ->
      @model.get('dealerHand').stand()

      # console.log("Dealer best: " + @model.get('dealerHand').bestScore())
      # console.log("Player best: " + @model.get('playerHand').bestScore())

      $(".covered img").css "display", 'inline'
      $(".hit-button").css "display", 'none'
      $(".stand-button").css "display", 'none'
      $(".next-button").css "display", 'inline'

      @model.compare()

  initialize: ->
    @render()
    @model.on 'busted', => @bustCss console.log("")
    @model.on 'win', => @renderWin console.log("")
    @model.on 'lose', => @renderLose console.log("")

  renderWin: ->
    $(".scoreResult").html('You win.')

  renderLose: ->
    $(".scoreResult").html('You lose.')

  bustCss: ->
    $(".scoreResult").html('BUST! You lose.')
    $(".covered img").css "display", 'inline'
    $(".hit-button").css "display", 'none'
    $(".stand-button").css "display", 'none'
    $(".next-button").css "display", 'inline'

  resetCSS: ->
    $(".scoreResult").html()
    $(".hit-button").css "display", 'inline'
    $(".stand-button").css "display", 'inline'
    $(".next-button").css "display", 'none'
    $(".covered img").css "display", 'none'

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
