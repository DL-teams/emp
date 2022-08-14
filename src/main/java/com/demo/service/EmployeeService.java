package com.demo.service;

import com.demo.vo.Employee;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;

/**
 * Employee模块的Service层（业务层）接口，提供业务方法的抽象
 */
public interface EmployeeService {
    /**
     * 增加员工
     *
     * @param vo
     * @return
     */
    boolean insert(Employee vo);

    /**
     * 删除员工
     *
     * @param ids
     * @return
     */
    boolean delete(Collection<Serializable> ids);

    /**
     * 修改员工
     *
     * @param vo
     * @return
     */
    boolean update(Employee vo);

    /**
     * 根据主键Id查询员工详情
     *
     * @param id
     * @return
     */
    Employee get(Serializable id);

    /**
     * 根据条件查询员工的列表与数量
     *
     * @param params
     * @return
     */
    Map<String, Object> list(Map<String, Object> params);
}
