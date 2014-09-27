class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @isDealer == true
      @add(@deck.pop()).last()

    else
      if @scores().length == 1
        if @scores()[0] < 21
          # Deal Card
          @add(@deck.pop()).last()
          # Check scores post card dealt
          @scoreAction(@scores())
    console.log(@scores())
    #INSERT ACE LOGIC

  stand: ->
    @trigger('click .stand-button')

  bust: ->
    console.log('You busted.')
    @trigger('result')
    @trigger('bust')

  scoreAction: (score)->
    if @scores().length == 1
      if @scores()[0] < 21
        #do Nothing
      else if @scores()[0] == 21
        @stand()
      else
        @bust();

    else
      if @scores()[0] > 21
        @bust()
      else if @scores()[0] == 21 || @scores()[1] == 21
        @stand()

  dealerDecide: ->
    @.at(0).flip()

    # console.log(@scores())
    #while score less than 17, hit
    if @scores().length == 2
      @hit() while (@scores()[1] < 18 or @scores()[1] > 21) && @scores()[0] < 17
    else
      @hit() while @scores() < 17

    if @scores()[0] > 21
      console.log('Dealer Busts')
      @trigger('result')
      @trigger('win')
    else
      console.log('Dealer Stands')
      @trigger('result')
      @trigger('determineWinner')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
