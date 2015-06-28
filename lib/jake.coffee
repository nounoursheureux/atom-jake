JakeView = require './jake-view'
{TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'
cp = require('child_process')

module.exports = Jake =
  subscriptions: null

  activate: (state) ->
    @view = new JakeView

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'jake:run': => @run()
    @subscriptions.add atom.commands.add 'atom-workspace', 'jake:open': => @open()

  deactivate: ->
    @subscriptions.dispose()

  run: ->
    cp.spawn('jake', {cwd: atom.project.getPaths()[0]})

  open: ->
    @view.open();
