package com.jeefw.dao.sys.impl;

import com.jeefw.dao.sys.DictDao;
import com.jeefw.dao.sys.UserDefinedDao;
import com.jeefw.model.sys.Dict;
import com.jeefw.model.sys.UserDefined;
import core.dao.BaseDao;

/**
 * Created by Administartor on 2017/12/27/027.
 */
public class UserDefinedDaoImpl  extends BaseDao<UserDefined> implements UserDefinedDao {



        public UserDefinedDaoImpl() {
            super(UserDefined.class);
        }
}
