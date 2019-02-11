Ext.define("SupportTools.view.MenuToolbar", {
    extend: "Ext.toolbar.Toolbar",
    alias: "widget.MenuToolbar",

    requires: [
    ],

    viewModel: {
        type: "MenuToolbar"
    },
    height: 50,
    id: 'MenuToolbar',
    itemId: 'MenuToolbar',
    items: [
        {
            xtype: "button",
            width: 100,
            text: "Home",
            menu: {
                xtype: "menu",
                items: [
                    {
                        xtype: "menuitem",
                        text: "Bord001" ,
                        listeners: {
                            click: function fnCallMenu(item, e, eOpts) {
                                var workContainer = Ext.ComponentQuery.query(
                                    "container[id=workContainer]"
                                )[0];
                                workContainer.remove("index001Workspace", false);
                                var createBord001Workspace = Ext.create(
                                    "SupportTools.view.bord001Workspace"
                                );
                                workContainer.add(createBord001Workspace);
                            }
                        }
                    },
                    {
                        xtype: "menuitem",
                        text: "Menu Item"
                    },
                    {
                        xtype: "menuitem",
                        text: "Menu Item"
                    },
                    {
                        xtype: "menuitem",
                        text: "Menu Item"
                    }
                ]
            }
        }
    ]

});