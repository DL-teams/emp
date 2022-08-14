package com.demo.service.impl;

import com.demo.dao.LeaveMapper;
import com.demo.service.LeaveService;
import com.demo.vo.Leave;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * Leave模块的Service层（业务层）的具体实现类，对LeaveService接口中定义的抽象方法作出具体的功能实现
 */
@Service
public class LeaveServiceImpl implements LeaveService {

    @Autowired
    private LeaveMapper leaveMapper;


    //@Override
    public boolean insert(Leave vo) {
        return this.leaveMapper.doCreate(vo) == 1;
    }

    //@Override
    public boolean delete(Collection<Serializable> ids) {
        return ids.isEmpty() ? false : this.leaveMapper.doRemoveBatch(ids) == ids.size();
    }

    //@Override
    public boolean update(Leave vo) {
        return this.leaveMapper.doUpdate(vo) == 1;
    }

    //@Override
    public Leave get(Serializable id) {
        return this.leaveMapper.findById(id);
    }

    //@Override
    public Map<String, Object> list(Map<String, Object> params) {
        Map<String, Object> resultMap = new HashMap();
        resultMap.put("totalCount", this.leaveMapper.getAllCount(params));
        resultMap.put("list", this.leaveMapper.findAllSplit(params));
        return resultMap;
    }
}
