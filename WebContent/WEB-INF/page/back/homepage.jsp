<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!-- ajax layout which only needs content area -->
<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<div class="space-6"></div>

		<div class="row">
			<div class="col-sm-10 col-sm-offset-1">
				<!-- #section:pages/invoice -->
				<div class="widget-box transparent">
					<div class="widget-header widget-header-large">
						<h3 class="widget-title grey lighter">
							<i class="ace-icon fa fa-leaf green"></i>
							动态渲染管理系统
						</h3>

						<!-- #section:pages/invoice.info -->
						<div class="widget-toolbar no-border invoice-info">
							<span class="invoice-info-label">Invoice:</span>
							<span class="red">#666666</span>

							<br />
							<span class="invoice-info-label">Date:</span>
							<span class="blue">04/12/2017</span>
						</div>

						<div class="widget-toolbar hidden-480">
							<a href="#">
								<i class="ace-icon fa fa-print"></i>
							</a>
						</div>

						<!-- /section:pages/invoice.info -->
					</div>

					<div class="widget-body">
						<div class="widget-main padding-24">
							<div class="row">
								<div class="col-sm-6">
									<div class="row">
										<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
											<b>系统说明</b>
										</div>
									</div>

									<div>
										<ul class="list-unstyled spaced">
											<li>
												<i class="ace-icon fa fa-caret-right blue"></i>1.管理简单
											</li>

											<li>
												<i class="ace-icon fa fa-caret-right blue"></i>2.动态可配置
											</li>

											<li>
												<i class="ace-icon fa fa-caret-right blue"></i>3.用户定制
											</li>


										</ul>
									</div>
								</div><!-- /.col -->


							</div><!-- /.row -->

							<div class="space"></div>


							<div class="hr hr8 hr-double hr-dotted"></div>


							<div class="space-6"></div>
							<div class="well">
								Thank you for choosing our products.
								We believe you will be satisfied by our services.
							</div>
						</div>
					</div>
				</div>

				<!-- /section:pages/invoice -->
			</div>
		</div>

		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
    var scripts = [null, null]
    $('.page-content-area').ace_ajax('loadScripts', scripts, function() {
        //inline scripts related to this page
    });
</script>
