package com.jeefw.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.sys.TaskDao;
import com.jeefw.model.sys.Task;
import com.jeefw.service.sys.TaskService;

import core.service.BaseService;

/**
 * 字典的业务逻辑层的实现
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Service
public class TaskServiceImpl extends BaseService<Task> implements TaskService {

	private TaskDao clusterDao;

	@Resource
	public void setCeShiDao(TaskDao clusterDao) {
		this.clusterDao = clusterDao;
		this.dao = clusterDao;
	}

	public List<Task> queryTaskWithSubList(List<Task> resultList) {
		List<Task> taskList = new ArrayList<Task>();
		for (Task entity : resultList) {
			Task task = new Task();
			task.setId(entity.getId());
			task.setServerIp(entity.getServerIp());
			task.setServiceName(entity.getServiceName());
			task.setImagesId(entity.getImagesId());
			task.setScale(entity.getScale());
			task.setCommand(entity.getCommand());
			task.setRenderClusterName(entity.getRenderClusterName());
			
			
			taskList.add(task);
		}
		return taskList;
	}

}
