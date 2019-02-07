Ext.define("SupportTools.view.MenuToolbar", {
    extend: "Ext.toolbar.Toolbar",
    alias: "widget.mytoolbar3",

    requires: [
    ],

    viewModel: {
        type: "mytoolbar3"
    },

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
                        text: "Menu Item",
                        menu: {
                            xtype: "menu",
                            items: [
                                {
                                    xtype: "menuitem",
                                    text: "Menu Item",
                                    menu: {
                                        xtype: "menu",
                                        items: [
                                            {
                                                xtype: "menuitem",
                                                text: "Menu Item"
                                            }
                                        ]
                                    }
                                },
                                {
                                    xtype: "menuitem",
                                    text: "Menu Item"
                                }
                            ]
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