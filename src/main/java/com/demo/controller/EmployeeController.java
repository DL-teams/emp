package com.demo.controller;

import com.demo.util.Util;
import com.demo.service.EmployeeService;
import com.demo.vo.Employee;
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
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 增加员工
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("employeeAdd")
    public void add(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Employee vo = new Employee();
        //取出页面传进来的参数
        vo.setEmployeeName(Util.decode(request, "employeeName"));
        vo.setEmployeeSex(Util.decode(request, "employeeSex"));
        vo.setEmployeePhone(Util.decode(request, "employeePhone"));
        vo.setEmployeeDept(Util.decode(request, "employeeDept"));
        vo.setEmployeeJob(Util.decode(request, "employeeJob"));
        vo.setEmployeeNo(Util.decode(request, "employeeNo"));
        vo.setEmployeeAge(Util.decode(request, "employeeAge"));
        vo.setEmployeeEducation(Util.decode(request, "employeeEducation"));
        vo.setEmployeeIntime(Util.decode(request, "employeeIntime"));
        vo.setEmployeeText(Util.decode(request, "employeeText"));
        //调用Service层的增加（insert）方法
        employeeService.insert(vo);
        this.redirectList(request, response);
    }

    /**
     * 删除员工
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("employeeDelete")
    public void delete(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");
        employeeService.delete(Arrays.asList(id));
        this.redirectList(request, response);
    }

    /**
     * 编辑员工
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("employeeEdit")
    public void edit(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Employee vo = new Employee();
        vo.setId(Long.valueOf(Util.decode(request, "id")));
        vo.setEmployeeName(Util.decode(request, "employeeName"));
        vo.setEmployeeSex(Util.decode(request, "employeeSex"));
        vo.setEmployeePhone(Util.decode(request, "employeePhone"));
        vo.setEmployeeDept(Util.decode(request, "employeeDept"));
        vo.setEmployeeJob(Util.decode(request, "employeeJob"));
        vo.setEmployeeNo(Util.decode(request, "employeeNo"));
        vo.setEmployeeAge(Util.decode(request, "employeeAge"));
        vo.setEmployeeEducation(Util.decode(request, "employeeEducation"));
        vo.setEmployeeIntime(Util.decode(request, "employeeIntime"));
        vo.setEmployeeText(Util.decode(request, "employeeText"));
        employeeService.update(vo);
        this.redirectList(request, response);
    }

    /**
     * 获取员工的详细信息（详情页面与编辑页面要显示该员工的详情）并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping({"employeeGet", "employeeEditPre"})
    public void get(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");//取出主键id
        Employee vo = employeeService.get(id);
        response.getWriter().println(com.alibaba.fastjson.JSONObject.toJSONString(vo));
    }

    /**
     * 根据条件查询员工的列表并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("employeeList")
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
        Map<String, Object> map = employeeService.list(params);
        request.getSession().setAttribute("list", map.get("list"));

        Integer totalRecord = (Integer) map.get("totalCount");//根据查询条件取出对应的总记录数，用于分页
        String pageNum = Util.decode(request, "pageNum");//封装分页参数
        com.demo.util.PageBean<Object> pb = new com.demo.util.PageBean(Integer.valueOf(pageNum != null ? pageNum : "1"), totalRecord);
        params.put("startIndex", pb.getStartIndex());
        params.put("pageSize", pb.getPageSize());
        List list = (List) employeeService.list(params).get("list");//根据分页参数startIndex、pageSize查询出来的最终结果list
        pb.setServlet("employeeList");
        pb.setSearchColumn(searchColumn);
        pb.setKeyword(keyword);
        pb.setList(list);
        request.getSession().setAttribute("pageBean", pb);
        request.getSession().setAttribute("list", pb.getList());

        response.sendRedirect("employee_list.jsp");
    }
}
