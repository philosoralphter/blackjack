#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  basicStrat: ->
    if @get('dealerHand').scores()[0] > 2 && @get('dealerHand').scores()[0] < 7
      # Player should stay if cards are greater than 11
      # Else hit until above 11 (or double down at 9, 10 or 11)
    else
      # Player should hit until reaching 17

  determineWinner: =>
    console.log('Determining Winner')

    dealerScore = @determineScore(@get('dealerHand').scores())
    playerScore = @determineScore(@get('playerHand').scores())

    if dealerScore == playerScore
      console.log('trigger push')
      @trigger('push')
    else if dealerScore > playerScore
      console.log('trigger lose')
      @trigger('lose')
    else
      console.log('trigger win')
      @trigger('win')

  determineScore: (array)->
    if array.length == 1 || array[1] > 21 then return array[0]
    else
      return array[1];
