Ext.define('SupportTools.view.bord001Workspace', {
    extend: 'Ext.container.Container',
    alias: 'widget.bord001Workspace',

    requires: [
    ],

    viewModel: {
        type: 'bord001workspace'
    },
    id: 'bord001Workspace',
    itemId: 'bord001Workspace',
    layout: 'border',
    region: "center",
    items: [
        {
            xtype: 'container',
            region: 'north',
            height: 250,
            id: 'bordNorth',
            itemId: 'bordNorth',
            margin: 5,
            layout: 'fit',
            items: [
                {
                    xtype: 'gridpanel',
                    title: 'My Grid Panel',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'string',
                            text: 'String'
                        },
                        {
                            xtype: 'numbercolumn',
                            dataIndex: 'number',
                            text: 'Number'
                        },
                        {
                            xtype: 'datecolumn',
                            dataIndex: 'date',
                            text: 'Date'
                        },
                        {
                            xtype: 'booleancolumn',
                            dataIndex: 'bool',
                            text: 'Boolean'
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'container',
            margins: '5',
            region: 'west',
            id: 'bordWest',
            itemId: 'bordWest',
            margin: 5,
            width: 411,
            layout: 'fit',
            items: [
                {
                    xtype: 'gridpanel',
                    title: 'My Grid Panel',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'string',
                            text: 'String'
                        },
                        {
                            xtype: 'numbercolumn',
                            dataIndex: 'number',
                            text: 'Number'
                        },
                        {
                            xtype: 'datecolumn',
                            dataIndex: 'date',
                            text: 'Date'
                        },
                        {
                            xtype: 'booleancolumn',
                            dataIndex: 'bool',
                            text: 'Boolean'
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'container',
            margins: '5',
            region: 'center',
            id: 'bordCenter',
            itemId: 'bordCenter',
            margin: 5,
            layout: 'fit',
            items: [
                {
                    xtype: 'gridpanel',
                    title: 'My Grid Panel',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'string',
                            text: 'String'
                        },
                        {
                            xtype: 'numbercolumn',
                            dataIndex: 'number',
                            text: 'Number'
                        },
                        {
                            xtype: 'datecolumn',
                            dataIndex: 'date',
                            text: 'Date'
                        },
                        {
                            xtype: 'booleancolumn',
                            dataIndex: 'bool',
                            text: 'Boolean'
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'container',
            margins: '5',
            region: 'east',
            id: 'bordEast',
            itemId: 'bordEast',
            margin: 5,
            width: 300,
            layout: 'fit',
            items: [
                {
                    xtype: 'gridpanel',
                    title: 'My Grid Panel',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'string',
                            text: 'String'
                        },
                        {
                            xtype: 'numbercolumn',
                            dataIndex: 'number',
                            text: 'Number'
                        },
                        {
                            xtype: 'datecolumn',
                            dataIndex: 'date',
                            text: 'Date'
                        },
                        {
                            xtype: 'booleancolumn',
                            dataIndex: 'bool',
                            text: 'Boolean'
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'container',
            margins: '5',
            region: 'south',
            height: 250,
            id: 'bordSouth',
            itemId: 'bordSouth',
            margin: 5,
            layout: 'fit',
            items: [
                {
                    xtype: 'gridpanel',
                    title: 'My Grid Panel',
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'string',
                            text: 'String'
                        },
                        {
                            xtype: 'numbercolumn',
                            dataIndex: 'number',
                            text: 'Number'
                        },
                        {
                            xtype: 'datecolumn',
                            dataIndex: 'date',
                            text: 'Date'
                        },
                        {
                            xtype: 'booleancolumn',
                            dataIndex: 'bool',
                            text: 'Boolean'
                        }
                    ]
                }
            ]
        }
    ]

});