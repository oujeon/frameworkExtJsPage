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
    // 웨이브
    grid01 = Ext.create('VC.grid.CommonGrid', {
        idPrefix : 'grid01',
        titleText : 'WAVE',
        region : 'center',
        autoScroll : true,
        useCheckboxModel : true, //헤더 체크박스
        editable : false, // 그리드 cell edit
        columnDefine : [
             {type   : 'gridrownumber', width:40}
            ,{header : 'ALCR_CMD_DT', colName : 'ALCR_CMD_DT',  type : 'date', dateFormat : 'Ymd', renderFormat : 'DF_YMD',  align : 'center', width : 80} //배차일자
            ,{header : 'MENU_OWNER', colName : 'STRR_NM', align : 'center', width : 110, hidden : true, hideable : false}  //화주
            ,{header : 'WAVE_NO', colName : 'WAVE_NO', align : 'center', width : 80}  //웨이브 번호
            ,{header : 'WAVE_DESCR', colName : 'DESCR', align : 'left', width : 200}  //설명
            ,{header : 'WAVE_STATUS', colName : 'WAVE_SCD', type : 'combobox', comboParam : {SQLPROP : 'CODE', KEYPARAM : 'WAVE_SCD'}, align : 'center', width : 90, editable : false}  //WAVE상태코드
            ,{header : 'UPD_DATETIME', colName : 'UPD_DATETIME', align : 'center', width : 130}  //수정일시
            ,{header : 'UPD_PERSON_ID', colName : 'UPD_PERSON_ID', align : 'center'}  //수정자
            //hidden
            ,{header : 'STRR_ID', colName : 'STRR_ID', align : 'center', hidden : true, hideable : false}  //화주코드
            ,{header : 'WAVE_TCD', colName : 'WAVE_TCD', align : 'center', hidden : true, hideable : false}  //WAVE유형코드
            ,{header : 'WH_CD', colName : 'WH_CD', align : 'center', hidden : true, hideable : false}  //창고코드
        ],
        buttonsConfig: [
             {text: 'SEARCH', authType : 'R', handler : searchWave}
            ,{text: 'CONFIRM', authType : 'ACT', handler : confirmWave}
        ],
        listeners : {
            cellclick : function(view, td, cellIndex, record, tr, rowIndex, eventObj, eOpts) {
                var TEMP_WH_CD = record.get('WH_CD');
                var TEMP_WAVE_NO = record.get('WAVE_NO');
                var TEM_ALCR_CMD_DT = Ext.Date.format(record.get('ALCR_CMD_DT'), 'Ymd');
                var TEMP_WK_DATE = TEM_ALCR_CMD_DT;
                searchEqpseq(TEMP_WH_CD, TEMP_WAVE_NO, TEMP_WK_DATE);
            }
        }
    });
    //장비차수
    grid02 = Ext.create('VC.grid.CommonGrid', {
        idPrefix : 'grid02',
        titleText : 'EQP_SEQ',
        region : 'east',
        autoScroll : true,
        useCheckboxModel : true, //헤더 체크박스
        editable : true,
        updateOnly : true,
        columnDefine : [
             {type   : 'gridrownumber', width:40}
            ,{header : 'WKG_ID', colName : 'WKG_ID', align : 'center', editable:false,  hidden : true, hideable : false} //워크 그룹
            ,{header : 'ORDERS', colName : 'SEL_ORDER', align : 'center', editable:false,  hidden : true, hideable : false} //순서
            ,{header : 'WORK_UNIT', colName : 'WKU_ID', align : 'center', editable:false} //워크유닛 아이디
            ,{header : 'WK_DATE', colName : 'WK_DATE', align : 'center',   editable:false, type : 'date', dateFormat : 'Ymd', renderFormat : 'DF_YMD',  align : 'center', width : 80} //워크일자
            ,{header : 'WK_SEQ', colName : 'WK_SEQ', align : 'center', editable:false , width : 60} //워크차수
            ,{header : 'EQP_ID', colName : 'EQP_ID', align : 'center', editable:false,  hidden : true, hideable : false} //장비아이디
            ,{header : 'EQP_NAME', colName : 'EQP_NM', align : 'center', editable:false} //장비명
            ,{header : 'EQP_SEQ', colName : 'EQP_SEQ', align : 'center', editable:false , width : 60} //장비차수
            ,{header : 'MPROC_YN', colName : 'MPROC_YN', align : 'center', type :'checkbox', editable:true } //수처리여부
            ,{header : 'WK_PROC_SCD', colName : 'WK_PROC_SCD', editable:false , width : 110, type : 'combobox', comboParam : {SQLPROP : 'CODE', KEYPARAM : 'WK_PROC_SCD'}, align : 'center', width : 70, editable : false}  //진행상태
            ,{header : 'EQUIPMENT_STRATEGY', colName : 'EQP_STG_ID', align : 'center', editable:false} //장비전략
            ,{header : 'UPD_DATETIME', colName : 'UPD_DATETIME', align : 'center' , width : 130, editable:false} //수정일시
            ,{header : 'UPD_PERSON_ID', colName : 'UPD_PERSON_ID', align : 'center', editable:false} //수정자
            //hidden
            ,{header : 'WH_CD', colName : 'WH_CD', align : 'center', editable:false , hidden : true, hideable : false} //창고코드
            ,{header : 'WAVE_NO', colName : 'WAVE_NO', align : 'center', editable:false , hidden : true, hideable : false} //웨이브번호

        ],
        buttonsConfig: [
             {text: '분배작업지시서 출력', authType : 'ACT', menu : [
                                                             {text : 'CELL_KIND', handler : function(){printBox('1');}} //셀별
                                                            ,{text : 'INVN_PRD', handler :  function(){printBox('2');}} //상품별
                                                         ],
                                                         iconCls : 'icon-output'}
            ,{text: 'SAVE', authType : 'IUD', handler : saveMprocYn},
        ],
        listeners : {  
            cellclick : function(view, td, cellIndex, record, tr, rowIndex, eventObj, eOpts) {  
                if(cellIndex != 10){
                    searchWkinst();
                }
                // 진행상태 39미만이면 출력을 중지 
                var OBJ_BUTTON      = Ext.ComponentQuery.query('button[authType=ACT]', grid02)[0];  
                var TEMP_WK_PROC_SCD =  grid02.getSelectedRowData('WK_PROC_SCD'); 
                if((TEMP_WK_PROC_SCD*1) < 39){
                    OBJ_BUTTON.setDisabled(true);
                } else {
                    OBJ_BUTTON.setDisabled(false);
                }
            }
        }
    });
    //작업지시
    grid03 = Ext.create('VC.grid.CommonGrid', {
        idPrefix : 'grid03',
        titleText : 'WKINST',
        region : 'south',
        flex : 1.5,
        autoScroll : true,
        useCheckboxModel : true, //헤더 체크박스
        selModel : Ext.create('Ext.selection.CheckboxModel', {
            checkOnly: true,
            injectCheckbox:'first',
            ignoreRightMouseSelection : true,
            mode:Util.nvl(this.selectionMode, 'MULTI')
        }),
        editable : false,
        columnDefine : [
              {type : 'gridrownumber', width:40}
            , {header : 'WORK_UNIT', colName : 'WKU_ID', align : 'center'}//워크유닛 아이디
            , {header : 'CELL', colName : 'CHT_NO', align : 'center', width:50}//슈트번호
            , {header : 'BOX', colName : 'CHT_SEQ', align : 'center', width:50}//차수
            , {header : 'WKI_SEQ', colName : 'WKI_SEQ', align : 'center', width:50}//순번
            , {header : 'PRD_CD', colName : 'PRD_CD', align : 'center', width:80}//상품코드
            , {header : 'ITEM_NM', colName : 'ITEM_NM', align : 'left', width:200}//상품명
            , {header : 'INS_QTY', colName : 'INIT_IQTY', align : 'right', width:60}//지시수량 
            , {header : 'DISPATCH_NO', colName : 'SCAN_BAR', align : 'center', width:200}//배차번호 
            , {header : 'WKI_SRC_CD', colName : 'WKI_SRC_CD', editable:false , width : 110, type : 'combobox', comboParam : {SQLPROP : 'CODE', KEYPARAM : 'WKI_SRC_CD'}, align : 'center', width : 70, editable : false}  //지시출처    
            , {header : 'SHIPMENTNO', colName : 'OUTB_NO', align : 'center'}//출고번호
            , {header : 'UPD_DATETIME', colName : 'UPD_DATETIME', align : 'center'}//수정일시
            , {header : 'UPD_PERSON_ID', colName : 'UPD_PERSON_ID', align : 'center'}//수정자
        ],
        buttonsConfig: [
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
                        region : 'center',
                        layout : 'fit',
                        split : true,
                        flex : 0.4,
                        border : 0,
                        bodyCls : 'grid-right-line',
                        items : [grid01]
                    },
                    {
                        region : 'east',
                        collapseMode:'mini',
                        layout : 'fit',
                        split : true,
                        flex : 0.6,
                        border : 0,
                        bodyCls : 'grid-left-line',
                        items : [grid02]
                    }
                ]
            },
            grid03
        ],
        listeners : {
            render : function(me, eOpts){
                if(SEARCH_CONDITION_FORM) me.add(SEARCH_CONDITION_FORM);
            }
        }
    });
    }
    /**********************************************************************************************************
    FUNCTION 정의
    **********************************************************************************************************/
    /**
     * searchWave
     */
    function searchWave(){

        // 1. 조회조건 폼 밸리데이션 후 조회조건 데이터셋 DS_SEARCHCONDITION 셋팅.
        if( ! setSearchConditionDataSet() ) return;

        //다이나믹 쿼리에서 제거
          if( !filterRemoveSearchConditionDataSet([  'WAVE_NO']) ) return;

        //사용자 정의 다이나믹 파라메터 정의

         var TEM_ALCR_CMD_DT = Ext.Date.format(getSearchConditionValue('ALCR_CMD_DT'), 'Ymd');

         //if(TEM_ALCR_CMD_DT != ''){
         //    TEM_ALCR_CMD_DT = "AND C.ALCR_CMD_DT = '" + TEM_ALCR_CMD_DT + "'";
         //} else {
         //    TEM_ALCR_CMD_DT = '';
         //}

        var TEMP_WH_CD =  window.top.UserInfo.userWcode ;

        var params = {
                 WH_CD       : TEMP_WH_CD
               , ALCR_CMD_DT : TEM_ALCR_CMD_DT
	           , WAVE_NO     : searchCondition('WAVE_NO'     ,'WAVE_NO'      ,'D')
        };  //

        //99
        //console.log("params : %o", params);

        // 2. reset

        //reset
        grid01.reset();
        grid02.reset();
        grid03.reset();

        // 3. 조회  
        grid01.search(viewPort, '/wkInstService/searchWave', params, null,  function(result, successYn) {

            if(successYn && result["DS_OUT"].length > 0) { //자료가 있다면 grid02을 검색
                grid01.getSelectionModel().deselectAll(); // 초기 한건 선택 제외

                var TEMP_WH_CD =  grid01.getSelectedRowData('WH_CD');
                var TEMP_WAVE_NO = grid01.getSelectedRowData('WAVE_NO');
                var TEM_ALCR_CMD_DT = Ext.Date.format(grid01.getSelectedRowData('ALCR_CMD_DT'), 'Ymd');
                var TEMP_WK_DATE = TEM_ALCR_CMD_DT;

                searchEqpseq(TEMP_WH_CD, TEMP_WAVE_NO, TEMP_WK_DATE);
            } 

        }, true);
    }

    /**
     * confirmWave
     */
    function confirmWave(){ 
        
        var dataToSend = [];
        var url = '/wkInstService/confirmWave';
        var obj = {};

        var rows = grid01.getSelectionModel().getSelection();

        if(rows.length < 1){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: "선택된 웨이브가 없습니다",
                msg: Lang.get('HAVE_NO_WAVE_CHOICED'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });

            return;
        }
        var TEMP_WAVE_SCD = grid01.getSelectedRowData('WAVE_SCD');

        var TEMP_WH_CD    = grid01.getSelectedRowData('WH_CD');
        var TEMP_WAVE_NO  = grid01.getSelectedRowData('WAVE_NO');
        var TEMP_USER_ID  = grid01.getSelectedRowData('UPD_PERSON_ID');
        var TEMP_DBMS_OUTPUT_YN = 'Y';

        // 상태코드가 할당(5)인 것만 확정을 한다.
        if(TEMP_WAVE_SCD != '5'){
            Ext.MessageBox.show({
                //title: "ddddd",
                //msg: '할당 상태의 웨이브만 확정이 가능합니다',
                msg: Lang.get('CAN_COMPELTE_WHEN_WAVE_IS_ASSIGN'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
            return;
        } 
        
        Ext.MessageBox.confirm('', '선택 웨이브에 속한 장비 작업지시 전체를 확정하시겠습니까?', function(btn){ 
            
            if(btn == "yes"){
               obj["I_WH_CD"] = TEMP_WH_CD;
               obj["I_WAVE_NO"] = TEMP_WAVE_NO;
               obj["I_USER_ID"] = TEMP_USER_ID;
               obj["I_DBMS_OUTPUT_YN"] = TEMP_DBMS_OUTPUT_YN;
               obj["O_ERR_CD"] = "";
               obj["O_ERR_ARG"] = "";
               obj["O_DEB_MSG"] = "";

               dataToSend.push(obj); 
               
               var gridMask = new Ext.LoadMask(viewPort, {msg:"Loading..."});
               gridMask.show();// loadmask start 
               
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
                               msg: json["SuccessMsg"],
                               buttons: Ext.MessageBox.OK,
                               icon: Ext.MessageBox.INFO,
                               fn : function(){ 
                                   searchWave();
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
           } else {
               return;
           }
        });
    }
    /**
     * saveEqpseq
     */
    function searchEqpseq(WH_CD, WAVE_NO, WK_DATE){

        // 1. 조회조건 폼 밸리데이션 후 조회조건 데이터셋 DS_SEARCHCONDITION 셋팅.
        // if( ! setSearchConditionDataSet() ) return;

        //다이나믹 쿼리에서 제거
        if( !filterRemoveSearchConditionDataSet(['ALCR_CMD_DT','WAVE_CD']) ) return;

        //
        var TEM_WH_CD   = "AND B.WH_CD = '" + WH_CD + "'";
        var TEM_WAVE_NO = "AND B.WAVE_NO = '" + WAVE_NO + "'";
        var TEM_WK_DATE = "AND A.WK_DATE = '" + WK_DATE + "'";

        //
        var params = {
              WH_CD   : TEM_WH_CD
            , WAVE_NO : TEM_WAVE_NO
            , WK_DATE : TEM_WK_DATE
        };

        //99.debug
        // console.log("params : %o", params);6

        // 2. reset
        grid02.reset();  
        grid03.reset();
        
        // 3. 조회
        grid02.search(viewPort, '/wkInstService/searchEqpSeq', params,  null,   function(result, successYn) { 
            
            if(successYn && result["DS_OUT"].length > 0) { //자료가 있다면 grid02을 검색 
             searchWkinst();
             // 진행상태 39미만이면 출력을 중지 
             var OBJ_BUTTON      = Ext.ComponentQuery.query('button[authType=ACT]', grid02)[0];  
             var TEMP_WK_PROC_SCD =  grid02.getSelectedRowData('WK_PROC_SCD'); 
             if((TEMP_WK_PROC_SCD*1) < 39){
                 OBJ_BUTTON.setDisabled(true);
             } else {
                 OBJ_BUTTON.setDisabled(false);
             }
            }
        }, true);
    }
    /**
     * saveMprocYn
     */
    function saveMprocYn(){  
        
        var saveChk=0;
        grid02.store.each(function(record){ 
            if(record.get('ROW_STATUS') == 'U'){ 
                saveChk = 1; 
            }
       });
        
        if(saveChk==0){
            Ext.MessageBox.show({
                //title: 'Error Message',
                msg: Lang.get('NO_DATA_TO_SAVE'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });  
            return;
        }  
        
        
        //진행상태가 ’20’ 이하인 행에 대해서만 편집 및 저장이 가능
        var chk = 0;
        grid02.store.each(function(record){ 
            if(record.get('ROW_STATUS') == 'U'){
                if((record.get('WK_PROC_SCD')*1) >  (20*1) ){  
                    record.set("MPROC_YN", record.raw["MPROC_YN"]);  
                    chk = 1;
                }
            }
       });
        
        if(chk==1){
            Ext.MessageBox.show({
                //title: 'Error Message',
                //msg: "진행상태가  '지시생성' 일때만 변경할 수 있습니다.",
                msg: Lang.get('CAN_WHEN_WK_PROC_SCD_IS_THAN_20'),
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });  
            //상태 원복
            grid02.store.each(function(record){ 
             record.set("MPROC_YN", record.raw["MPROC_YN"]);   
           });
            
            return;
        }
        

        //1. 
        var TEMP_WH_CD = grid02.getSelectedRowData('WH_CD');

        //2.  
        //3.
        var params = {  WH_CD  : TEMP_WH_CD };
        
        //99. debug
        //console.log(" params : %o", params);
        Ext.MessageBox.confirm('', '저장을 하시겠습니까?', function(btn){
            if(btn == "yes"){
                //4.
                grid02.save(viewPort, '/wkInstService/saveMprocYn', params, function(result, successYn){
                    //재조회시
                    var TEMP_WH_CD      = grid01.getSelectedRowData('WH_CD');
                    var TEMP_WAVE_NO    = grid01.getSelectedRowData('WAVE_NO');
                    var TEM_ALCR_CMD_DT = Ext.Date.format(grid01.getSelectedRowData('ALCR_CMD_DT'), 'Ymd');
                    var TEMP_WK_DATE    = TEM_ALCR_CMD_DT;
                    //
                    searchEqpseq(TEMP_WH_CD, TEMP_WAVE_NO, TEMP_WK_DATE);
                }, true );

                return true;
            } else {
                return false;
            }
        });

    }
    /**
     * searchWkinst
     */
    function searchWkinst(){
        // 1. 조회조건 폼 밸리데이션 후 조회조건 데이터셋 DS_SEARCHCONDITION 셋팅.
        // if( ! setSearchConditionDataSet() ) return;

        //다이나믹 쿼리에서 제거
        if( !filterRemoveSearchConditionDataSet(['ALCR_CMD_DT','WAVE_CD']) ) return;

        var TEMP_WKU_ID   = grid02.getSelectedRowData('WKU_ID');
        var TEMP_WKG_ID   = grid02.getSelectedRowData('WKG_ID');
        var TEMP_WAVE_NO  = grid02.getSelectedRowData('WAVE_NO');
        var TEMP_OWNER_ID = grid01.getSelectedRowData('STRR_ID');

        //
        var PARAM_WKU_ID   = "AND A.WKU_ID   = '" + TEMP_WKU_ID + "'";
        var PARAM_WKG_ID   = "AND A.WKG_ID   = '" + TEMP_WKG_ID + "'";
        var PARAM_WAVE_NO  = "AND B.WAVE_NO  = '" + TEMP_WAVE_NO + "'";
        //var PARAM_OWNER_ID = "AND A.OWNER_ID = " + TEMP_OWNER_ID + "";

        //
        var params = {
              WKU_ID   : PARAM_WKU_ID
            , WKG_ID   : PARAM_WKG_ID
            , WAVE_NO  : PARAM_WAVE_NO
           // , OWNER_ID : PARAM_OWNER_ID
        };

        //99.debug

        // 2. reset
        grid03.reset();

        // 3. 조회
        grid03.search(viewPort, '/wkInstService/searchWkinst', params,null,   function(result, successYn) {
            if(successYn && result["DS_OUT"].length > 0) { //자료가 있다면 grid02을 검색
               grid03.getSelectionModel().selectAll();
            }
        }, true);
    }
    /**
     * printBox
     */
    function printBox(cmd){
        /* 셀별, 상품별(동일)
        파일명
        셀별  jobOrderCell
        상품별 jobOrderItem

        컬럼명
        WKU_ID  WKU_ID
        searchParam WKU_ID + CHT_NO

        하드코딩값
        WKU_ID  000000000254'
        searchParam 0000000002541','0000000002542','0000000002543','0000000002544','0000000002545','0000000002546','0000000002547','0000000002548','0000000002549','00000000025410','00000000025411','00000000025412'
 */
        var ozrord = "";
        if(cmd == '1'){ //셀
            ozrord = "jobOrderCell";
        } else if(cmd == '2'){//메뉴
            ozrord = "jobOrderItem";
        }
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

        var WKUIDCHTNO = "";

        var paramsForReport = "WKU_ID";
        var reportSetting = {
               // searchParam : '0000000002541',
                popWinTitle : 'MENU_RECEIVINGNOTICE',//레포트 타이틀
                ozViewerId : 'MENU_RECEIVINGNOTICE',//레포트 개별ID
                popWinOptions : 'width=1100 height=700 left=2 top=75 resizable=yes scrollbars=no toolbar=no menubar=no location=no', //레포트 팝업 옵션
                //width : 800, //레포트 고정크기 레포트 내부창을 고정하게 됨
                //height : 900, //레포트 고정크기 레포트 내부창을 고정하게 됨
                ozr : ozrord, //ozr명 .ozr 없이
                odi : ozrord, //odi명 .odi 없이
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
</script>
</head>
<body>

</body>
</html>