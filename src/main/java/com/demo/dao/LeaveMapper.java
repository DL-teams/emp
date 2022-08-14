package com.demo.dao;

import com.demo.vo.Leave;
import org.apache.ibatis.annotations.Mapper;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Leave模块的DAO层（数据层）接口，提供增删改查等数据库操作的方法抽象
 */
@Mapper
public interface LeaveMapper {
    /**
     * 增加请假表记录
     *
     * @param vo
     * @return
     */
    int doCreate(Leave vo);

    /**
     * 根据主键id的集合，批量删除对应的请假表记录
     *
     * @param ids
     * @return
     */
    int doRemoveBatch(Collection<Serializable> ids);

    /**
     * 更新请假表记录
     *
     * @param vo
     * @return
     */
    int doUpdate(Leave vo);

    /**
     * 根据主键id获取请假表记录的详情
     *
     * @param id
     * @return
     */
    Leave findById(Serializable id);

    /**
     * 根据条件查询请假表集合
     *
     * @param params
     * @return
     */
    List<Leave> findAllSplit(Map<String, Object> params);

    /**
     * 根据条件查询请假数量
     *
     * @param params
     * @return
     */
    Integer getAllCount(Map<String, Object> params);
}
