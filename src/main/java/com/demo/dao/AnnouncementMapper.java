package com.demo.dao;

import com.demo.vo.Announcement;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AnnouncementMapper {

    /**
     * 增加公告表记录
     *
     * @param vo
     * @return
     */
    int doCreate(Announcement vo);

    /**
     * 根据主键id的集合，批量删除对应的公告表记录
     *
     * @param ids
     * @return
     */
    int doRemoveBatch(Collection<Serializable> ids);

    /**
     * 更新公告表记录
     *
     * @param vo
     * @return
     */
    int doUpdate(Announcement vo);

    /**
     * 根据主键id获取公告表记录的详情
     *
     * @param id
     * @return
     */
    Announcement findById(Serializable id);

    /**
     * 根据条件查询公告表集合
     *
     * @param params
     * @return
     */
    List<Announcement> findAllSplit(Map<String, Object> params);
}
