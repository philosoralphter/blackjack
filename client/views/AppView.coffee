class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    #"click .stand-button": -> @model.get('playerHand').stand()
    "click .stand-button": -> @model.get('dealerHand').dealerDecide()
    # "bust": -> @model.get('playerHand').bust()



  initialize: ->
    @render()
    @model.get('playerHand' ).on( "result", @renderResult, @)
    @model.get('playerHand' ).on( "bust", @renderBust, @)
    @model.get('playerHand' ).on( "push", @renderPush, @)
    @model.get('playerHand' ).on( "win", @renderWin, @)
    @model.get('playerHand' ).on( "lose", @renderLose, @)
    @model.get('dealerHand' ).on( "determineWinner", @model.determineWinner)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderResult: ->
    console.log('Rendering result')
    @$('button.hit-button').prop('disabled','true')
    @$('button.stand-button').prop('disabled','true')
    @$('.player-hand-container').addClass 'result'

  renderBust: ->
    console.log('rendering bust')
    @$('.result').prepend('<p class = "bust">You Just Busted</p>')

  renderPush: ->
    console.log('rendering push')
    @$('.result').prepend('<p class = "push">You Pushed.  </p>')

  renderWin: ->
    console.log('rendering win')
    @$('.result').prepend('<p class = "win">You Won.  You should play again.</p>')

  renderLose: ->
    console.log('rendering lose')
    @$('.result').prepend('<p class = "lose">You Lost. Sorry. :(</p>')
