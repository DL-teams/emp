package com.demo.service.impl;

import com.demo.dao.EmployeeMapper;
import com.demo.service.EmployeeService;
import com.demo.vo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * Employee模块的Service层（业务层）的具体实现类，对EmployeeService接口中定义的抽象方法作出具体的功能实现
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;


    @Override
    public boolean insert(Employee vo) {
        return this.employeeMapper.doCreate(vo) == 1;
    }

    @Override
    public boolean delete(Collection<Serializable> ids) {
        return ids.isEmpty() ? false : this.employeeMapper.doRemoveBatch(ids) == ids.size();
    }

    @Override
    public boolean update(Employee vo) {
        return this.employeeMapper.doUpdate(vo) == 1;
    }

    @Override
    public Employee get(Serializable id) {
        return this.employeeMapper.findById(id);
    }

    @Override
    public Map<String, Object> list(Map<String, Object> params) {
        Map<String, Object> resultMap = new HashMap();
        resultMap.put("totalCount", this.employeeMapper.getAllCount(params));
        resultMap.put("list", this.employeeMapper.findAllSplit(params));
        return resultMap;
    }
}
