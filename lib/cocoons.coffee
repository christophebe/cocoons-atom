CocoonsView = require './cocoons-view'
{CompositeDisposable} = require 'atom'

module.exports = Cocoons =
  cocoonsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @cocoonsView = new CocoonsView(state.cocoonsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @cocoonsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'cocoons:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @cocoonsView.destroy()

  serialize: ->
    cocoonsViewState: @cocoonsView.serialize()

  toggle: ->
    console.log 'Cocoons was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
