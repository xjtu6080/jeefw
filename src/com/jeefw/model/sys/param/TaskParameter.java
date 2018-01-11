package com.jeefw.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * 字典的参数类
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
public class TaskParameter extends ExtJSBaseParameter {

	private String $eq_serverIp;
	private String $like_serviceName;
	public String get$eq_serverIp() {
		return $eq_serverIp;
	}
	public void set$eq_serverIp(String $eq_serverIp) {
		this.$eq_serverIp = $eq_serverIp;
	}
	public String get$like_serviceName() {
		return $like_serviceName;
	}
	public void set$like_serviceName(String $like_serviceName) {
		this.$like_serviceName = $like_serviceName;
	}
	

}
