#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    #attach listeners
    (@get 'dealerHand').on('determineWinner', @determineWinner, @)

  determineWinner: ->
    dealerScore = @determineScore((@get 'dealerHand').scores())
    playerScore = @determineScore((@get 'playerHand').scores())
    push = false

    if dealerScore == playerScore
      push=true
      console.log('push')
    else if dealerScore > playerScore
      console.log('dealer wins')
      result = winner: 'dealer', winningScore: dealerScore
    else
      console.log('player wins')
      result = winner: 'player', winningScore: playerScore

  determineScore: (array)->
    if array.length == 1 || array[1] > 21 then return array[0]
    else
      return array[1];
