package com.demo.service.impl;

import com.demo.dao.DeptMapper;
import com.demo.service.DeptService;
import com.demo.vo.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * Dept模块的Service层（业务层）的具体实现类，对DeptService接口中定义的抽象方法作出具体的功能实现
 */
@Service
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DeptMapper deptMapper;


    @Override
    public boolean insert(Dept vo) {
        return this.deptMapper.doCreate(vo) == 1;
    }

    @Override
    public boolean delete(Collection<Serializable> ids) {
        return ids.isEmpty() ? false : this.deptMapper.doRemoveBatch(ids) == ids.size();
    }

    @Override
    public boolean update(Dept vo) {
        return this.deptMapper.doUpdate(vo) == 1;
    }

    @Override
    public Dept get(Serializable id) {
        return this.deptMapper.findById(id);
    }

    @Override
    public Map<String, Object> list(Map<String, Object> params) {
        Map<String, Object> resultMap = new HashMap();
        resultMap.put("totalCount", this.deptMapper.getAllCount(params));
        resultMap.put("list", this.deptMapper.findAllSplit(params));
        return resultMap;
    }
}
