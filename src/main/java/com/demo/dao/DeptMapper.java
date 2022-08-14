package com.demo.dao;

import com.demo.vo.Dept;
import org.apache.ibatis.annotations.Mapper;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Dept模块的DAO层（数据层）接口，提供增删改查等数据库操作的方法抽象
 */
@Mapper
public interface DeptMapper {
    /**
     * 增加部门表记录
     *
     * @param vo
     * @return
     */
    int doCreate(Dept vo);

    /**
     * 根据主键id的集合，批量删除对应的部门表记录
     *
     * @param ids
     * @return
     */
    int doRemoveBatch(Collection<Serializable> ids);

    /**
     * 更新部门表记录
     *
     * @param vo
     * @return
     */
    int doUpdate(Dept vo);

    /**
     * 根据主键id获取部门表记录的详情
     *
     * @param id
     * @return
     */
    Dept findById(Serializable id);

    /**
     * 根据条件查询部门表集合
     *
     * @param params
     * @return
     */
    List<Dept> findAllSplit(Map<String, Object> params);

    /**
     * 根据条件查询部门数量
     *
     * @param params
     * @return
     */
    Integer getAllCount(Map<String, Object> params);
}
