<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/ui.jqgrid.css" />

<div class="row">
	<div class="col-xs-12">
		<button class="btn btn-info"  onclick="addRow()">新增
			<i class="ace-icon glyphicon glyphicon-plus"></i></button>
		<table id="grid-table"></table>


		<script type="text/javascript">
            var $path_base = "${contextPath}/static";//in Ace demo this will be used for editurl parameter
		</script>

		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
    var scripts = [ null, "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js", "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js", null ]
    $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        // inline scripts related to this page
        jQuery(function($) {
            var grid_selector = "#grid-table";
            var pager_selector = "#grid-pager";

            // resize to fit page size
            $(window).on('resize.jqGrid', function() {
                $(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
            })
            // resize on sidebar collapse/expand


            jQuery(grid_selector).jqGrid({

                subGrid : false,
                url : "${contextPath}/sys/cluster/getClusterName",
                datatype : "json",
                height : 450,
                colNames : ['序号','可选集群', '场景文件', '操作'],
                colModel : [{
                    name : '序号',
                    index : '',
                    width : 20,

                }, {
                    name : '',
                    index : '',
                    label : '可选集群',
                    width : 400,
                    fixed : true,
                    sortable : false,
                    resize : false,
                    formatter : 'actions',


                }, {
                    name : 'file',
                    index : '',
                    label : '场景文件',
                    width : 200,

                    editoptions : {size : "20", maxlength : "20"},
                    formatter: function (value, grid, rows, state) {

						/*  return "<input id='lefile' type='file' style='display:none'>"+
						 "<div class='input-append'><input id='photoCover' class='input-large' type='text' style='height:30px;''>"+
						 "<a class='btn' onclick='$('input[id=lefile]').click();''>Browse</a></div>"  */

                        return "<input type='file'>"

                    }

                }, {
                    name : 'handal',
                    index : '',
                    label : '操作',
                    width : 90,

                    editoptions : {size : "20", maxlength : "40"},
                    formatter: function (value, grid, rows, state) {
                        return "<a href=\"#\" style=\"color:#f60\" onclick=\"Modify("+rows.id+")\">提交</a>"
                    }
                }],
                //scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
                sortname : "id",
                sortorder : "asc",
                viewrecords : true,
                rowNum : 10,
                rowList : [ 10, 20, 30 ],
                //	pager : pager_selector,
                altRows : true,
                //toppager : true,
                multiselect : false,
                //multikey : "ctrlKey",
                multiboxonly : true,
                loadComplete : function() {
                    var table = this;
                    setTimeout(function(){
                        styleCheckbox(table);
                        updateActionIcons(table);
                        updatePagerIcons(table);
                        enableTooltips(table);
                    }, 0);
                },
                editurl : "${contextPath}/sys/cluster/operateDict"
                //caption : "用户管理列表",
                //autowidth : true,
                /**
                 grouping : true,
                 groupingView : {
        				 groupField : ['name'],
        				 groupDataSorted : true,
        				 plusicon : 'fa fa-chevron-down bigger-110',
        				 minusicon : 'fa fa-chevron-up bigger-110'
        			},
                 */
            });



            $(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size

            // enable search/filter toolbar
            // jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
            // jQuery(grid_selector).filterToolbar({});
            // switch element when editing inline
            function aceSwitch(cellvalue, options, cell) {
                setTimeout(function() {
                    $(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
                }, 0);
            }

            // navButtons
            jQuery(grid_selector).jqGrid('navGrid', pager_selector, { // navbar options
                edit : <shiro:hasPermission name="${ROLE_KEY}:dict:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:dict:edit">false</shiro:lacksPermission>,
                editicon : 'ace-icon fa fa-pencil blue',
                add : <shiro:hasPermission name="${ROLE_KEY}:dict:add">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:dict:add">false</shiro:lacksPermission>,
                addicon : 'ace-icon fa fa-plus-circle purple',
                del : <shiro:hasPermission name="${ROLE_KEY}:dict:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:dict:delete">false</shiro:lacksPermission>,
                delicon : 'ace-icon fa fa-trash-o red',
                search : <shiro:hasPermission name="${ROLE_KEY}:dict:search">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:dict:search">false</shiro:lacksPermission>,
                searchicon : 'ace-icon fa fa-search orange',
                refresh : true,
                refreshicon : 'ace-icon fa fa-refresh blue',
                view : <shiro:hasPermission name="${ROLE_KEY}:dict:view">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:dict:view">false</shiro:lacksPermission>,
                viewicon : 'ace-icon fa fa-search-plus grey'
            }, {
                // edit record form
                // closeAfterEdit: true,
                // width: 700,
                recreateForm : true,
                beforeShowForm : function(e) {
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                    style_edit_form(form);
                },
                errorTextFormat: function (response) {
                    var result = eval('('+response.responseText+')');
                    return result.message;
                }
            }, {
                // new record form
                // width: 700,
                closeAfterAdd : true,
                recreateForm : true,
                viewPagerButtons : false,
                beforeShowForm : function(e) {
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                    style_edit_form(form);
                },
                errorTextFormat: function (response) {
                    var result = eval('('+response.responseText+')');
                    return result.message;
                }
            }, {
                // delete record form
                recreateForm : true,
                beforeShowForm : function(e) {
                    var form = $(e[0]);
                    if (form.data('styled'))
                        return false;
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                    style_delete_form(form);
                    form.data('styled', true);
                },
                onClick : function(e) {
                    // alert(1);
                }
            }, {
                // search form
                recreateForm : true,
                afterShowSearch : function(e) {
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                    style_search_form(form);
                },
                afterRedraw : function() {
                    style_search_filters($(this));
                },
                multipleSearch : true
                /**
                 * multipleGroup:true, showQuery: true
                 */
            }, {
                // view record form
                recreateForm : true,
                beforeShowForm : function(e) {
                    var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                }
            })

            // add custom button to export the data to excel
            if(<shiro:hasPermission name="${ROLE_KEY}:dict:export">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:dict:export">false</shiro:lacksPermission>){
                jQuery(grid_selector).jqGrid('navButtonAdd', pager_selector,{
                    caption : "",
                    title : "导出Excel",
                    buttonicon : "ace-icon fa fa-file-excel-o green",
                    onClickButton : function () {
                        var keys = [], ii = 0, rows = "";
                        var ids = $(grid_selector).getDataIDs(); // Get All IDs
                        var row = $(grid_selector).getRowData(ids[0]); // Get First row to get the labels
                        //var label = $(grid_selector).jqGrid('getGridParam','colNames');
                        for (var k in row) {
                            keys[ii++] = k; // capture col names
                            rows = rows + k + "\t"; // output each Column as tab delimited
                        }
                        rows = rows + "\n"; // Output header with end of line
                        for (i = 0; i < ids.length; i++) {
                            row = $(grid_selector).getRowData(ids[i]); // get each row
                            for (j = 0; j < keys.length; j++)
                                rows = rows + row[keys[j]] + "\t"; // output each Row as tab delimited
                            rows = rows + "\n"; // output each row with end of line
                        }
                        rows = rows + "\n"; // end of line at the end
                        var form = "<form name='csvexportform' action='${contextPath}/sys/dict/operateDict?oper=excel' method='post'>";
                        form = form + "<input type='hidden' name='csvBuffer' value='" + encodeURIComponent(rows) + "'>";
                        form = form + "</form><script>document.csvexportform.submit();</sc" + "ript>";
                        OpenWindow = window.open('', '');
                        OpenWindow.document.write(form);
                        OpenWindow.document.close();
                    }
                });
            }

            function style_edit_form(form) {
                // form.find('input[name=statusCn]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
                // don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
                // .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');

                // update buttons classes
                var buttons = form.next().find('.EditButton .fm-button');
                buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();// ui-icon, s-icon
                buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
                buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')

                buttons = form.next().find('.navButton a');
                buttons.find('.ui-icon').hide();
                buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
                buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
            }

            function style_delete_form(form) {
                var buttons = form.next().find('.EditButton .fm-button');
                buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();// ui-icon, s-icon
                buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
                buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
            }

            function style_search_filters(form) {
                form.find('.delete-rule').val('X');
                form.find('.add-rule').addClass('btn btn-xs btn-primary');
                form.find('.add-group').addClass('btn btn-xs btn-success');
                form.find('.delete-group').addClass('btn btn-xs btn-danger');
            }
            function style_search_form(form) {
                var dialog = form.closest('.ui-jqdialog');
                var buttons = dialog.find('.EditTable')
                buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
                buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
                buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
            }

            function beforeDeleteCallback(e) {
                var form = $(e[0]);
                if (form.data('styled'))
                    return false;
                form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                style_delete_form(form);
                form.data('styled', true);
            }

            function beforeEditCallback(e) {
                var form = $(e[0]);
                form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                style_edit_form(form);
            }








            // it causes some flicker when reloading or navigating grid
            // it may be possible to have some custom formatter to do this as the grid is being created to prevent this
            // or go back to default browser checkbox styles for the grid
            function styleCheckbox(table) {
                /**
                 * $(table).find('input:checkbox').addClass('ace') .wrap('<label />') .after('<span class="lbl align-top" />') $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
                 * .find('input.cbox[type=checkbox]').addClass('ace') .wrap('<label />').after('<span class="lbl align-top" />');
                 */
            }

            // unlike navButtons icons, action icons in rows seem to be hard-coded
            // you can change them like this in here if you want
            function updateActionIcons(table) {
                /**
                 * var replacement = { 'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue', 'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red', 'ui-icon-disk' : 'ace-icon fa fa-check green', 'ui-icon-cancel' :
        			 * 'ace-icon fa fa-times red' }; $(table).find('.ui-pg-div span.ui-icon').each(function(){ var icon = $(this); var $class = $.trim(icon.attr('class').replace('ui-icon', '')); if($class in replacement)
        			 * icon.attr('class', 'ui-icon '+replacement[$class]); })
                 */
            }

            // replace icons with FontAwesome icons like above
            function updatePagerIcons(table) {
                var replacement = {
                    'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
                    'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
                    'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
                    'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
                };
                $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function() {
                    var icon = $(this);
                    var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

                    if ($class in replacement)
                        icon.attr('class', 'ui-icon ' + replacement[$class]);
                })
            }

            function enableTooltips(table) {
                $('.navtable .ui-pg-button').tooltip({
                    container : 'body'
                });
                $(table).find('.ui-pg-div').tooltip({
                    container : 'body'
                });
            }

            // var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

            $(document).one('ajaxloadstart.page', function(e) {
                $(grid_selector).jqGrid('GridUnload');
                $('.ui-jqdialog').remove();
            });

        });
    });





    function Modify(id) {
        alert("提交成功");
        //-------todo
    }




    var count=1;//record selectoe index
    $(function(){  //add row
        addRow();
        $('input[id=lefile]').change(function() {
            $('#photoCover').val($(this).val());
        });
    });



    function  addRow(){
        setTimeout(addElements,300)
        setTimeout(fillData,400)//加载数据
    }



    function fillData(){
        var url="${contextPath}/sys/cluster/getClusterName";
        $.get(url, null,
            function(data){
                handal(data);
            });
    }



    function handal(data) {     //请求成功后调用的callback(data)方法

        // $("#pageTable tbody").empty();

        var clusterNames= new Array();
        clusterNames=data.split(",");
        var selector = document.getElementById("clusters_"+(count-1));
        for (var i = 0; i<clusterNames.length; i++) {
            var op = document.createElement("option");
            op.setAttribute("value",clusterNames[i]);
            op.innerHTML = clusterNames[i];
            selector.appendChild(op);
        }
    }


    function addElements(){
        var  trObj = $("<tr class='ui-widget-content jqgrow ui-row-ltr'><td >"+count+"</td>" +
            "<td ><select class='form-control' id=clusters_"+count+" ></select></td>"+
            "<td><input type='file'></td>"+
            "<td><button class='btn btn-white'  onclick='Modify()'>提交</button></td>"+
            "<td></td></tr>");




		/*  var  trObj = $("<tr class='tr_odd'><td></td>"+
		 "<td><select class='form-control' id=clusters_"+count+"></select></td>"+
		 "<td><input id='lefile' type='file' style='display:none'>"+
		 "<div class='input-append'>"+
		 "<input id='photoCover' class='input-large' type='text' style='height:30px;'>"+
		 "<a class='btn' onclick='$('input[id=lefile]').click();'/'>Browse</a></div></td>"+
		 "<td><button class='btn btn-success active'  onclick='Modify()'>提交</button></td>"+
		 "<td></td></tr>"); */
        count=count+1;
        $("#grid-table tbody").append(trObj);
    }
</script>




