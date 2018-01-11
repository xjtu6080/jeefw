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
							<div class="space"></div>

							<div>
								<table class="table table-striped table-bordered">
									<thead>
									<tr>
										<th class="center">#</th>
										<th>服务名称</th>
										<th class="hidden-xs">服务描述</th>
										<th class="hidden-480">所需资源</th>

									</tr>
									</thead>

									<tbody>
									<tr>
										<td class="center">1</td>

										<<td>服务1</td>
										<td class="hidden-xs">
											1 year domain registration
										</td>
										<td class="hidden-480">
											---
										</td>
									</tr>


									</tbody>
								</table>
							</div>

							<div class="hr hr8 hr-double hr-dotted"></div>



							<div class="space-6"></div>
							<div class="well">
								Thank you for choosing Ace Company products.
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
