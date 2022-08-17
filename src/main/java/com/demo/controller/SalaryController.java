package com.demo.controller;

import com.demo.util.Util;
import com.demo.service.SalaryService;
import com.demo.vo.Salary;
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
public class SalaryController {

    @Autowired
    private SalaryService salaryService;

    /**
     * 增加工资
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("salaryAdd")
    public void add(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Salary vo = new Salary();
        //取出页面传进来的参数
        vo.setSalaryName(Util.decode(request, "salaryName"));
        vo.setSalaryNo(Util.decode(request, "salaryNo"));
        vo.setSalaryDept(Util.decode(request, "salaryDept"));
        vo.setSalaryMoney(Util.decode(request, "salaryMoney"));
        vo.setSalaryFmoney(Util.decode(request, "salaryFmoney"));
        vo.setSalaryTmoney(Util.decode(request, "salaryTmoney"));
        vo.setSalaryText(Util.decode(request, "salaryText"));
        //调用Service层的增加（insert）方法
        salaryService.insert(vo);
        this.redirectList(request, response);
    }

    /**
     * 删除工资
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("salaryDelete")
    public void delete(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");
        salaryService.delete(Arrays.asList(id));
        this.redirectList(request, response);
    }

    /**
     * 编辑工资
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("salaryEdit")
    public void edit(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Salary vo = new Salary();
        vo.setId(Long.valueOf(Util.decode(request, "id")));
        vo.setSalaryName(Util.decode(request, "salaryName"));
        vo.setSalaryNo(Util.decode(request, "salaryNo"));
        vo.setSalaryDept(Util.decode(request, "salaryDept"));
        vo.setSalaryMoney(Util.decode(request, "salaryMoney"));
        vo.setSalaryFmoney(Util.decode(request, "salaryFmoney"));
        vo.setSalaryTmoney(Util.decode(request, "salaryTmoney"));
        vo.setSalaryText(Util.decode(request, "salaryText"));
        salaryService.update(vo);
        this.redirectList(request, response);
    }

    /**
     * 获取工资的详细信息（详情页面与编辑页面要显示该工资的详情）并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping({"salaryGet", "salaryEditPre"})
    public void get(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Serializable id = Util.decode(request, "id");//取出主键id
        Salary vo = salaryService.get(id);
        response.getWriter().println(com.alibaba.fastjson.JSONObject.toJSONString(vo));
    }

    /**
     * 根据条件查询工资的列表并跳转回页面
     *
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("salaryList")
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
        Map<String, Object> map = salaryService.list(params); //通过list方法获取所有符合条件行的数
        request.getSession().setAttribute("list", map.get("list")); //请求获取符合条件行的数据

        //分页
        Integer totalRecord = (Integer) map.get("totalCount");//给总页数设置为根据查询条件取出对应的总记录行的数据，用于分页
        String pageNum = Util.decode(request, "pageNum");//封装分页参数
        com.demo.util.PageBean<Object> pb = new com.demo.util.PageBean(Integer.valueOf(pageNum != null ? pageNum : "1"), totalRecord);
        params.put("startIndex", pb.getStartIndex());//首页值
        params.put("pageSize", pb.getPageSize());//每页数据条数值

        List list = (List) salaryService.list(params).get("list");//根据分页参数startIndex、pageSize查询出来的最终结果list
        pb.setServlet("salaryList");
        pb.setSearchColumn(searchColumn);
        pb.setKeyword(keyword);
        pb.setList(list);
        request.getSession().setAttribute("pageBean", pb);
        request.getSession().setAttribute("list", pb.getList());

        response.sendRedirect("salary_list.jsp");
    }
}
