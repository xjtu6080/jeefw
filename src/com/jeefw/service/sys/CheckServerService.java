package com.jeefw.service.sys;

import java.util.List;

import com.jeefw.model.sys.Server;

import core.service.Service;

/**
 * 字典的业务逻辑层的接口
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
public interface CheckServerService extends Service<Server> {

	List<Server> queryCeShiWithSubList(List<Server> resultList);

}
