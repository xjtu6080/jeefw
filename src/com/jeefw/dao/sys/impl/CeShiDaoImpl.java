package com.jeefw.dao.sys.impl;

import org.springframework.stereotype.Repository;

import com.jeefw.dao.sys.CeShiDao;
import com.jeefw.model.sys.CeShi;

import core.dao.BaseDao;

/**
 * 字典的数据持久层的实现类
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Repository
public class CeShiDaoImpl extends BaseDao<CeShi> implements CeShiDao {

	public CeShiDaoImpl() {
		super(CeShi.class);
	}

}
