package com.demo.service;

import com.demo.vo.Dept;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;

/**
 * Dept模块的Service层（业务层）接口，提供业务方法的抽象
 */
public interface DeptService {
    /**
     * 增加部门
     *
     * @param vo
     * @return
     */
    boolean insert(Dept vo);

    /**
     * 删除部门
     *
     * @param ids
     * @return
     */
    boolean delete(Collection<Serializable> ids);

    /**
     * 修改部门
     *
     * @param vo
     * @return
     */
    boolean update(Dept vo);

    /**
     * 根据主键Id查询部门详情
     *
     * @param id
     * @return
     */
    Dept get(Serializable id);

    /**
     * 根据条件查询部门的列表与数量
     *
     * @param params
     * @return
     */
    Map<String, Object> list(Map<String, Object> params);
}
