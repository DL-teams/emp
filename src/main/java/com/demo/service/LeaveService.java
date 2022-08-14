package com.demo.service;

import com.demo.vo.Leave;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;

/**
 * Leave模块的Service层（业务层）接口，提供业务方法的抽象
 */
public interface LeaveService {
    /**
     * 增加请假
     *
     * @param vo
     * @return
     */
    boolean insert(Leave vo);

    /**
     * 删除请假
     *
     * @param ids
     * @return
     */
    boolean delete(Collection<Serializable> ids);

    /**
     * 修改请假
     *
     * @param vo
     * @return
     */
    boolean update(Leave vo);

    /**
     * 根据主键Id查询请假详情
     *
     * @param id
     * @return
     */
    Leave get(Serializable id);

    /**
     * 根据条件查询请假的列表与数量
     *
     * @param params
     * @return
     */
    Map<String, Object> list(Map<String, Object> params);
}
