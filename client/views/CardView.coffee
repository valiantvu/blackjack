class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img class="card" src="img/cards/<%= rankName.toString().toLowerCase()%>-<%=suitName.toLowerCase()%>.png">'

  initialize: ->
    @model.on 'change', => @render()
    @render()

  render: ->
    @$el.children().detach().end().html
    if @model.get 'revealed' then @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
