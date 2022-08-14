package com.demo.service.impl;

import com.demo.dao.AnnouncementMapper;
import com.demo.service.AnnouncementService;
import com.demo.vo.Announcement;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

@Service
public class AnnouncementServiceImpl implements AnnouncementService {

    @Resource
    private AnnouncementMapper announcementMapper;

    @Override
    public boolean insert(Announcement vo) {
        return this.announcementMapper.doCreate(vo) == 1;
    }

    @Override
    public boolean delete(Collection<Serializable> ids) {
        return ids.isEmpty() ? false : this.announcementMapper.doRemoveBatch(ids) == ids.size();
    }

    @Override
    public boolean update(Announcement vo) {
        return this.announcementMapper.doUpdate(vo) == 1;
    }

    @Override
    public Announcement get(Serializable id) {
        return this.announcementMapper.findById(id);
    }

    @Override
    public List<Announcement> list(Map<String, Object> params) {
        return this.announcementMapper.findAllSplit(params);
    }
}
