class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png" />'##'<%= rankName %> of <%= suitName %>'


  initialize: ->
    @model.on 'change', => @render
    @render()
    # console.log(rankName)
    console.log( @model.get 'rankName')

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
