#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    #attach listeners
    (@get 'dealerHand').on('determineWinner', @determineWinner)

  determineWinner: =>
    console.log('Determining Winner')

    dealerScore = @determineScore(@get('dealerHand').scores())
    playerScore = @determineScore(@get('playerHand').scores())

    console.log('Context when determining winner ','playerHand')
    @trigger('result','playerHand')

    if dealerScore == playerScore
      console.log('push')
      @trigger('push')
    else if dealerScore > playerScore
      console.log('lose')
      @trigger('lose')
    else
      console.log('win')
      @trigger('win')

  determineScore: (array)->
    if array.length == 1 || array[1] > 21 then return array[0]
    else
      return array[1];
