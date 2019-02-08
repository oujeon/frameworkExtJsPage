/**
 *
 * @param id
 * @returns {*}
 */
function fnGetGridPanel(id) {
  if (id == undefined || id == null || id == "null" || id == "") {
    alert("������ �ڷ��Դϴ�.");
    return false;
  } else {
    return Ext.ComponentQuery.query("gridpanel[id=" + id + "]")[0];
  }
}
/**
 *
 * @param girdpanel
 * @returns {*}
 */
function fnGetStore(girdpanel) {
  if (
    girdpanel == undefined ||
    girdpanel == null ||
    girdpanel == "null" ||
    girdpanel == ""
  ) {
    alert("������ �ڷ��Դϴ�.");
    return false;
  } else {
    return girdpanel.getStore();
  }
}
