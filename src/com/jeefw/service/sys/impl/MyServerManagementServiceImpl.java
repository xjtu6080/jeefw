package com.jeefw.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.sys.MyServerManagementDao;
import com.jeefw.model.sys.Server;
import com.jeefw.service.sys.MyServerManagementService;

import core.service.BaseService;

/**
 * 字典的业务逻辑层的实现
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Service
public class MyServerManagementServiceImpl extends BaseService<Server> implements MyServerManagementService {

	private MyServerManagementDao checkserverDao;

	@Resource
	public void setCeShiDao(MyServerManagementDao checkserverDao) {
		this.checkserverDao = checkserverDao;
		this.dao = checkserverDao;
	}

	public List<Server> queryCeShiWithSubList(List<Server> resultList) {
		List<Server> ceshiList = new ArrayList<Server>();
		for (Server entity : resultList) {
			Server chechserver = new Server();
			chechserver.setId(entity.getId());
			chechserver.setIp(entity.getIp());
			chechserver.setHostname(entity.getHostname());
			chechserver.setOwner(entity.getOwner());
			chechserver.setConfiguration(entity.getConfiguration());
			chechserver.setUsefulLife(entity.getUsefulLife());
			chechserver.setStatus(entity.getStatus());
			chechserver.setRegister(entity.getRegister());
			
			ceshiList.add(chechserver);
		}
		return ceshiList;
	}

}
