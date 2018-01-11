package com.jeefw.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.jeefw.dao.sys.CeShiDao;
import com.jeefw.model.sys.CeShi;
import com.jeefw.service.sys.CeShiService;

import core.service.BaseService;

/**
 * 字典的业务逻辑层的实现
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Service
public class CeShiServiceImpl extends BaseService<CeShi> implements CeShiService {

	private CeShiDao ceshiDao;

	@Resource
	public void setCeShiDao(CeShiDao ceshiDao) {
		this.ceshiDao = ceshiDao;
		this.dao = ceshiDao;
	}

	public List<CeShi> queryCeShiWithSubList(List<CeShi> resultList) {
		List<CeShi> ceshiList = new ArrayList<CeShi>();
		for (CeShi entity : resultList) {
			CeShi ceshi = new CeShi();
			ceshi.setId(entity.getId());
			ceshi.setDictKey(entity.getDictKey());
			ceshi.setDictValue(entity.getDictValue());
			ceshi.setSequence(entity.getSequence());
			ceshi.setParentDictkey(entity.getParentDictkey());
			ceshiList.add(ceshi);
		}
		return ceshiList;
	}

}
