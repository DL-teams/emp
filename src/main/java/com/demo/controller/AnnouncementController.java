package com.demo.controller;

import com.demo.service.AnnouncementService;
import com.demo.util.Util;
import com.demo.vo.Announcement;
import java.io.IOException;
import java.io.Serializable;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/announcement")
public class AnnouncementController {

    @Autowired
    private AnnouncementService announcementService;

    /**
     * 增加公告
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("/add")
    public void add(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Announcement vo = new Announcement();
        //取出页面传进来的参数
        vo.setTitle(Util.decode(request, "announcementTitle"));
        vo.setValue(Util.decode(request, "announcementValue"));
        //调用Service层的增加（insert）方法
        announcementService.insert(vo);
        this.redirectList(request, response);
    }

    /**
     * 删除公告
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("/delete")
    public void delete(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");
        announcementService.delete(Arrays.asList(id));
        this.redirectList(request, response);
    }

    /**
     * 编辑公告
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("/edit")
    public void edit(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Announcement vo = new Announcement();
        vo.setId(Long.valueOf(Util.decode(request, "id")));
        vo.setTitle(Util.decode(request, "announcementTitle"));
        vo.setValue(Util.decode(request, "announcementValue"));
        announcementService.update(vo);
        this.redirectList(request, response);
    }

    /**
     * 获取公告的详细信息（详情页面与编辑页面要显示该公告的详情）并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping({"/get"})
    public void get(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");//取出主键id
        Announcement vo = announcementService.get(id);
        response.getWriter().println(com.alibaba.fastjson.JSONObject.toJSONString(vo));
    }

    /**
     * 根据条件查询公告的列表并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("/list")
    public void list(HttpServletResponse response, HttpServletRequest request) throws IOException {
        this.redirectList(request, response);
    }

    /**
     * 跳转到列表页面
     *
     * @param request
     * @param response
     */
    private void redirectList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //查询列和关键字
        String searchColumn = Util.decode(request, "searchColumn");
        String keyword = Util.decode(request, "keyword");
        Map<String, Object> params = new HashMap();//用来保存控制层传进来的参数(查询条件)
        params.put("searchColumn", searchColumn);//要查询的列
        params.put("keyword", keyword);//查询的关键字
        List<Announcement> announcementList = announcementService.list(params);
        request.getSession().setAttribute("list", announcementList);

        response.sendRedirect("announcement_list.jsp");
    }
}
