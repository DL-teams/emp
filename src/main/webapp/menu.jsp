<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<ul class="nav nav-sidebar">
    <li class="<%=request.getParameter("User_active")%>"><a class="btn btn-pill btn-line btn-warning" href="userList">用户管理</a></li>
    <li class="<%=request.getParameter("Employee_active")%>"><a class="btn btn-pill btn-line btn-warning" href="employeeList">员工管理</a></li>
    <li class="<%=request.getParameter("Dept_active")%>"><a class="btn btn-pill btn-line btn-warning" href="deptList">部门管理</a></li>
    <li class="<%=request.getParameter("Leave_active")%>"><a class="btn btn-pill btn-line btn-warning" href="leaveList">请假管理</a></li>
    <li class="<%=request.getParameter("Salary_active")%>"><a class="btn btn-pill btn-line btn-warning" href="salaryList">工资管理</a></li>

    <li class="<%=request.getParameter("introduce_active")%>"><a class="btn btn-pill btn-line btn-warning" href="introduce.jsp">关于</a></li>
</ul>
