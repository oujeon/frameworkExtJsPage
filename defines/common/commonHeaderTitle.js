Ext.define('SupportTools.view.HeaderTitle', {
    extend: 'Ext.toolbar.Toolbar',
    alias: 'widget.HeaderTitle',

    requires: [
    ],

    viewModel: {
        type: 'HeaderTitle'
    },
    height: 50,
    id: 'HeaderTitle',
    itemId: 'HeaderTitle',

    layout: {
        type: 'hbox',
        pack: 'center'
    },
    items: [
        {
            xtype: 'label',
            style: 'font-size:30px;',
            text: 'Framework ExtJs Page'
        }
    ]

});