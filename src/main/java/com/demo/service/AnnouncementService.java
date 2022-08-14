package com.demo.service;

import com.demo.vo.Announcement;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public interface AnnouncementService {

    /**
     * 增加公告
     *
     * @param vo
     * @return
     */
    boolean insert(Announcement vo);

    /**
     * 删除公告
     *
     * @param ids
     * @return
     */
    boolean delete(Collection<Serializable> ids);

    /**
     * 修改公告
     *
     * @param vo
     * @return
     */
    boolean update(Announcement vo);

    /**
     * 根据主键Id查询公告详情
     *
     * @param id
     * @return
     */
    Announcement get(Serializable id);

    /**
     * 根据条件查询公告的列表
     *
     * @param params
     * @return
     */
    List<Announcement> list(Map<String, Object> params);
}
