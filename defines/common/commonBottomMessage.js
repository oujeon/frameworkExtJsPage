Ext.define('SupportTools.view.BottomMessage', {
    extend: 'Ext.toolbar.Toolbar',
    alias: 'widget.BottomMessage',

    requires: [
    ],

    viewModel: {
        type: 'BottomMessage'
    },
    height: 50,
    id: 'BottomMessage',
    itemId: 'BottomMessage',

    layout: {
        type: 'hbox',
        pack: 'center'
    },
    items: [
        {
            xtype: 'label',
            text: 'HelloWorld'
        }
    ]

});