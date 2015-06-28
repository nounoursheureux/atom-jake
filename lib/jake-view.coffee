{TextEditorView, View} = require 'atom-space-pen-views'
cp = require 'child_process'

module.exports =
class JakeView extends View
  @content: ->
    @div class: 'jake', =>
      @subview 'miniEditor', new TextEditorView(mini: true)
      @div 'Select a task to run.'

  initialize:  ->
    @panel = atom.workspace.addModalPanel(item: this, visible: false)
    atom.commands.add @miniEditor.element, 'core:confirm', => @runTask()
    atom.commands.add @miniEditor.element, 'core:cancel', => @close()

  open: ->
    return if @panel.isVisible()
    @panel.show()
    @miniEditor.focus()

  close: ->
    return unless @panel.isVisible()
    @miniEditor.setText('')
    @panel.hide()

  runTask: ->
    task = @miniEditor.getText()
    @close()
    cp.spawn('jake', [task], {cwd: atom.project.getPaths()[0]})
