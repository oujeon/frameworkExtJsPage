alert("index.js");
Ext.define("SupportTools.view.NorthGrid", {
    extend: "Ext.grid.Panel",
    alias: "widget.mygridpanel5",

    requires: [],

    viewModel: {
        type: "mygridpanel5"
    },
    title: "North Grid",

    columns: [
        {
            xtype: "gridcolumn",
            dataIndex: "name",
            text: "String"
        }
    ],
    listeners: {
        cellclick: "onGridpanelCellClick"
    },

    onGridpanelCellClick: function(
        tableview,
        td,
        cellIndex,
        record,
        tr,
        rowIndex,
        e,
        eOpts
    ) {
        alert("onGridpanelCellClick");
    }
});

Ext.define("SupportTools.store.northGridStore", {
    extend: "Ext.data.Store",

    requires: [],

    constructor: function(cfg) {
        var me = this;
        cfg = cfg || {};
        me.callParent([
            Ext.apply(
                {
                    storeId: "store",
                    data: [
                        {
                            name: "illum"
                        },
                        {
                            name: "facere"
                        },
                        {
                            name: "similique"
                        }
                    ],
                    proxy: {
                        type: "ajax",
                        reader: {
                            type: "array"
                        }
                    },
                    fields: [
                        {
                            name: "name"
                        }
                    ]
                },
                cfg
            )
        ]);
    }
});