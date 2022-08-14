package com.demo.controller;

import com.demo.util.Util;
import com.demo.service.LeaveService;
import com.demo.vo.Leave;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.Serializable;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping
public class LeaveController {

    @Autowired
    private LeaveService leaveService;

    /**
     * 增加请假
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("leaveAdd")
    public void add(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Leave vo = new Leave();
        //取出页面传进来的参数
        vo.setLeaveNo(Util.decode(request, "leaveNo"));
        vo.setLeaveName(Util.decode(request, "leaveName"));
        vo.setLeaveStart(Util.decode(request, "leaveStart"));
        vo.setLeaveEnd(Util.decode(request, "leaveEnd"));
        vo.setLeaveDays(Util.decode(request, "leaveDays"));
        vo.setLeaveReason(Util.decode(request, "leaveReason"));
        vo.setLeaveText(Util.decode(request, "leaveText"));
        //调用Service层的增加（insert）方法
        leaveService.insert(vo);
        this.redirectList(request, response);
    }

    /**
     * 删除请假
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("leaveDelete")
    public void delete(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");
        leaveService.delete(Arrays.asList(id));
        this.redirectList(request, response);
    }

    /**
     * 编辑请假
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("leaveEdit")
    public void edit(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Leave vo = new Leave();
        vo.setId(Long.valueOf(Util.decode(request, "id")));
        vo.setLeaveNo(Util.decode(request, "leaveNo"));
        vo.setLeaveName(Util.decode(request, "leaveName"));
        vo.setLeaveStart(Util.decode(request, "leaveStart"));
        vo.setLeaveEnd(Util.decode(request, "leaveEnd"));
        vo.setLeaveDays(Util.decode(request, "leaveDays"));
        vo.setLeaveReason(Util.decode(request, "leaveReason"));
        vo.setLeaveText(Util.decode(request, "leaveText"));
        leaveService.update(vo);
        this.redirectList(request, response);
    }

    /**
     * 获取请假的详细信息（详情页面与编辑页面要显示该请假的详情）并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping({"leaveGet", "leaveEditPre"})
    public void get(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");//取出主键id
        Leave vo = leaveService.get(id);
        response.getWriter().println(com.alibaba.fastjson.JSONObject.toJSONString(vo));
    }

    /**
     * 根据条件查询请假的列表并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("leaveList")
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
        Map<String, Object> map = leaveService.list(params);
        request.getSession().setAttribute("list", map.get("list"));

        Integer totalRecord = (Integer) map.get("totalCount");//根据查询条件取出对应的总记录数，用于分页
        String pageNum = Util.decode(request, "pageNum");//封装分页参数
        com.demo.util.PageBean<Object> pb = new com.demo.util.PageBean(Integer.valueOf(pageNum != null ? pageNum : "1"), totalRecord);
        params.put("startIndex", pb.getStartIndex());
        params.put("pageSize", pb.getPageSize());
        List list = (List) leaveService.list(params).get("list");//根据分页参数startIndex、pageSize查询出来的最终结果list
        pb.setServlet("leaveList");
        pb.setSearchColumn(searchColumn);
        pb.setKeyword(keyword);
        pb.setList(list);
        request.getSession().setAttribute("pageBean", pb);
        request.getSession().setAttribute("list", pb.getList());

        response.sendRedirect("leave_list.jsp");
    }
}
