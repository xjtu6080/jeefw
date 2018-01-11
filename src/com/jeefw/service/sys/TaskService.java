package com.jeefw.service.sys;

import java.util.List;

import com.jeefw.model.sys.Task;

import core.service.Service;

/**
 * 字典的业务逻辑层的接口
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
public interface TaskService extends Service<Task> {

	List<Task> queryTaskWithSubList(List<Task> resultList);

}
