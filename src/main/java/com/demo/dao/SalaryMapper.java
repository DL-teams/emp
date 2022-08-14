package com.demo.dao;

import com.demo.vo.Salary;
import org.apache.ibatis.annotations.Mapper;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Salary模块的DAO层（数据层）接口，提供增删改查等数据库操作的方法抽象
 */
@Mapper
public interface SalaryMapper {
    /**
     * 增加工资表记录
     *
     * @param vo
     * @return
     */
    int doCreate(Salary vo);

    /**
     * 根据主键id的集合，批量删除对应的工资表记录
     *
     * @param ids
     * @return
     */
    int doRemoveBatch(Collection<Serializable> ids);

    /**
     * 更新工资表记录
     *
     * @param vo
     * @return
     */
    int doUpdate(Salary vo);

    /**
     * 根据主键id获取工资表记录的详情
     *
     * @param id
     * @return
     */
    Salary findById(Serializable id);

    /**
     * 根据条件查询工资表集合
     *
     * @param params
     * @return
     */
    List<Salary> findAllSplit(Map<String, Object> params);

    /**
     * 根据条件查询工资数量
     *
     * @param params
     * @return
     */
    Integer getAllCount(Map<String, Object> params);
}
