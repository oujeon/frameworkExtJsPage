<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/view/common/jsp/header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>Value Chain </title>
<%@include file="/view/common/jsp/commonResource.jsp"%>
<script type="text/javascript">
/**
 * renderView
 */
function renderView() {
    //장비 셀
    grid01 = Ext.create('VC.grid.CommonGrid', {
        idPrefix : 'grid01',
        titleText : 'EQP_CELL',
        region : 'center',
        autoScroll : true,
        useCheckboxModel : false, //헤더 체크박스
        editable : false, // 그리드 cell edit
        columnDefine : [
             {type   : 'gridrownumber', width:40}
             //셀
            ,{header : 'CELL', colName : 'CHT_NO',  align : 'center', width : 60, editable : false
                ,renderer : function(value, metadata, record, rowIndex, colIndex, store, view){
            if(record.get('INIT_IQTY') != record.get('CMPL_QTY')  ){
                metadata.style = 'background-color:#FFFC04 !important;';
                return value;
            } else {
                return value;
            }
                  }
            } //상품수
            ,{header : 'ITEM_QTY', colName : 'ITEM_CNT', align : 'right', width : 60 , editable : false
                ,renderer : function(value, metadata, record, rowIndex, colIndex, store, view){
                    if(record.get('INIT_IQTY') != record.get('CMPL_QTY') ){
                        metadata.style = 'background-color:#FFFC04 !important;';
                        return value;
                    } else {
                        return value;
                    }
              }
            }  //지시량
            ,{header : 'INS_QTY', colName : 'INIT_IQTY', align : 'right', width : 60, editable : false
                ,renderer : function(value, metadata, record, rowIndex, colIndex, store, view){
                    if(record.get('INIT_IQTY') != record.get('CMPL_QTY')){
                        metadata.style = 'background-color:#FFFC04 !important;';
                        return value;
                    } else {
                        return value;
                    }
              }
            }  //작업완료량
            ,{header : 'JOB_COMPLETE_QTY', colName : 'CMPL_QTY', align : 'right', editable : false
                ,renderer : function(value, metadata, record, rowIndex, colIndex, store, view){
                    if(record.get('INIT_IQTY') != record.get('CMPL_QTY')){
                        metadata.style = 'background-color:#FFFC04 !important;';
                        return value;
                    } else {
                        return value;
                    }
              }
            }  //정상
            ,{header : 'RIGHT', colName : 'PRCS_QTY',    align : 'right', width : 60, editable : false
                ,renderer : function(value, metadata, record, rowIndex, colIndex, store, view){
                    if(record.get('INIT_IQTY') !=  record.get('CMPL_QTY')){
                        metadata.style = 'background-color:#FFFC04 !important;';
                        return value;
                    } else {
                        return value;
                    }
              }
            }  //결품
            ,{header : 'WRONG_PRODUCT', colName : 'SHRT_QTY', align : 'right', width : 60, editable : false
                ,renderer : function(value, metadata, record, rowIndex, colIndex, store, view){
                    if(record.get('INIT_IQTY') != record.get('CMPL_QTY')){
                        metadata.style = 'background-color:#FFFC04 !important;';
                        return value;
                    } else {
                        return value;
                    }
              }
            }  //결품

            , {header : 'WKU_ID',        colName : 'WKU_ID' ,hidden : true, hideable : false} //워크유닛아이디
            , {header : 'CHT_NO',        colName : 'CHT_NO' ,hidden : true, hideable : false} //
           // , {header : 'UPD_PERSON_ID', colName : 'UPD_PERSON_ID' ,hidden : true, hideable : false} //유저아이디
           // , {header : 'WH_CD',         colName : 'WH_CD' ,hidden : true, hideable : false} // 창고코드
        ],
        buttonsConfig: [
                {text: '장비차수 선택',     authType : 'IUD', itemId : 'commonPopWkRsltConfirmBtn', disabled :false, iconCls : 'icon-search',  handler : commonPopWkRsltConfirm }
              , {text: '장비차수 작업확정', authType : 'IUD', itemId : 'confirmEqpSeqWkConfirmBtn', disabled :false, iconCls : 'icon-confirm', handler : confirmEqpSeqWkConfirm }
              , {text: '강제 수작업 전환',  authType : 'IUD', itemId : 'actionHandBtn',             disabled :false, iconCls : 'icon-action', handler : actionHand }
        ],
        listeners : {
            cellclick : function(view, td, cellIndex, record, tr, rowIndex, eventObj, eOpts) {
                var TEMP_WKU_ID = record.get('WKU_ID');
                var TEMP_CHT_NO = record.get('CHT_NO');
                searchBox("1", TEMP_WKU_ID, TEMP_CHT_NO);
            }
        }
    });

    //박스
    grid02 = Ext.create('VC.grid.CommonGrid', {
        idPrefix : 'grid02',
        titleText : 'BOX',
        region : 'east',
        autoScroll : true,
        useCheckboxModel : true, //헤더 체크박스
        selectionMode :  'MULTI' ,
        editable : true, // 그리드 cell edit
        columnDefine : [
             {type   : 'gridrownumber', width:40}
            ,{header : 'WCELL',           colName : 'CHT_NO',   align : 'center', editable:false, align : 'center', width : 60} //셀
            ,{header : 'BOX',             colName : 'CHT_SEQ',  align : 'center', editable:false, align : 'center', width : 60} //박스
            ,{header : 'BOX_BARCODE',     colName : 'PBOX_BAR', align : 'center', editable:false, align : 'center' } //박스바코드
            ,{header : 'PARCEL_PBILL_NO', colName : 'PBILL_NO', align : 'center', editable:false, align : 'center' } //택배운송장번호
            ,{header : 'SHIPMENTNO',      colName : 'OUTB_NO',  align : 'center', editable:false, align : 'center' } //출고번호
            ,{header : 'BSHIPMENTNO',     colName : 'SCAN_BAR', align : 'center', editable:false, align : 'center', width : 200 } //배차번호
            //hidden
            ,{header : 'WKU_ID',            colName : 'WKU_ID' ,hidden : true, hideable : false} //워크유닛아이디
            ,{header : 'CHT_NO',            colName : 'CHT_NO' ,hidden : true, hideable : false} //슈트번호
            //,{header : 'UPD_PERSON_ID',     colName : 'UPD_PERSON_ID' ,hidden : true, hideable : false} //유저아이디
            //,{header : 'WH_CD',             colName : 'WH_CD' ,hidden : true, hideable : false} // 창고코드
        ],
        buttonsConfig: [
             {text: '박스바코드 출력'     , authType : 'ACT',itemId : 'printBoxBarCodeOutputBtn', disabled :false, iconCls : 'icon-printer-new'    ,     handler : printBoxBarCodeOutput}
            ,{text: '택배운송장 출력'     , authType : 'ACT',itemId : 'printParcelPbillNoOutputBtn', disabled :false, iconCls : 'icon-output'    ,     handler : printParcelPbillNoOutput}
            ,{text: '박스 추가'           , authType : 'IUD',itemId : 'addBoxBtn', disabled :false, iconCls : 'icon-add'            ,     handler : addBox}
            ,{text: '삭제'                , authType : 'IUD',itemId : 'removeBoxBtn', disabled :false, iconCls : 'icon-delete'         ,     handler : removeBox}
        ],
        listeners : {
            cellclick : function(view, td, cellIndex, record, tr, rowIndex, eventObj, eOpts) {
                if(cellIndex != 10){
                    var TEMP_WKU_ID = record.get('WKU_ID');
                    var TEMP_CHT_SEQ = record.get('CHT_SEQ');
                    var TEMP_CHT_NO = record.get('CHT_NO');
                    searchEqpWkDesc("1", TEMP_WKU_ID,  TEMP_CHT_SEQ,  TEMP_CHT_NO);
                }

            }
        }
    });
    //장비작업 내역
    grid03 = Ext.create('VC.grid.CommonGrid', {
        idPrefix : 'grid03',
        titleText : 'EQP_WK_DESC',
        region : 'south',
        flex : 1.5,
        autoScroll : true,
        useCheckboxModel : false, //헤더 체크박스
        editable : true, // 그리드 cell edit
        updateOnly : true,
        columnDefine : [
              {type : 'gridrownumber', width:40}
            , {header : 'PRD_CD',           colName : 'PRD_CD',        align : 'center', width : 90,  editable: false}//상품코드
            , {header : 'ITEM_NM',          colName : 'ITEM_NM',       align : 'center', width : 130, editable: false}//상품명
            , {header : 'INS_QTY',          colName : 'INIT_IQTY',     align : 'right', width : 60,  editable: false}//지시량
            , {header : 'JOB_COMPLETE_QTY', colName : 'CMPL_QTY',      align : 'right', width : 100, editable: false}//작업완료량
            , {header : 'RIGHT',            colName : 'PRCS_QTY',      align : 'right', width : 60,  editable: true}//정상
            , {header : 'WRONG_PRODUCT',    colName : 'SHRT_QTY',      align : 'right', width : 60,  editable: true}//결품
            //, {header : 'OUTBOUND_DETL_NO', colName : 'OUTB_DETL_NO',  align : 'center', width : 100, editable: false}//출고상세번호
            //, {header : 'OZ_ORDER_NO',      colName : 'ORDER_NO',      align : 'center', width : 100, editable: false}//오더번호
            //, {header : 'ORDER_DETL_NO',    colName : 'ORDER_DETL_NO', align : 'center', width : 100, editable: false}//오더상세번호
             // hidden
            , {header : 'WKU_ID',           colName : 'WKU_ID',        align : 'center', width : 100, editable: false, hidden : true, hideable : false}//
            , {header : 'CHT_NO',           colName : 'CHT_NO',        align : 'center', width : 100, editable: false, hidden : true, hideable : false}//
            , {header : 'CHT_SEQ',          colName : 'CHT_SEQ',       align : 'center', width : 100, editable: false, hidden : true, hideable : false}//
            , {header : 'WKI_SEQ',          colName : 'WKI_SEQ',       align : 'center', width : 100, editable: false, hidden : true, hideable : false}//
            , {header : 'UPD_PERSON_ID',    colName : 'UPD_PERSON_ID', align : 'center', width : 100, editable: false, hidden : true, hideable : false}//
         ],
        buttonsConfig: [
             // {text: 'SEARCH' , authType : 'R'  ,itemId : 'searchEqpWkDescBtn', disabled :false,  handler : searchEqpWkDesc}
             {text: 'SAVE'   , authType : 'IUD',itemId : 'saveEqpWkDescBtn', disabled :false,   handler : saveEqpWkDesc}
        ],
        listeners : {
            cellclick : function(view, td, cellIndex, record, tr, rowIndex, eventObj, eOpts) {
            }
        }
    });
    /**********************************************************************************************************
       뷰포트
    **********************************************************************************************************/
    viewPort = Ext.create('Ext.container.Viewport', {
        layout : 'border',
        items : [
            {
                layout : 'border',
                region : 'center',
                split : true,
                flex : 1,
                border : 0,
                bodyCls : 'grid-bottom-line',
                items : [
                    {
                        region : 'north',
                        layout : 'fit',
                        split : true,
                        flex : 1,
                        border : 0,
                        bodyCls : 'grid-right-line',
                        items : [grid01]
                    },
                    {
                        region : 'center',
                        layout : 'fit',
                        split : true,
                        flex : 1,
                        border : 0,
                        bodyCls : 'grid-right-line',
                        items : [grid02]
                    },
                    {
                        region : 'east',
                        collapseMode:'mini',
                        layout : 'fit',
                        split : true,
                        flex : 1,
                        border : 0,
                        bodyCls : 'grid-left-line',
                        items : [grid03]
                    }
                ]
            }
        ],
        listeners : {
            beforerender : function(){
                //창고코드 히든처리
                var OBJ_WH_CD = Ext.ComponentQuery.query('[name=WH_CD]', SEARCH_CONDITION_FORM)[0];
                OBJ_WH_CD.ownerCt.hidden = true;

            },
            render : function(me, eOpts){
                if(SEARCH_CONDITION_FORM) me.add(SEARCH_CONDITION_FORM);
            },
            afterlayout :function(me, layout, eOpts){
                //search는 readonly, 배치일자 현재 날짜
                 var ckbf = Ext.ComponentQuery.query("textfield",SEARCH_CONDITION_FORM);

                 var today = Ext.Date.format(new Date() , 'Y.m.d');

                 Ext.Array.each(ckbf, function(name, index, countriesItSelf) {

                     if(name.name != "ALCR_CMD_DT"){
                          name.setReadOnly(true);
                     } else if(name.name == "ALCR_CMD_DT"){
                         name.setValue(new Date());
                        // var firsttemp = today.replace(/\./gi, "");
                         //name.param.KEYPARAM = firsttemp;
                         //name.param.PARAM1 = firsttemp;
                        // Ext.EventManager.on(name.el,"keyup", function(){
                             //var temp = name.getValue().replace(/\./gi, "");
                             //var temp = Ext.Date.format(name.getValue() , 'Ymd');
                             //name.param.PARAM1 = temp;
                             //name.param.KEYPARAM = temp;
                        // });
                         //Ext.EventManager.on(name.el,"click", function(){
                             //var temp = name.getValue().replace(/\./gi, "");
                            // var temp = Ext.Date.format(name.getValue() , 'Ymd');
                             //name.param.PARAM1 = temp;
                             //name.param.KEYPARAM = temp;
                            // if(temp.length < 8 || temp.length > 8){
                            //     Ext.Msg.alert('', "날짜가 아님니다");
                             //    return;
                             //}
                        // });
                     }
                 });

            }
        }
    });
    }
    /**********************************************************************************************************
    FUNCTION 정의
    **********************************************************************************************************/
    /**
     * 장비셀
     */
    function searchEqpCell(cmd, WKU_ID){
        // 기록
        record();

        // 1. 조회조건 폼 밸리데이션 후 조회조건 데이터셋 DS_SEARCHCONDITION 셋팅.
        if( ! setSearchConditionDataSet() ) return;

        //99
        //console.log("params : %o", params);

        // if( !filterRemoveSearchConditionDataSet([  'WAVE_NO']) ) return;

        var TEMP_WKU_ID = WKU_ID;

        if(WKU_ID ==  undefined  || WKU_ID == "undefined" || WKU_ID == "" ){
            TEMP_WKU_ID = grid01.getSelectedRowData('WKU_ID');
        }

         var params = {
                 WKU_ID : TEMP_WKU_ID
         };  //

         // reset
         grid01.reset();
         grid02.reset();
         grid03.reset();

        // 3. 조회
        grid01.search(viewPort, '/wkRsltConfirmService/searchEqpCell', params, null, function(result, successYn) {
            if(successYn && result["DS_OUT"].length > 0) { //자료가 있다면 grid02을 검색
              if(cmd == 1){ //전체그리드 조회
                  var TEMP_WKU_ID =  grid01.getSelectedRowData('WKU_ID');
                  var TEMP_CHT_NO =  grid01.getSelectedRowData('CHT_NO');
                  searchBox(cmd, TEMP_WKU_ID, TEMP_CHT_NO);
              } else if(cmd == 2){
                  //과거 위치로 이동
                  var index01 = history01.getValues()[history01.getCount()-1];
                  grid01.getSelectionModel().selectRange( index01, index01);
              } else if(cmd == 3){
                  grid01.getSelectionModel().selectRange( 0, 0);
              } else if(cmd == 5){//삭제
                  //과거 위치로 이동
                  var index01 = history01.getValues()[history01.getCount()-1];
                  grid01.getSelectionModel().selectRange( index01, index01);
                  // 자기자신의 값으로 다시 호출, grid01의 자료를 가질고 할때
                  // 버그때문에 예전 레코드의 위치의 값을 가져온다.
                  var TEMP_WKU_ID =  grid02.getSelectedRowData('WKU_ID');
                  var TEMP_CHT_NO =  grid02.getSelectedRowData('CHT_NO');
                  searchBox(cmd, TEMP_WKU_ID, TEMP_CHT_NO);
              } else if(cmd == 6){//
                  //과거 위치로 이동
                  var index01 = history01.getValues()[history01.getCount()-1];
                  grid01.getSelectionModel().selectRange( index01, index01);
                  var TEMP_WKU_ID =  grid02.getSelectedRowData('WKU_ID');
                  var TEMP_CHT_NO =  grid02.getSelectedRowData('CHT_NO');
                  searchBox(cmd, TEMP_WKU_ID, TEMP_CHT_NO);
              } else if( cmd == 8){ //박스추가
                  //과거 위치로 이동
                  var index01 = history01.getValues()[history01.getCount()-1];
                  grid01.getSelectionModel().selectRange( index01, index01);
                  // 자기자신의 값으로 다시 호출, grid01의 자료를 가질고 할때
                  // 버그때문에 예전 레코드의 위치의 값을 가져온다.
                  var TEMP_WKU_ID =  grid02.getSelectedRowData('WKU_ID');
                  var TEMP_CHT_NO =  grid02.getSelectedRowData('CHT_NO');
                  searchBox(cmd, TEMP_WKU_ID, TEMP_CHT_NO);
              }
            }
        }, true );
    }
    /**
     * 박스
     */
    function searchBox(cmd, WKU_ID, CHT_NO){
        // 기록
        record();

        // 1. 조회조건 폼 밸리데이션 후 조회조건 데이터셋 DS_SEARCHCONDITION 셋팅.
        if( ! setSearchConditionDataSet() ) return;

        //99
        //console.log("params : %o", params);

         // if( !filterRemoveSearchConditionDataSet([  'WAVE_NO']) ) return;

         var params = {
                   WKU_ID : WKU_ID
                 , CHT_NO : "AND S.CHT_NO = " + CHT_NO +""
         };  //


         // reset
         grid02.reset();
         grid03.reset();

        // 3. 조회
        grid02.search(viewPort, '/wkRsltConfirmService/searchBox', params, null,  function(result, successYn) {

            if(successYn && result["DS_OUT"].length > 0) { //자료가 있다면 grid02을 검색
                if(cmd == "1"){ //전체 조회
                  var TEMP_WKU_ID =  grid02.getSelectedRowData('WKU_ID');  //워크유닛아이디
                  var TEMP_CHT_SEQ =  grid02.getSelectedRowData('CHT_SEQ');//슈트차수
                  var TEMP_CHT_NO =  grid02.getSelectedRowData('CHT_NO');  //슈트번호
                  searchEqpWkDesc(cmd, TEMP_WKU_ID, TEMP_CHT_SEQ, TEMP_CHT_NO);
                } else if(cmd == 2){
                    // 과거 위치로 이동
                    var index02 = history02.getValues()[history02.getCount()-1];
                    grid02.getSelectionModel().selectRange( index02, index02);
                } else if(cmd == 3){
                    grid02.getSelectionModel().selectRange( 0, 0);

                } else if(cmd == 5){ // 삭제

                    // 과거 위치로 이동
                    grid02.getSelectionModel().selectRange( 0, 0);

                    var TEMP_WKU_ID =  grid02.getSelectedRowData('WKU_ID');  //워크유닛아이디
                    var TEMP_CHT_SEQ =  grid02.getSelectedRowData('CHT_SEQ');//슈트차수
                    var TEMP_CHT_NO =  grid02.getSelectedRowData('CHT_NO');  //슈트번호

                    searchEqpWkDesc(cmd, TEMP_WKU_ID, TEMP_CHT_SEQ, TEMP_CHT_NO);

                } else if(cmd == 6){//
                    // 과거 위치로 이동
                    var index02 = history02.getValues()[history02.getCount()-1];
                    grid02.getSelectionModel().selectRange( index02, index02);

                    var TEMP_WKU_ID =  grid02.getSelectedRowData('WKU_ID');  //워크유닛아이디
                    var TEMP_CHT_SEQ =  grid02.getSelectedRowData('CHT_SEQ');//슈트차수
                    var TEMP_CHT_NO =  grid02.getSelectedRowData('CHT_NO');  //슈트번호

                    searchEqpWkDesc(cmd, TEMP_WKU_ID, TEMP_CHT_SEQ, TEMP_CHT_NO);
                } else if(cmd == 8){ //박스추가
                    // 과거 위치로 이동
                    grid02.getSelectionModel().selectRange( 0, 0);

                    var TEMP_WKU_ID =  grid02.getSelectedRowData('WKU_ID');  //워크유닛아이디
                    var TEMP_CHT_SEQ =  grid02.getSelectedRowData('CHT_SEQ');//슈트차수
                    var TEMP_CHT_NO =  grid02.getSelectedRowData('CHT_NO');  //슈트번호
                    searchEqpWkDesc(cmd, TEMP_WKU_ID, TEMP_CHT_SEQ, TEMP_CHT_NO);

                }
            }
            //grid02.getSelectionModel().deselectAll();//체크 해제
        }, true);
    }
    /**
     * 작업지시
     */
    function searchEqpWkDesc(cmd,  WKU_ID,  CHT_SEQ,  CHT_NO){

        // 기록
        record();

        //check
        var rows = grid01.getStore().getCount();
        if(rows  < 1){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "조회된 자료가 없습니다.",
                msg: Lang.get('NO_DATA_FOUND'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });
            return;
        }

        //check
        var rows = grid02.getStore().getCount();
        if(rows  < 1){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "조회된 자료가 없습니다.",
                msg: Lang.get('NO_DATA_FOUND'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });
            return;
        }

        // 1. 조회조건 폼 밸리데이션 후 조회조건 데이터셋 DS_SEARCHCONDITION 셋팅.
        if( ! setSearchConditionDataSet() ) return;

        //99
        //console.log("params : %o", params);

        // if( !filterRemoveSearchConditionDataSet([  'WAVE_NO']) ) return;

         var params = {
             WKU_ID     : WKU_ID
           , CHT_SEQ     :  CHT_SEQ
           , W_CHT_SEQ   : "AND W.CHT_SEQ = " +  CHT_SEQ + ""
           , S_CHT_SEQ   : "AND S.CHT_SEQ = " +  CHT_SEQ + ""
           , CHT_NO      : "AND W.CHT_NO  = " +  CHT_NO  + ""
         };  //


        grid03.reset();

        // 3. 조회
        grid03.search(viewPort, '/wkRsltConfirmService/searchEqpWkDesc', params, null, function(result, successYn) {
            if(successYn && result["DS_OUT"].length > 0) { //자료가 있다면 grid02을 검색
                if(cmd == "1"){//전체 조회
                } else if(cmd == 2){
                    // 과거 위치로 이동
                    var index03 = history03.getValues()[history03.getCount()-1];
                    grid03.getSelectionModel().selectRange( index03, index03);
                } else if(cmd == 3){
                 grid03.getSelectionModel().selectRange( 0, 0);
                } else if(cmd == 5){//삭제
                    // 과거 위치로 이동
                    grid03.getSelectionModel().selectRange( 0, 0);
                } else if(cmd == 8){//박스추가
                    // 과거 위치로 이동
                    grid03.getSelectionModel().selectRange( 0, 0);
                }
            }
        }, true);
    }
    /**
     * 강제 수작업 전환
     */
    function actionHand(){
        // 기록
        record();

        var dataToSend = [];
        var url = '/wkRsltConfirmService/actionHand';
        var obj = {};

        //check
        var OBJ_WAVE_NO = Ext.ComponentQuery.query('[name=WAVE_NO]', SEARCH_CONDITION_FORM)[0];

        if(OBJ_WAVE_NO.getValue() == ""){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "장비차수를 선택 해주세요",
                msg: Lang.get('SHOULD_CHOICE_EQP_SEQ'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });
            return;
        }

        //
        //var rows = grid01.getSelectionModel().getSelection();
        //if(rows.length < 1){
        //    Ext.MessageBox.show({
         //       //title: "ddddd",
        //        msg: "선택된 레코드가 없습니다.",
        //        buttons: Ext.MessageBox.OK,
         //       icon: Ext.MessageBox.INFO
        //    });
        //    return;
        //}

        var OBJ_WAVE_STATUS = Ext.ComponentQuery.query('[name=WAVE_STATUS]', SEARCH_CONDITION_FORM)[0];

        //* 유효성 체크
        //1. WAVE_SCD = 5 인 건만 허용.  * 미해당건 alert : 할당 상태의 WAVE건만 진행 가능합니다.
        if(OBJ_WAVE_STATUS.getValue() != 5){
            Ext.MessageBox.show({
                //title: 'Save Success',
                //msg: "할당 상태의 WAVE건만 진행 가능합니다.", 
                msg: Lang.get('ONLY_AS_WAVE'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO,
                fn : function(){
                    searchEqpCell(TEMP_WKU_ID);
                }
            });
            return;
        };

        var OBJ_MPROC_YN = Ext.ComponentQuery.query('[name=MPROC_YN]', SEARCH_CONDITION_FORM)[0];
        var OBJ_COUNTING_SCD  = Ext.ComponentQuery.query('[name=COUNTING_SCD]', SEARCH_CONDITION_FORM)[0];
        //2. 수처리 여부 = ‘Y’
        //* alert : 수처리가 아닌 WAVE건만 진행 가능합니다.
        if(OBJ_MPROC_YN.getValue() == 'Y'){
            Ext.MessageBox.show({
                //title: 'Save Success',
               // msg: "수처리가 아닌 건만 진행 가능합니다.",
                msg: Lang.get('MPROC_YN_N'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO,
                fn : function(){
                }
            });
            return;

        } else if(OBJ_MPROC_YN.getValue() == 'N'){
            // 3. 수처리 여부 = ‘N’        -. 39<= WK_PROC_SCD <= 69 허용
            // * 미해당건 alert : 전환이 허용되지 않는 진행상태입니다.
            if(OBJ_COUNTING_SCD.getValue() >= 39 && OBJ_COUNTING_SCD.getValue() <= 69 ){
            } else {
              Ext.MessageBox.show({
                  //title: 'Save Success',
                  //msg: "전환이 허용되지 않는 진행상태입니다. ",
                  msg: Lang.get('NOT_ALLOWED_IN_PROCESS'),
                  buttons: Ext.MessageBox.OK,
                  icon: Ext.MessageBox.INFO,
                  fn : function(){
                  }
              });
              return;
            }
        }

        Ext.MessageBox.confirm('', '현재 장비 차수를 수처리 방식으로 강제 전환하시겠습니까? \n전환후에는 다시 장비처리 방식으로 변경이 불가능합니다.\n정말로 강제 수처리 전환 하시겠습니까?', function(btn){
            if(btn == "yes"){
                var OBJ_WH_CD = Ext.ComponentQuery.query('[name=WH_CD]', SEARCH_CONDITION_FORM)[0];
                var OBJ_WKU_ID = Ext.ComponentQuery.query('[name=WKU_ID]', SEARCH_CONDITION_FORM)[0];

               // obj["I_WH_CD"]             = grid02.getSelectedRowData('WH_CD');
                obj["I_WH_CD"]             = OBJ_WH_CD.getValue();
                obj["I_WKU_ID"]            = OBJ_WKU_ID.getValue();
                //obj["I_USER_ID"]           = grid02.getSelectedRowData('UPD_PERSON_ID');
                obj["I_USER_ID"]           = top.UserInfo.userId;
                obj["I_DBMS_OUTPUT_YN"]    = "N";
                obj["O_ERR_CD"]            = "";
                obj["O_ERR_ARG"]           = "";
                obj["O_DEB_MSG"]           = "";

                dataToSend.push(obj);

                Ext.Ajax.request({
                    url : url,
                    jsonData : {
                        DS_SAVE : dataToSend
                    },
                    params : {
                    },
                    callback : function(options, success, response){
                        var json = Ext.decode(response.responseText);

                        if(json["ErrorMsg"] === "OK")
                        {
                            Ext.MessageBox.show({
                                //title: 'Save Success',
                                //msg: "수작업 전환에 성공하였습니다.",
                                msg: Lang.get('SUCCESSED_MPROC_YN'),
                                buttons: Ext.MessageBox.OK,
                                icon: Ext.MessageBox.INFO,
                                fn : function(){

                                    var TEMP_WKU_ID =  grid01.getSelectedRowData('WKU_ID');

                                    searchEqpCell("1", TEMP_WKU_ID);

                                }
                            });

                            var OBJ_MPROC_YN  = Ext.ComponentQuery.query('[name=MPROC_YN]', SEARCH_CONDITION_FORM)[0];
                            var OBJ_COUNTING_SCD = Ext.ComponentQuery.query('[name=COUNTING_SCD]', SEARCH_CONDITION_FORM)[0];

                            //"{"rsltCfmDtime":"17/05/31","SuccessMsg":"요청하신 작업을 완료하였습니다.","errArg":"null","debMsg":"[UPDATE WMT_COB_OUTBOUND_DR]","wkProcScd":"89","ErrorMsg":"OK","errCd":"OK","ErrorCode":0}"

                            var mprocYn = json["mprocYn"];
                            var procScd = json["procScd"];
                            var errCd = json["errCd"];
                            var errArg = json["errArg"];
                            var debMsg = json["debMsg"];

                            OBJ_MPROC_YN.setValue(mprocYn);
                            OBJ_COUNTING_SCD.setValue(procScd);
                        }
                        else
                        {
                            Ext.MessageBox.show({
                                //title: 'Error Message',
                                //msg: "수작업 전환에 실패하였습니다", 
                                msg: Lang.get('FAILED_MPROC_YN'),
                                buttons: Ext.MessageBox.OK,
                                icon: Ext.MessageBox.INFO,
                                fn : function(){
                                    var TEMP_WKU_ID =  grid01.getSelectedRowData('WKU_ID');
                                    searchEqpCell("1", TEMP_WKU_ID);
                                }
                            });
                        }
                    }
                });

                return true;
            } else {
                return false;
            }
        });
    }
    /**
     * 장비차수 작업확정
     */
    function confirmEqpSeqWkConfirm(){ 
        
        
        //버튼 체크
        if(checkdisable()){
            return;
        };
        // 기록
        record();

        var dataToSend = [];
        var url = '/wkRsltConfirmService/confirmEqpSeqWkConfirm';
        var obj = {};


        //check
        var OBJ_WAVE_NO = Ext.ComponentQuery.query('[name=WAVE_NO]', SEARCH_CONDITION_FORM)[0];

        if(OBJ_WAVE_NO.getValue() == ""){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "장비차수를 선택 해주세요.",
                msg: Lang.get('SHOULD_CHOICE_EQP_SEQ'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });
            return;
        }


        //WMP_COB_WKU_CHT_SEQ_ADD
     // 유효성 체크 1
     // 그리드 3 편집 진행중일때 비허용.
     // alert : 장비 작업 내역 편집을 종료후 실행해주세요

        var nofirst = 0;
        grid03.store.each(function(record){
            if(record.get('ROW_STATUS') == 'U'){
                  nofirst = 1;
            }
         });

        if(nofirst == 1){
            Ext.MessageBox.show({
                //title: 'Error Message',
               // msg: "장비 작업 내역 편집을 종료후 실행해주세요",
                msg: Lang.get('RUN_AFTER_THE_END'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
            return;
        }


        
        Ext.MessageBox.confirm('', '현재 장비 차수의 셀 전체에 대한 작업을 확정하시겠습니까?', function(btn){

            if(btn == "yes"){
                var rows = grid02.getSelectionModel().getSelection();
                  if(rows.length < 1){
                    Ext.MessageBox.show({
                        //title: "ddddd",
                        //msg: "선택된 박스가 없습니다",
                        msg: Lang.get('HAVE_NO_BOX_CHOICED'),
                        buttons: Ext.MessageBox.OK,
                        icon: Ext.MessageBox.INFO
                    });
                    return;
                }


                var OBJ_WH_CD = Ext.ComponentQuery.query('[name=WH_CD]', SEARCH_CONDITION_FORM)[0];
                var TEMP_WKU_ID            = grid02.getSelectedRowData('WKU_ID');
                obj["I_WH_CD"]             = OBJ_WH_CD.getValue();
                obj["I_WKU_ID"]            = grid02.getSelectedRowData('WKU_ID');
                //obj["I_RSLT_CFM_SRC_CD"]   = "WMS";
                //obj["I_USER_ID"]           = grid02.getSelectedRowData('UPD_PERSON_ID');
                obj["I_USER_ID"]           = top.UserInfo.userId;
                obj["I_RSLT_AUTO_MAKE_YN"] = "N";
                obj["I_DBMS_OUTPUT_YN"]    = "N";
                obj["O_ERR_CD"]            = "";
                obj["O_ERR_ARG"]           = "";
                obj["O_DEB_MSG"]           = "";

                dataToSend.push(obj);

                var gridMask = new Ext.LoadMask(viewPort, {msg:"Loading ..."});
                gridMask.show(); // loadmast start
                
                Ext.Ajax.request({
                    url : url,
                    jsonData : {
                        DS_SAVE : dataToSend
                    },
                    params : {
                    },
                    callback : function(options, success, response){
                        gridMask.hide(); // loadmask end
                        
                        var json = Ext.decode(response.responseText);

                        if(json["ErrorMsg"] === "OK")
                        {
                            Ext.MessageBox.show({
                                //title: 'Save Success',
                                //msg: "작업결과 확정에 성공하였습니다",
                                msg: Lang.get('SUCCSSED_WKRSLT_CONFIRM'),
                                buttons: Ext.MessageBox.OK,
                                icon: Ext.MessageBox.INFO,
                                fn : function(){
                                    var TEMP_WKU_ID =  grid01.getSelectedRowData('WKU_ID');

                                    searchEqpCell("1", TEMP_WKU_ID);

                                }
                            });
                            //"{"rsltCfmDtime":"17/05/31","SuccessMsg":"요청하신 작업을 완료하였습니다.","errArg":"null","debMsg":"[UPDATE WMT_COB_OUTBOUND_DR]","wkProcScd":"89","ErrorMsg":"OK","errCd":"OK","ErrorCode":0}"

                            var wkProcScd = json["wkProcScd"];
                            var rsltCfmDtime = json["rsltCfmDtime"];
                            var errCd = json["errCd"];
                            var errArg = json["errArg"];
                            var debMsg = json["debMsg"];

                            var OBJ_COUNTING_SCD      = Ext.ComponentQuery.query('[name=COUNTING_SCD]', SEARCH_CONDITION_FORM)[0];
                            var OBJ_WKRSLT_CONFIRM_DT = Ext.ComponentQuery.query('[name=WKRSLT_CONFIRM_DT]', SEARCH_CONDITION_FORM)[0];

                            OBJ_COUNTING_SCD.setValue(wkProcScd);// 진행상태
                            OBJ_WKRSLT_CONFIRM_DT.setValue(rsltCfmDtime);// 작업확정일시

                        }
                        else
                        {
                            Ext.MessageBox.show({
                                //title: 'Error Message',
                                //msg: "작업결과 확정에 실패하였습니다", 
                                msg: Lang.get('FAILED_WKRSLT_CONFIRM'),
                                buttons: Ext.MessageBox.OK,
                                icon: Ext.MessageBox.INFO,
                                fn : function(){
                                    var TEMP_WKU_ID =  grid01.getSelectedRowData('WKU_ID');

                                    searchEqpCell("1", TEMP_WKU_ID);

                                }
                            });
                        }
                    }
                });  
                return true;
            } else {
                return false;
            }
        });
    }
    /**
     * 박스바코드 출력
     */
    function printBoxBarCodeOutput(){
        // 기록
        record();

        var rows = grid02.getSelectionModel().getSelection();

        if(rows.length < 1){
          Ext.MessageBox.show({
              //title: "ddddd",
              //msg: "선택된 레코드가 없습니다",
              msg: Lang.get('NO_ROW_SELECTED'),
              buttons: Ext.MessageBox.OK,
              icon: Ext.MessageBox.INFO
          });
          return;
      }

        var paramsForReport = "PBOX_BAR";
        var reportSetting = {
                //SEARCH_PARAM : '00000000025411',
                popWinTitle : 'MENU_RECEIVINGNOTICE',//레포트 타이틀
                ozViewerId : 'MENU_RECEIVINGNOTICE',//레포트 개별ID
                popWinOptions : 'width=800 height=900 left=300 top=75 resizable=yes scrollbars=no toolbar=no menubar=no location=no', //레포트 팝업 옵션
                //width : 800, //레포트 고정크기 레포트 내부창을 고정하게 됨
                //height : 900, //레포트 고정크기 레포트 내부창을 고정하게 됨
                ozr : 'boxBarcodeOption', //ozr명 .ozr 없이
                odi : 'boxBarcodeOption', //odi명 .odi 없이
                //folder : 'sample', //odi명 .odi 없이
                //isframe : 'true', //오즈 뷰어를 따로 띄움 default false
                //useoutborder : 'false', //오즈 뷰어의 보더를 보여줌 default 'true'
                //usestatusbar : 'false', //오즈 뷰어의 스테이터스를 보여줌 default 'true'
                //toolbarAll : 'false', //오즈 뷰어의 툴바를 보여줌 default 'true'
                langList :
                    "LOGIS_PERSON,REPORT_WCODE_OUT,REPORT_REGNO,REPORT_COMPANY_ADDR,ITEM_CD,ITEM_NM,SEQ,REPORT_INB_INSPECT_LIST,RECEIPTTIME,SHIPPER_NM,SERVICE_SUPPLY_NM,COMPANYNAME,REPORT_SUPPLIER_TO,REPORT_SUPPLIER_FROM,UNITQTY,REPORT_INB_QTY,REPORT_CHK_QTY,REPORT_CORP_NAME,REPORT_BUSINESS_COND,REPORT_TYPE_BUSINESS,NAME,REPORT_WNAME,REPORT_WCODE,REPORT_SHIP_VNDRINFO,REPORT_WH_ADDR,TEL,FAX,REPORT_DRIVER,REPORT_CONFIRMOR,REPORT_CONFIRM_FIELD,TASKINBOUNDTEAM,REPORT_COUNTING_SEQ"//오즈에서 사용할 언어팩
            };

        grid02.popOzReportChecked(paramsForReport,reportSetting);
    }
    /**
     * 택배운송장 출력
     */
    function printParcelPbillNoOutput(){
        // 기록
        record();

        var rows = grid02.getSelectionModel().getSelection();

        if(rows.length < 1){
          Ext.MessageBox.show({
              //title: "ddddd",
             // msg: "선택된 레코드가 없습니다",
              msg: Lang.get('NO_ROW_SELECTED'),
              buttons: Ext.MessageBox.OK,
              icon: Ext.MessageBox.INFO
          });
          return;
      }


        var paramsForReport = "PBILL_NO";
        var reportSetting = {
               // PBILL_NO : '000000000011',
                popWinTitle : 'MENU_RECEIVINGNOTICE',//레포트 타이틀
                ozViewerId : 'MENU_RECEIVINGNOTICE',//레포트 개별ID
                popWinOptions : 'width=800 height=900 left=300 top=75 resizable=yes scrollbars=no toolbar=no menubar=no location=no', //레포트 팝업 옵션
                //width : 800, //레포트 고정크기 레포트 내부창을 고정하게 됨
                //height : 900, //레포트 고정크기 레포트 내부창을 고정하게 됨
                ozr : 'parBill', //ozr명 .ozr 없이
                odi : 'parBill', //odi명 .odi 없이
                //folder : 'sample', //odi명 .odi 없이
                //isframe : 'true', //오즈 뷰어를 따로 띄움 default false
                //useoutborder : 'false', //오즈 뷰어의 보더를 보여줌 default 'true'
                //usestatusbar : 'false', //오즈 뷰어의 스테이터스를 보여줌 default 'true'
                //toolbarAll : 'false', //오즈 뷰어의 툴바를 보여줌 default 'true'
                langList :
                    "LOGIS_PERSON,REPORT_WCODE_OUT,REPORT_REGNO,REPORT_COMPANY_ADDR,ITEM_CD,ITEM_NM,SEQ,REPORT_INB_INSPECT_LIST,RECEIPTTIME,SHIPPER_NM,SERVICE_SUPPLY_NM,COMPANYNAME,REPORT_SUPPLIER_TO,REPORT_SUPPLIER_FROM,UNITQTY,REPORT_INB_QTY,REPORT_CHK_QTY,REPORT_CORP_NAME,REPORT_BUSINESS_COND,REPORT_TYPE_BUSINESS,NAME,REPORT_WNAME,REPORT_WCODE,REPORT_SHIP_VNDRINFO,REPORT_WH_ADDR,TEL,FAX,REPORT_DRIVER,REPORT_CONFIRMOR,REPORT_CONFIRM_FIELD,TASKINBOUNDTEAM,REPORT_COUNTING_SEQ"//오즈에서 사용할 언어팩
            };
        grid02.popOzReportChecked(paramsForReport,reportSetting);
    }
    /**
     * 박스추가
     */
    function addBox(){
        //버튼 체크
        if(checkdisable()){
            return;
        };

        // 기록
        record();

        var dataToSend = [];
        var url = '/wkRsltConfirmService/addBox';
        var obj = {};


        //check
        //선택한 row 배열
        var nofirst = 0;
        grid03.store.each(function(record){
            if(record.get('ROW_STATUS') == 'U'){
                  nofirst = 1;
            }
         });

        if(nofirst == 1){
            Ext.MessageBox.show({
                //title: 'Error Message',
                //msg: "장비 작업 내역 편집을 종료후 실행해주세요",
                msg: Lang.get('RUN_AFTER_THE_END'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
            return;
        }

        //check
         var rows = grid02.getStore().getCount();
         if(rows  < 1){
             Ext.MessageBox.show({
                 //title: "ddddd",
                 //msg: "조회된 자료가 없습니다.",
                 msg: Lang.get('NO_DATA_FOUND'),
                 buttons: Ext.MessageBox.OK,
                 icon: Ext.MessageBox.INFO
            });
             return;
         }

        Ext.MessageBox.confirm('', '박스를 추가하시겠습니까?', function(btn){
            if(btn == "yes"){

                //I_WKU_ID
                //I_CHT_NO
                //I_USER_ID
                //I_DBMS_OUTPUT_YN

                var TEMP_WKU_ID         = grid02.getSelectedRowData('WKU_ID');
                var TEMP_CHT_SEQ        = grid02.getSelectedRowData('CHT_SEQ');
                var TEMP_CHT_NO         = grid02.getSelectedRowData('CHT_NO');

                obj["I_WKU_ID"]         = grid02.getSelectedRowData('WKU_ID');
                obj["I_CHT_NO"]         = grid02.getSelectedRowData('CHT_NO');
                //obj["I_USER_ID"]        = grid02.getSelectedRowData('UPD_PERSON_ID');
                obj["I_USER_ID"]        = top.UserInfo.userId;

                obj["I_DBMS_OUTPUT_YN"] = "N";
                obj["O_NEW_CHT_SEQ"]    = "0";
                obj["O_ERR_CD"]         = "";
                obj["O_ERR_ARG"]        = "";
                obj["O_DEB_MSG"]        = "";

                dataToSend.push(obj);

                Ext.Ajax.request({
                    url : url,
                    jsonData : {
                        DS_SAVE : dataToSend
                    },
                    params : {
                    },
                    callback : function(options, success, response){
                        var json = Ext.decode(response.responseText);

                        if(json["ErrorMsg"] === "OK")
                        {
                            Ext.MessageBox.show({
                                //title: 'Save Success',
                                msg: json["SuccessMsg"],
                                buttons: Ext.MessageBox.OK,
                                icon: Ext.MessageBox.INFO,
                                fn : function(){
                                    searchEqpCell("8", TEMP_WKU_ID);
                                }
                            });
                        }
                        else
                        {
                            Ext.MessageBox.show({
                                //title: 'Error Message',
                                msg: json["ErrorMsg"],
                                buttons: Ext.MessageBox.OK,
                                icon: Ext.MessageBox.INFO
                            });
                        }
                    }
                });


                return true;
            } else {
                return false;
            }
        });
    }
    /**
     * 삭제
     */
    function removeBox(){
        //버튼 체크
        if(checkdisable()){
            return;
        };

        // 기록
        record();

        //check
        //선택한 row 배열
        var nofirst = 0;
        grid03.store.each(function(record){
            if(record.get('ROW_STATUS') == 'U'){
                  nofirst = 1;
            }
         });

        if(nofirst == 1){
            Ext.MessageBox.show({
                //title: 'Error Message',
                //msg: "장비 작업 내역 편집을 종료후 실행해주세요",
                msg: Lang.get('RUN_AFTER_THE_END'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
            return;
        }

        //check
        var rows = grid02.getSelectionModel().getSelection();

        if(rows.length < 1){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "선택된 레코드가 없습니다.",
                msg: Lang.get('NO_ROW_SELECTED'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
            return;
        }

        //선택한 row 배열
        var nofirst = 0;
        grid02.store.each(function(record){
            if(record.get('ROW_STATUS') == 'D'){
                if(record.get('CHT_SEQ') == '1'){
                  nofirst = 1;
                }
            }
         });

        if(nofirst == 1){
            Ext.MessageBox.show({
                //title: 'Error Message',
                //msg: "첫번째 박스는 삭제할 수 없습니다",
                msg: Lang.get('CAN_NOT_REMOVE_A_FRIST_BOX'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
            return;
            //record.set('ROW_DELETE', false);
        }


        Ext.MessageBox.confirm('', '삭제를 하시겠습니까?', function(btn){
            if(btn == "yes"){
                grid02.save(viewPort, '/wkRsltConfirmService/removeBox', {}, function(result, successYn){

                    if(successYn == true){
                        Ext.MessageBox.show({
                            //title: 'Save Success',
                            msg: result.SuccessMsg,
                            buttons: Ext.MessageBox.OK,
                            icon: Ext.MessageBox.INFO,
                            fn : function(){
                                var TEMP_WKU_ID =  grid01.getSelectedRowData('WKU_ID');
                                searchEqpCell("5", TEMP_WKU_ID);
                            }
                        });

                    }


                }, true);
                return true;
            } else {
                return false;
            }
        });
    }
    
    //
    function commonPopWkRsltConfirm(){

        // 기록
        record();
        
        // 
        var OBJ_ALCR_CMD_DT = Ext.ComponentQuery.query('[name=ALCR_CMD_DT]', SEARCH_CONDITION_FORM)[0]; 
        var VALUE_ALCR_CMD_DT =   Ext.Date.format(OBJ_ALCR_CMD_DT.getValue() , 'Ymd');
 
        //
        if(OBJ_ALCR_CMD_DT.getValue() == "null" || OBJ_ALCR_CMD_DT.getValue() == null){
            Ext.MessageBox.show({
                //title: "ddddd", 
                msg: "배치일자는 필수입력 사항입니다.",
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });
            return; 
        }
        
        //
        var param = {
           CURRENT_MENUCODE : "WMS131715"
          ,MODULE           : "WMS"
          ,KEYPARAM         : VALUE_ALCR_CMD_DT
          ,PARAM1           : VALUE_ALCR_CMD_DT
          ,PARAM2           : ""
          ,PARAM3           : ""
          ,PARAM4           : ""
          ,PARAM5           : ""
          ,PARAM6           : ""
          ,PARAM7           : ""
          ,PARAM8           : ""
          ,PARAM9           : ""
          ,PARAM10          : ""
          ,SQLPROP          : "COMMON_WKRSLTCONFIRM_PAGE"
          ,MPROC_YN         : "AND A.MPROC_YN = 'Y'"
          ,WAVE_SCD         : "AND C.WAVE_SCD = '5'"
          ,WH_CD            : "AND B.WH_CD    = 'S11C'"
          ,WK_DATE          : "AND A.WK_DATE  = '" + VALUE_ALCR_CMD_DT +"'"
          ,WK_SEQ           : ""
          ,CURRENT_PAGE     : 1
          ,PAGE_SIZE        : 100
        };

       // eval(OBJ_ALCR_CMD_DT.customPopFunction + "( param )");
        commonPop_wkRsltConfirm(param);
    }
    /**
     * 저장
     */
    function saveEqpWkDesc(){
        //버튼 체크
        if(checkdisable()){
            return;
        };
        // 기록
        record();

        //check
        //선택한 row 배열
        var nofirst = 0;
        grid03.store.each(function(record){
            if(record.get('ROW_STATUS') == 'U'){
                  nofirst = 1;
            }
         });

        if(nofirst == 0){
            Ext.MessageBox.show({
                //title: 'Error Message',
                //msg: "수정한 레코드가 없습니다.",
                msg: Lang.get('HAVE_NO_A_RECORD_UPDATED'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
            return;
        }


        //Ext.MessageBox.confirm('', '수정을 하시겠습니까?', function(btn){
            //if(btn == "yes"){
                grid03.save(viewPort, '/wkRsltConfirmService/saveEqpWkDesc', {}, function(result, successYn){


                    if(successYn == true){
                      Ext.MessageBox.show({
                          //title: 'Save Success',
                          msg: result.SuccessMsg,
                          buttons: Ext.MessageBox.OK,
                          icon: Ext.MessageBox.INFO,
                          fn : function(){
                              var TEMP_WKU_ID =  grid01.getSelectedRowData('WKU_ID');
                              searchEqpCell("6", TEMP_WKU_ID);
                          }
                      });

                    }

                }, true);
                return true;
            //} else {
           //     return false;
            //}
        //});
    }

    // 기록
    function record(){
        //
        var rows01 = grid01.getSelectionModel().getSelection();
        var rows02 = grid02.getSelectionModel().getSelection();
        var rows03 = grid03.getSelectionModel().getSelection();

        //
        try{
          if(!Ext.isObject(history01)){
              history01 = new Ext.util.HashMap();
              history01.add('1', 0); //첫번째 레코드라고 생각해서 저장
          }
        } catch(e){
            history01 = new Ext.util.HashMap();
              history01.add('1', 0); //첫번째 레코드라고 생각해서 저장
        }
        try{
          if(!Ext.isObject(history02)){
              history02 = new Ext.util.HashMap();
              history02.add('1', 0); //첫번째 레코드라고 생각해서 저장
          }
        } catch(e){
            history02 = new Ext.util.HashMap();
          history02.add('1', 0); //첫번째 레코드라고 생각해서 저장
        }
        try{
          if(!Ext.isObject(history03)){
              history03 = new Ext.util.HashMap();
              history03.add('1', 0); //첫번째 레코드라고 생각해서 저장
          }
        } catch(e){
            history03 = new Ext.util.HashMap();
          history03.add('1', 0); //첫번째 레코드라고 생각해서 저장
        }

        //과거 위치로 다시 조정
        var index01 = 0;
        var index02 = 0;
        var index03 = 0;

        if(rows01.length >= 1){
            grid01.getStore().each(function(record){
                if(record.id == rows01[0].id){
                    index01 = grid01.getStore().indexOf(record);
                    history01.add((history01.length+1), index01);
                }
            });
        }
        if(rows02.length >= 1){
            grid02.getStore().each(function(record){
                if(record.id == rows02[0].id){
                    index02 = grid02.getStore().indexOf(record);
                    history02.add((history02.length+1), index02);
                }
            });
        }
        if(rows03.length >= 1){
            grid03.getStore().each(function(record){
                if(record.id == rows03[0].id){
                    index03 = grid03.getStore().indexOf(record);
                    history03.add((history03.length+1), index03);
                }
            });
        }
    }

    // 버튼 체크
    function checkdisable(){

        // 버튼
        var confirmEqpSeqWkConfirmBtn = Ext.ComponentQuery.query('[itemId=confirmEqpSeqWkConfirmBtn]', grid01)[0];//장비차수 작업확정
        var addBoxBtn = Ext.ComponentQuery.query('[itemId=addBoxBtn]', grid02)[0];//박스 추가
        var removeBoxBtn = Ext.ComponentQuery.query('[itemId=removeBoxBtn]', grid02)[0];//삭제
        var saveEqpWkDescBtn = Ext.ComponentQuery.query('[itemId=saveEqpWkDescBtn]', grid03)[0];//저장


        var OBJ_WAVE_STATUS       = Ext.ComponentQuery.query('[name=WAVE_STATUS]', SEARCH_CONDITION_FORM)[0];
        var OBJ_MPROC_YN          = Ext.ComponentQuery.query('[name=MPROC_YN]', SEARCH_CONDITION_FORM)[0];
        var OBJ_COUNTING_SCD      = Ext.ComponentQuery.query('[name=COUNTING_SCD]', SEARCH_CONDITION_FORM)[0];


        if(OBJ_WAVE_STATUS.getValue() == null || OBJ_WAVE_STATUS.getValue() == ""){
            return false;
        }
        if(OBJ_MPROC_YN.getValue() == null || OBJ_MPROC_YN.getValue() == ""){
            return false;
        }
        if(OBJ_COUNTING_SCD.getValue() == null || OBJ_COUNTING_SCD.getValue() == ""){
            return false;
        }


        // 비활성화 대신에 메세지로 출력
        // 아래의 조건이 한개라도
        // WAVE상태코드(WAVE_SCD) = 5
        // 수처리여부(MPROC_YN) =  Y
        // 진행상태(WK_PROC_SCD) = 39
        if( OBJ_WAVE_STATUS.getValue() != "5" ){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "웨이브상태가 할당일 때만 가능합니다.",
                msg: Lang.get('WHEN_ASSIGN_WAVE'), 
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });

            return true;

        }
        if(OBJ_MPROC_YN.getValue() != "Y" ){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "수작업 여부가 Y일때만 가능합니다.",
                msg: Lang.get('WHEN_MPROC_YN_IS_Y'), 
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });

           return true;
        }

        if( OBJ_COUNTING_SCD.getValue() != "39"){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "진행상태가 지시확정일 때만 가능합니다.",
                msg: Lang.get('WHEN_WK_PROC_SCD_IS_39'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
           });

            return true;

        }  
        // 비활성화 조건
        // 아래의 조건이 한개라도
        // WAVE상태코드(WAVE_SCD) = 5
        // 수처리여부(MPROC_YN) =  Y
        // 진행상태(WK_PROC_SCD) = 39
        //if(WAVE_SCD == "5" && MPROC_YN == "Y" && WK_PROC_SCD == "39" ){
        //} else {
          //테스트 때문에 일시 정지
        //  confirmEqpSeqWkConfirmBtn.disabled = true;
        //  addBoxBtn.disabled = true;
        //  removeBoxBtn.disabled = true;
        //  saveEqpWkDescBtn.disabled = true;
        //}
    }
</script>
</head>
<body>

</body>
</html>