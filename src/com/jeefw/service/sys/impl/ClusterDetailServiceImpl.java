package com.jeefw.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.sys.ClusterDao;
import com.jeefw.model.sys.Cluster;
import com.jeefw.service.sys.ClusterDetailService;

import core.service.BaseService;

/**
 * 字典的业务逻辑层的实现
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Service
public class ClusterDetailServiceImpl extends BaseService<Cluster> implements ClusterDetailService {

	private ClusterDao clusterDao;

	@Resource
	public void setCeShiDao(ClusterDao clusterDao) {
		this.clusterDao = clusterDao;
		this.dao = clusterDao;
	}

	public List<Cluster> queryClusterWithSubList(List<Cluster> resultList) {
		List<Cluster> clusterList = new ArrayList<Cluster>();
		for (Cluster entity : resultList) {
			Cluster cluster = new Cluster();
			cluster.setId(entity.getId());
			cluster.setIp(entity.getIp());
			cluster.setClusterName(entity.getClusterName());
			cluster.setType(entity.getType());
			cluster.setContainerIds(entity.getContainerIds());
			
			
			clusterList.add(cluster);
		}
		return clusterList;
	}

}
