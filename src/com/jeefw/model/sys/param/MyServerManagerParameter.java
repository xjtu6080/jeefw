package com.jeefw.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * 字典的参数类
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
public class MyServerManagerParameter extends ExtJSBaseParameter {

	private String $eq_server_name;
	private String $like_server_status;
	public String get$eq_server_name() {
		return $eq_server_name;
	}
	public void set$eq_server_name(String $eq_server_name) {
		this.$eq_server_name = $eq_server_name;
	}
	public String get$like_server_status() {
		return $like_server_status;
	}
	public void set$like_server_status(String $like_server_status) {
		this.$like_server_status = $like_server_status;
	}

	

}
