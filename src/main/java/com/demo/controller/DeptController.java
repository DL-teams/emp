package com.demo.controller;

import com.demo.util.Util;
import com.demo.service.DeptService;
import com.demo.vo.Dept;
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
public class DeptController {

    @Autowired
    private DeptService deptService;

    /**
     * 增加部门
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("deptAdd")
    public void add(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Dept vo = new Dept();
        //取出页面传进来的参数
        vo.setDeptName(Util.decode(request, "deptName"));
        vo.setDeptLoc(Util.decode(request, "deptLoc"));
        vo.setDeptCount(Util.decode(request, "deptCount"));
        vo.setDeptLeader(Util.decode(request, "deptLeader"));
        vo.setDeptText(Util.decode(request, "deptText"));
        //调用Service层的增加（insert）方法
        deptService.insert(vo);
        this.redirectList(request, response);
    }

    /**
     * 删除部门
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("deptDelete")
    public void delete(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");
        deptService.delete(Arrays.asList(id));
        this.redirectList(request, response);
    }

    /**
     * 编辑部门
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("deptEdit")
    public void edit(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Dept vo = new Dept();
        vo.setId(Long.valueOf(Util.decode(request, "id")));
        vo.setDeptName(Util.decode(request, "deptName"));
        vo.setDeptLoc(Util.decode(request, "deptLoc"));
        vo.setDeptCount(Util.decode(request, "deptCount"));
        vo.setDeptLeader(Util.decode(request, "deptLeader"));
        vo.setDeptText(Util.decode(request, "deptText"));
        deptService.update(vo);
        this.redirectList(request, response);
    }

    /**
     * 获取部门的详细信息（详情页面与编辑页面要显示该部门的详情）并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping({"deptGet", "deptEditPre"})
    public void get(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");//取出主键id
        Dept vo = deptService.get(id);
        response.getWriter().println(com.alibaba.fastjson.JSONObject.toJSONString(vo));
    }

    /**
     * 根据条件查询部门的列表并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("deptList")
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
        Map<String, Object> map = deptService.list(params);
        request.getSession().setAttribute("list", map.get("list"));

        Integer totalRecord = (Integer) map.get("totalCount");//根据查询条件取出对应的总记录数，用于分页
        String pageNum = Util.decode(request, "pageNum");//封装分页参数
        com.demo.util.PageBean<Object> pb = new com.demo.util.PageBean(Integer.valueOf(pageNum != null ? pageNum : "1"), totalRecord);
        params.put("startIndex", pb.getStartIndex());
        params.put("pageSize", pb.getPageSize());
        List list = (List) deptService.list(params).get("list");//根据分页参数startIndex、pageSize查询出来的最终结果list
        pb.setServlet("deptList");
        pb.setSearchColumn(searchColumn);
        pb.setKeyword(keyword);
        pb.setList(list);
        request.getSession().setAttribute("pageBean", pb);
        request.getSession().setAttribute("list", pb.getList());

        response.sendRedirect("dept_list.jsp");
    }
}
