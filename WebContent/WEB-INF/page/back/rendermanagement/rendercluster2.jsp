<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery-ui.custom.css" />
<link rel="stylesheet" href="${contextPath}/static/assets/css/jquery.gritter.css" />

<style>
	/* some elements used in demo only */
	.spinner-preview {
		width: 100px;
		height: 100px;
		text-align: center;
		margin-top: 60px;
	}
	
	.dropdown-preview {
		margin: 0 5px;
		display: inline-block;
	}
	.dropdown-preview  > .dropdown-menu {
		display: block;
		position: static;
		margin-bottom: 5px;
	}
</style>

<!-- ajax layout which only needs content area -->
<div class="page-header">
	<h1>
		UI Elements
		<small>
			<i class="ace-icon fa fa-angle-double-right"></i>
			Common UI Features &amp; Elements
		</small>
	</h1>
</div><!-- /.page-header -->

<div class="col-sm-6">
	<!-- #section:elements.tab.option -->
	<div class="tabbable">
		<ul class="nav nav-tabs padding-12 tab-color-blue background-blue" id="myTab4">
			<li class="active">
				<a data-toggle="tab" href="#home4">Home</a>
			</li>

			<li>
				<a data-toggle="tab" href="#profile4">Profile</a>
			</li>


		</ul>

		<div class="tab-content">
			<div id="home4" class="tab-pane in active">
				<script type="text/javascript">
                    var scripts = [ null, "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js", "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js", null ]
                    $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
                        // inline scripts related to this page

                        jQuery(function($) {
                            var grid_selector = "#grid-table";
                            var pager_selector = "#grid-pager";
                            var grid_selector2 = "#grid-table2";
                            var pager_selector2 = "#grid-pager";
                            // resize to fit page size
                            $(window).on('resize.jqGrid', function() {
                                $(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
                                $(grid_selector2).jqGrid('setGridWidth', $(".page-content").width());
                            })
                            // resize on sidebar collapse/expand
                            var parent_column = $(grid_selector).closest('[class*="col-"]');
                            var parent_column = $(grid_selector2).closest('[class*="col-"]');
                            $(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
                                if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
                                    // setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                                    setTimeout(function() {
                                        $(grid_selector).jqGrid('setGridWidth', parent_column.width());
                                        $(grid_selector2).jqGrid('setGridWidth', parent_column.width());
                                    }, 0);
                                }
                            })


                            jQuery(grid_selector).jqGrid({
                                subGrid : false,
                                url : "${contextPath}/sys/cluster/getDict",
                                datatype : "json",
                                height : 450,
                                colNames : ['', 'ID', '集群IP', '集群名', '集群类型', '容器Id序列'],
                                colModel : [ {
                                    name : '',
                                    index : '',
                                    width : 80,
                                    fixed : true,
                                    sortable : false,
                                    resize : false,
                                    formatter : 'actions',
                                    formatoptions : {
                                        keys : true,
                                        //delbutton : false,//disable delete button
                                        delOptions : {
                                            recreateForm : true,
                                            beforeShowForm : beforeDeleteCallback
                                        }
                                        //editformbutton:true, editOptions:{recreateForm:true, beforeShowForm:beforeEditCallback}
                                    }
                                }, {
                                    name : 'id',
                                    index : 'id',
                                    label : 'ID',
                                    width : 60,
                                    sorttype : "long",
                                    search : false
                                }, {
                                    name : 'ip',
                                    index : 'ip',
                                    label : '服务器IP',
                                    width : 80,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "20"},
                                    searchoptions : {sopt : ['eq']},
                                    editrules : {required : true}
                                }, {
                                    name : 'clusterName',
                                    index : 'clusterName',
                                    label : '集群名',
                                    width : 90,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "40"},
                                    searchoptions : {sopt : ['cn']},
                                    editrules : {required : true}
                                }, {
                                    name : 'type',
                                    index : 'type',
                                    label : '集群类型',
                                    width : 60,
                                    editable : true,
									/* sorttype : "long", */
                                    search : false,
                                    editrules : {required : true}
                                }, {
                                    name : 'containerIds',
                                    index : 'containerIds',
                                    label : '容器Id序列',
                                    width : 110,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "20", title : "如果没有上级，不填即可"},
                                    search : false

                                } ],
                                //scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
                                sortname : "id",
                                sortorder : "asc",
                                viewrecords : true,
                                rowNum : 10,
                                rowList : [ 10, 20, 30 ],
                                pager : pager_selector,
                                altRows : true,
                                //toppager : true,
                                multiselect : true,
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






                            $(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size
                            // enable search/filter toolbar
                            // jQuery(grid_selector2).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
                            // jQuery(grid_selector2).filterToolbar({});
                            // switch element when editing inline
                            function aceSwitch(cellvalue, options, cell) {
                                setTimeout(function() {
                                    $(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
                                }, 0);
                            }



                            jQuery(grid_selector2).jqGrid('navGrid', pager_selector2, { // navbar options
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
                                alert("编辑状态")
                                var form = $(e[0]);
                                form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                                style_edit_form(form);
                            }



                            function beforeUploadCallback(e) {
                                alert("上传状态")
								/* var form = $(e[0]);
								 form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
								 style_edit_form(form); */
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
				</script>

			</div>

			<div id="profile4" class="tab-pane">
				<script type="text/javascript">
                    var scripts = [ null, "${contextPath}/static/assets/js/jqGrid/jquery.jqGrid.js", "${contextPath}/static/assets/js/jqGrid/i18n/grid.locale-cn.js", null ]
                    $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
                        // inline scripts related to this page

                        jQuery(function($) {
                            var grid_selector = "#grid-table";
                            var pager_selector = "#grid-pager";
                            var grid_selector2 = "#grid-table2";
                            var pager_selector2 = "#grid-pager";
                            // resize to fit page size
                            $(window).on('resize.jqGrid', function() {
                                $(grid_selector).jqGrid('setGridWidth', $(".page-content").width());
                                $(grid_selector2).jqGrid('setGridWidth', $(".page-content").width());
                            })
                            // resize on sidebar collapse/expand
                            var parent_column = $(grid_selector).closest('[class*="col-"]');
                            var parent_column = $(grid_selector2).closest('[class*="col-"]');
                            $(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
                                if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
                                    // setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                                    setTimeout(function() {
                                        $(grid_selector).jqGrid('setGridWidth', parent_column.width());
                                        $(grid_selector2).jqGrid('setGridWidth', parent_column.width());
                                    }, 0);
                                }
                            })




                            jQuery(grid_selector2).jqGrid({
                                subGrid : false,
                                url : "${contextPath}/sys/container/getDict",
                                datatype : "json",
                                height : 450,
                                colNames : ['', '容器Id', '所属集群','镜像', '容器IP', '端口','创建日期','运行状态','command'],
                                colModel : [ {
                                    name : '',
                                    index : '',
                                    width : 80,
                                    fixed : true,
                                    sortable : false,
                                    resize : false,
                                    formatter : 'actions',
                                    formatoptions : {
                                        keys : true,
                                        //delbutton : false,//disable delete button
                                        delOptions : {
                                            recreateForm : true,
                                            beforeShowForm : beforeDeleteCallback
                                        }
                                        //editformbutton:true, editOptions:{recreateForm:true, beforeShowForm:beforeEditCallback}
                                    }
                                }, {
                                    name : 'containerId',
                                    index : 'containerId',
                                    label : 'containerId',
                                    width : 60,
									/* sorttype : "long", */
                                    search : false
                                }, {
                                    name : 'clusterName',
                                    index : 'clusterName',
                                    label : '所属集群',
                                    width : 60,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "20", title : "如果没有上级，不填即可"},
                                    search : false
                                },{
                                    name : 'images',
                                    index : 'images',
                                    label : '容器镜像',
                                    width : 80,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "20"},
                                    searchoptions : {sopt : ['eq']},
                                    editrules : {required : true}
                                }, {
                                    name : 'ip',
                                    index : 'ip',
                                    label : '容器IP',
                                    width : 90,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "40"},
                                    searchoptions : {sopt : ['cn']},
                                    editrules : {required : true}
                                }, {
                                    name : 'ports',
                                    index : 'ports',
                                    label : '端口',
                                    width : 60,
                                    editable : true,
                                    sorttype : "int",
                                    search : false,
                                    editrules : {required : true}
                                }, {
                                    name : 'createDate',
                                    index : 'createDate',
                                    label : '创建日期',
                                    width : 60,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "20", title : "如果没有上级，不填即可"},
                                    search : false,
                                    formatter:"date",
									/*  formatoptions: {srcformat:'u',newformat:'Y-m-d H:i:s'} */
                                    formatoptions: {srcformat:'u',newformat:'Y-m-d'}
                                },{
                                    name : 'status',
                                    index : 'status',
                                    label : '运行状态',
                                    width : 110,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "20", title : "如果没有上级，不填即可"},
                                    search : false
                                } , {
                                    name : 'command',
                                    index : 'command',
                                    label : 'command',
                                    width : 60,
                                    editable : true,
                                    editoptions : {size : "20", maxlength : "20", title : "如果没有上级，不填即可"},
                                    search : false
                                }],
                                //scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
                                sortname : "id",
                                sortorder : "asc",
                                viewrecords : true,
                                rowNum : 10,
                                rowList : [ 10, 20, 30 ],
                                pager : pager_selector,
                                altRows : true,
                                //toppager : true,
                                multiselect : true,
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
                                editurl : "${contextPath}/sys/container/operateDict"
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
                            // jQuery(grid_selector2).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
                            // jQuery(grid_selector2).filterToolbar({});
                            // switch element when editing inline
                            function aceSwitch(cellvalue, options, cell) {
                                setTimeout(function() {
                                    $(cell).find('input[type=checkbox]').addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
                                }, 0);
                            }



                            jQuery(grid_selector2).jqGrid('navGrid', pager_selector2, { // navbar options
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
                                alert("编辑状态")
                                var form = $(e[0]);
                                form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                                style_edit_form(form);
                            }



                            function beforeUploadCallback(e) {
                                alert("上传状态")
								/* var form = $(e[0]);
								 form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
								 style_edit_form(form); */
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
				</script>

			</div>


		</div>
	</div>

	<!-- /section:elements.tab.option -->
</div><!-- /.col -->

<!-- page specific plugin scripts -->

<!--[if lte IE 8]>
  <script src="${contextPath}/static/assets/js/excanvas.js"></script>
<![endif]-->
<script type="text/javascript">
	var scripts = [null,"${contextPath}/static/assets/js/jquery-ui.custom.js","${contextPath}/static/assets/js/jquery.ui.touch-punch.js","${contextPath}/static/assets/js/bootbox.js","${contextPath}/static/assets/js/jquery.easypiechart.js","${contextPath}/static/assets/js/jquery.gritter.js","${contextPath}/static/assets/js/spin.js", null]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
	//inline scripts related to this page
	jQuery(function($) {
		/**
		$('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		  //console.log(e.target.getAttribute("href"));
		})
			
		$('#accordion').on('shown.bs.collapse', function (e) {
			//console.log($(e.target).is('#collapseTwo'))
		});
		*/
		
		$('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			if($(e.target).attr('href') == "#home") drawChartNow();
		})
	
		
		/**
			//go to next tab, without user clicking
			$('#myTab > .active').next().find('> a').trigger('click');
		*/
	
	
		$('#accordion-style').on('click', function(ev){
			var target = $('input', ev.target);
			var which = parseInt(target.val());
			if(which == 2) $('#accordion').addClass('accordion-style2');
			 else $('#accordion').removeClass('accordion-style2');
		});
		
		//$('[href="#collapseTwo"]').trigger('click');
	
	
		var oldie = /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase());
		$('.easy-pie-chart.percentage').each(function(){
			$(this).easyPieChart({
				barColor: $(this).data('color'),
				trackColor: '#EEEEEE',
				scaleColor: false,
				lineCap: 'butt',
				lineWidth: 8,
				animate: oldie ? false : 1000,
				size:75
			}).css('color', $(this).data('color'));
		});
	
		$('[data-rel=tooltip]').tooltip();
		$('[data-rel=popover]').popover({html:true});
	
	
		$('#gritter-regular').on(ace.click_event, function(){
			$.gritter.add({
				title: 'This is a regular notice!',
				text: 'This will fade out after a certain amount of time. Vivamus eget tincidunt velit. Cum sociis natoque penatibus et <a href="#" class="blue">magnis dis parturient</a> montes, nascetur ridiculus mus.',
				image: $path_assets+'/avatars/avatar1.png',
				sticky: false,
				time: '',
				class_name: (!$('#gritter-light').get(0).checked ? 'gritter-light' : '')
			});
	
			return false;
		});
	
		$('#gritter-sticky').on(ace.click_event, function(){
			var unique_id = $.gritter.add({
				title: 'This is a sticky notice!',
				text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget tincidunt velit. Cum sociis natoque penatibus et <a href="#" class="red">magnis dis parturient</a> montes, nascetur ridiculus mus.',
				image: $path_assets+'/avatars/avatar.png',
				sticky: true,
				time: '',
				class_name: 'gritter-info' + (!$('#gritter-light').get(0).checked ? ' gritter-light' : '')
			});
	
			return false;
		});
	
	
		$('#gritter-without-image').on(ace.click_event, function(){
			$.gritter.add({
				// (string | mandatory) the heading of the notification
				title: 'This is a notice without an image!',
				// (string | mandatory) the text inside the notification
				text: 'This will fade out after a certain amount of time. Vivamus eget tincidunt velit. Cum sociis natoque penatibus et <a href="#" class="orange">magnis dis parturient</a> montes, nascetur ridiculus mus.',
				class_name: 'gritter-success' + (!$('#gritter-light').get(0).checked ? ' gritter-light' : '')
			});
	
			return false;
		});
	
	
		$('#gritter-max3').on(ace.click_event, function(){
			$.gritter.add({
				title: 'This is a notice with a max of 3 on screen at one time!',
				text: 'This will fade out after a certain amount of time. Vivamus eget tincidunt velit. Cum sociis natoque penatibus et <a href="#" class="green">magnis dis parturient</a> montes, nascetur ridiculus mus.',
				image: $path_assets+'/avatars/avatar3.png',
				sticky: false,
				before_open: function(){
					if($('.gritter-item-wrapper').length >= 3)
					{
						return false;
					}
				},
				class_name: 'gritter-warning' + (!$('#gritter-light').get(0).checked ? ' gritter-light' : '')
			});
	
			return false;
		});
	
	
		$('#gritter-center').on(ace.click_event, function(){
			$.gritter.add({
				title: 'This is a centered notification',
				text: 'Just add a "gritter-center" class_name to your $.gritter.add or globally to $.gritter.options.class_name',
				class_name: 'gritter-info gritter-center' + (!$('#gritter-light').get(0).checked ? ' gritter-light' : '')
			});
	
			return false;
		});
		
		$('#gritter-error').on(ace.click_event, function(){
			$.gritter.add({
				title: 'This is a warning notification',
				text: 'Just add a "gritter-light" class_name to your $.gritter.add or globally to $.gritter.options.class_name',
				class_name: 'gritter-error' + (!$('#gritter-light').get(0).checked ? ' gritter-light' : '')
			});
	
			return false;
		});
			
	
		$("#gritter-remove").on(ace.click_event, function(){
			$.gritter.removeAll();
			return false;
		});
			
	
		///////
	
	
		$("#bootbox-regular").on(ace.click_event, function() {
			bootbox.prompt("What is your name?", function(result) {
				if (result === null) {
					
				} else {
					
				}
			});
		});
			
		$("#bootbox-confirm").on(ace.click_event, function() {
			bootbox.confirm("Are you sure?", function(result) {
				if(result) {
					//
				}
			});
		});
		
	/**
		$("#bootbox-confirm").on(ace.click_event, function() {
			bootbox.confirm({
				message: "Are you sure?",
				buttons: {
				  confirm: {
					 label: "OK",
					 className: "btn-primary btn-sm",
				  },
				  cancel: {
					 label: "Cancel",
					 className: "btn-sm",
				  }
				},
				callback: function(result) {
					if(result) alert(1)
				}
			  }
			);
		});
	**/
			
		$("#bootbox-options").on(ace.click_event, function() {
			bootbox.dialog({
				message: "<span class='bigger-110'>I am a custom dialog with smaller buttons</span>",
				buttons: 			
				{
					"success" :
					 {
						"label" : "<i class='ace-icon fa fa-check'></i> Success!",
						"className" : "btn-sm btn-success",
						"callback": function() {
							//Example.show("great success");
						}
					},
					"danger" :
					{
						"label" : "Danger!",
						"className" : "btn-sm btn-danger",
						"callback": function() {
							//Example.show("uh oh, look out!");
						}
					}, 
					"click" :
					{
						"label" : "Click ME!",
						"className" : "btn-sm btn-primary",
						"callback": function() {
							//Example.show("Primary button");
						}
					}, 
					"button" :
					{
						"label" : "Just a button...",
						"className" : "btn-sm"
					}
				}
			});
		});
	
	
	
		$('#spinner-opts small').css({display:'inline-block', width:'60px'})
	
		var slide_styles = ['', 'green','red','purple','orange', 'dark'];
		var ii = 0;
		$("#spinner-opts input[type=text]").each(function() {
			var $this = $(this);
			$this.hide().after('<span />');
			$this.next().addClass('ui-slider-small').
			addClass("inline ui-slider-"+slide_styles[ii++ % slide_styles.length]).
			css('width','125px').slider({
				value:parseInt($this.val()),
				range: "min",
				animate:true,
				min: parseInt($this.attr('data-min')),
				max: parseInt($this.attr('data-max')),
				step: parseFloat($this.attr('data-step')) || 1,
				slide: function( event, ui ) {
					$this.val(ui.value);
					spinner_update();
				}
			});
		});
	
	
	
		//CSS3 spinner
		$.fn.spin = function(opts) {
			this.each(function() {
			  var $this = $(this),
				  data = $this.data();
	
			  if (data.spinner) {
				data.spinner.stop();
				delete data.spinner;
			  }
			  if (opts !== false) {
				data.spinner = new Spinner($.extend({color: $this.css('color')}, opts)).spin(this);
			  }
			});
			return this;
		};
	
		function spinner_update() {
			var opts = {};
			$('#spinner-opts input[type=text]').each(function() {
				opts[this.name] = parseFloat(this.value);
			});
			opts['left'] = 'auto';
			$('#spinner-preview').spin(opts);
		}
	
		$('#id-pills-stacked').removeAttr('checked').on('click', function(){
			$('.nav-pills').toggleClass('nav-stacked');
		});
		
		///////////
		$(document).one('ajaxloadstart.page', function(e) {
			$.gritter.removeAll();
			$('.modal').modal('hide');
		});
	
	});
	});
</script>
