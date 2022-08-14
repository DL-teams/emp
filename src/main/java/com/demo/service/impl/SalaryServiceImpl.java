package com.demo.service.impl;

import com.demo.dao.SalaryMapper;
import com.demo.service.SalaryService;
import com.demo.vo.Salary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * Salary模块的Service层（业务层）的具体实现类，对SalaryService接口中定义的抽象方法作出具体的功能实现
 */
@Service
public class SalaryServiceImpl implements SalaryService {

    @Autowired
    private SalaryMapper salaryMapper;


    //@Override
    public boolean insert(Salary vo) {
        return this.salaryMapper.doCreate(vo) == 1;
    }

    //@Override
    public boolean delete(Collection<Serializable> ids) {
        return ids.isEmpty() ? false : this.salaryMapper.doRemoveBatch(ids) == ids.size();
    }

    //@Override
    public boolean update(Salary vo) {
        return this.salaryMapper.doUpdate(vo) == 1;
    }

    //@Override
    public Salary get(Serializable id) {
        return this.salaryMapper.findById(id);
    }

    //@Override
    public Map<String, Object> list(Map<String, Object> params) {
        Map<String, Object> resultMap = new HashMap();
        resultMap.put("totalCount", this.salaryMapper.getAllCount(params));
        resultMap.put("list", this.salaryMapper.findAllSplit(params));
        return resultMap;
    }
}
