Ext.define('SupportTools.view.BottomTitle', {
    extend: 'Ext.toolbar.Toolbar',
    alias: 'widget.BottomTitle',

    requires: [
    ],

    viewModel: {
        type: 'BottomTitle'
    },
    height: 50,
    id: 'BottomTitle',
    itemId: 'BottomTitle',

    layout: {
        type: 'hbox',
        pack: 'center'
    },
    items: [
        {
            xtype: 'label',
            text: 'Hello World'
        }
    ]

});