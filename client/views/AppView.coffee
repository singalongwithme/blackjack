class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()
      if @model.get('playerHand').bestScore > 21
        @model.get('dealerHand').models[0].flip()
        console.log('GG')

    "click .stand-button": ->
      @model.get('playerHand').stand()
      @model.get('dealerHand').models[0].flip()
      @model.get('dealerHand').dealerHit()
      if @model.get('dealerHand').bestScore >= @model.get('playerHand').bestScore
        console.log('you lost')
      else
        console.log('you win')
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
