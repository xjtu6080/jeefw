package com.jeefw.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.sys.ContainerDao;
import com.jeefw.model.sys.Container;
import com.jeefw.service.sys.ContainerService;

import core.service.BaseService;

/**
 * 字典的业务逻辑层的实现
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Service
public class ContainerServiceImpl extends BaseService<Container> implements ContainerService {

	private ContainerDao clusterDao;

	@Resource
	public void setCeShiDao(ContainerDao clusterDao) {
		this.clusterDao = clusterDao;
		this.dao = clusterDao;
	}

	public List<Container> queryContainerWithSubList(List<Container> resultList) {
		List<Container> taskList = new ArrayList<Container>();
		for (Container entity : resultList) {
			Container task = new Container();
			task.setId(entity.getId());
			task.setIp(entity.getIp());
			task.setContainerId(entity.getContainerId());
			task.setImages(entity.getImages());
			task.setCommand(entity.getCommand());
			task.setCreateDate(entity.getCreateDate());
			task.setStatus(entity.getStatus());
			task.setPorts(entity.getPorts());
			task.setClusterName(entity.getClusterName());
			taskList.add(task);
		}
		return taskList;
	}

}
