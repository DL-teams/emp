package com.demo.dao;

import com.demo.vo.Employee;
import org.apache.ibatis.annotations.Mapper;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Employee模块的DAO层（数据层）接口，提供增删改查等数据库操作的方法抽象
 */
@Mapper
public interface EmployeeMapper {
    /**
     * 增加员工表记录
     *
     * @param vo
     * @return
     */
    int doCreate(Employee vo);

    /**
     * 根据主键id的集合，批量删除对应的员工表记录
     *
     * @param ids
     * @return
     */
    int doRemoveBatch(Collection<Serializable> ids);

    /**
     * 更新员工表记录
     *
     * @param vo
     * @return
     */
    int doUpdate(Employee vo);

    /**
     * 根据主键id获取员工表记录的详情
     *
     * @param id
     * @return
     */
    Employee findById(Serializable id);

    /**
     * 根据条件查询员工表集合
     *
     * @param params
     * @return
     */
    List<Employee> findAllSplit(Map<String, Object> params);

    /**
     * 根据条件查询员工数量
     *
     * @param params
     * @return
     */
    Integer getAllCount(Map<String, Object> params);
}
