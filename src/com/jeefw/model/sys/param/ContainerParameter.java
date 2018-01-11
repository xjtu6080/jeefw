package com.jeefw.model.sys.param;

import core.support.ExtJSBaseParameter;

/**
 * 字典的参数类
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
public class ContainerParameter extends ExtJSBaseParameter {

	private String $eq_ip;
	private String $like_containerId;
	public String get$eq_ip() {
		return $eq_ip;
	}
	public void set$eq_ip(String $eq_ip) {
		this.$eq_ip = $eq_ip;
	}
	public String get$like_containerId() {
		return $like_containerId;
	}
	public void set$like_containerId(String $like_containerId) {
		this.$like_containerId = $like_containerId;
	}

}
