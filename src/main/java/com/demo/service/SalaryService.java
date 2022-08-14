package com.demo.service;

import com.demo.vo.Salary;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;

/**
 * Salary模块的Service层（业务层）接口，提供业务方法的抽象
 */
public interface SalaryService {
    /**
     * 增加工资
     *
     * @param vo
     * @return
     */
    boolean insert(Salary vo);

    /**
     * 删除工资
     *
     * @param ids
     * @return
     */
    boolean delete(Collection<Serializable> ids);

    /**
     * 修改工资
     *
     * @param vo
     * @return
     */
    boolean update(Salary vo);

    /**
     * 根据主键Id查询工资详情
     *
     * @param id
     * @return
     */
    Salary get(Serializable id);

    /**
     * 根据条件查询工资的列表与数量
     *
     * @param params
     * @return
     */
    Map<String, Object> list(Map<String, Object> params);
}
