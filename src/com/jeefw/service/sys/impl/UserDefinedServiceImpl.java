package com.jeefw.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.jeefw.dao.sys.UserDefinedDao;
import com.jeefw.model.sys.UserDefined;
import com.jeefw.service.sys.UserDefinedService;
import org.springframework.stereotype.Service;

import com.jeefw.dao.sys.DictDao;
import com.jeefw.model.sys.Dict;
import com.jeefw.service.sys.DictService;

import core.service.BaseService;

/**
 * 字典的业务逻辑层的实现
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Service
public class UserDefinedServiceImpl extends BaseService<UserDefined> implements UserDefinedService {

    private UserDefinedDao userDefinedDao;
    //UserDefinedServiceImpl

    public void setUserDefinedDao(UserDefinedDao userDefinedDao) {
        this.userDefinedDao = userDefinedDao;
        this.dao = userDefinedDao;
    }


    public List<UserDefined> queryDictWithSubList(List<UserDefined> resultList) {
        List<UserDefined> dictList = new ArrayList<UserDefined>();
        for (UserDefined entity : resultList) {
            UserDefined dict = new UserDefined();
            dict.setId(entity.getId());
            dict.setDictKey(entity.getDictKey());
            dict.setDictValue(entity.getDictValue());
            dict.setSequence(entity.getSequence());
            dict.setParentDictkey(entity.getParentDictkey());
            dictList.add(dict);
        }
        return dictList;
    }

}
