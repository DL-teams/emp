<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工管理</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/main.css">
    <script src="js/jquery-3.5.1.js"></script>
    <script src="js/bootstrap.js"></script>
</head>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">职工信息系统</span> <span class="icon-bar"></span>
                <span class="icon-bar"></span> <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">职工信息系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎：<span style="color: yellow">${loginUser.username}</span></a></li>
                <li><a href="authLogout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <!-- 侧边栏 -->
            <jsp:include page="menu.jsp">
                <jsp:param value="active" name="Employee_active"/>
            </jsp:include>
        </div>
        <br>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="row">
                <div class="col-sm-7">
                    <div class="input-group">
                        <input class="form-control" type="hidden" id="searchColumn" name="searchColumn" value="employee_name"/>
                        <input class="form-control" type="text" id="search_keyword" name="search_keyword" placeholder="姓名"/> <span class="input-group-btn"><button class="btn btn-pill btn-line btn-warning" type="button" onclick="searchList()">搜索</button></span>
                    </div>
                </div>
                <div class="col-sm-5">
                    <button type="button" <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if> class="btn btn-pill btn-line btn-warning" data-toggle="modal" data-target="#modal-add">添加员工
                    </button>
                </div>
            </div>
            <br>
            <br>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>联系方式</th>
                            <th>所属部门</th>
                            <th>职位</th>
                            <th>工号</th>
                            <th>年龄</th>
                            <th>学历</th>
                            <th>入职时间</th>
                            <th>备注</th>
                        <th style="text-align: center;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="vo">
                        <tr>
                <td>${vo.employeeName}</td>
                <td>${vo.employeeSex}</td>
                <td>${vo.employeePhone}</td>
                <td>${vo.employeeDept}</td>
                <td>${vo.employeeJob}</td>
                <td>${vo.employeeNo}</td>
                <td>${vo.employeeAge}</td>
                <td>${vo.employeeEducation}</td>
                <td>${vo.employeeIntime}</td>
                <td title="${vo.employeeText}">
                <c:choose>
                    <c:when test="${fn:length(vo.employeeText) > 19}">
                        <c:out value="${fn:substring(vo.employeeText, 0, 19)}..."/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${vo.employeeText}"/>
                    </c:otherwise>
                </c:choose>
                </td>
                            <th style="text-align: center;">
                                <button class="btn btn-pill btn-line btn-warning btn-sm" data-id="${vo.id}"
                                        data-toggle="modal" data-target="#modal-info">详情
                                </button>
                                <button class="btn btn-pill btn-line btn-default btn-sm"
                                                <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if>
                                        data-id="${vo.id}"
                                        data-toggle="modal" data-target="#modal-edit">编辑
                                </button>
                                <button class="btn btn-pill btn-line btn-warning btn-sm" <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if> data-id="${vo.id}"
                                        data-toggle="modal" data-target="#modal-delete">删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div style="float: right;padding-right: 10px;color: #515151;"><jsp:include page="split.jsp"/></div>
        </div>
    </div>
</div>

<!-- add -->
<div class="modal fade" id="modal-add" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="employeeAdd" onsubmit="return addCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">增加员工</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="add">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeName" class="control-label">姓名:</label>
                        <input type="text" class="form-control" name="employeeName" id="add-employeeName">
                    </div>
                    <div class="form-group">
                        <label class="control-label">性别:</label>
                        <input name="employeeSex" id="add-employeeSex_男" type="radio" value="男" checked="checked"/>男
                        <input name="employeeSex" id="add-employeeSex_女" type="radio" value="女"/>女
                    </div>
                    <div class="form-group">
                        <label for="add-employeePhone" class="control-label">联系方式:</label>
                        <input type="text" class="form-control" name="employeePhone" id="add-employeePhone">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeDept" class="control-label">所属部门:</label>
                        <input type="text" class="form-control" name="employeeDept" id="add-employeeDept">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeJob" class="control-label">职位:</label>
                        <input type="text" class="form-control" name="employeeJob" id="add-employeeJob">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeNo" class="control-label">工号:</label>
                        <input type="text" class="form-control" name="employeeNo" id="add-employeeNo">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeAge" class="control-label">年龄:</label>
                        <input type="text" class="form-control" name="employeeAge" id="add-employeeAge">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeEducation" class="control-label">学历:</label>
                        <input type="text" class="form-control" name="employeeEducation" id="add-employeeEducation">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeIntime" class="control-label">入职时间:</label>
                        <input type="text" class="form-control" name="employeeIntime" id="add-employeeIntime">
                    </div>
                    <div class="form-group">
                        <label for="add-employeeText" class="control-label">备注:</label>
                        <textarea style="height: 100px;" class="form-control" name="employeeText" id="add-employeeText"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-pill btn-line btn-warning" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-pill btn-line btn-warning">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- info -->
<div class="modal fade" id="modal-info" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">员工</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-hover" style="font-size: 15px;">
                        <tr>
                            <td style="width: 15%;">姓名:</td>
                            <td><b id="info-employeeName"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">性别:</td>
                            <td><b id="info-employeeSex"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">联系方式:</td>
                            <td><b id="info-employeePhone"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">所属部门:</td>
                            <td><b id="info-employeeDept"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">职位:</td>
                            <td><b id="info-employeeJob"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">工号:</td>
                            <td><b id="info-employeeNo"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">年龄:</td>
                            <td><b id="info-employeeAge"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">学历:</td>
                            <td><b id="info-employeeEducation"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">入职时间:</td>
                            <td><b id="info-employeeIntime"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">备注:</td>
                            <td><b id="info-employeeText"></b></td>
                        </tr>
                    </table>
                    <br>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-pill btn-line btn-warning" data-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- edit -->
<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="employeeEdit" onsubmit="return editCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">更新员工</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="edit">
                        <input type="text" readonly class="form-control" name="id" id="edit-id">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeName" class="control-label">姓名:</label>
                        <input type="text" class="form-control" name="employeeName" id="edit-employeeName">
                    </div>
                    <div class="form-group">
                        <label class="control-label">性别:</label>
                               <input name="employeeSex" id="edit-employeeSex_男" type="radio" value="男"/>男
                               <input name="employeeSex" id="edit-employeeSex_女" type="radio" value="女"/>女
                    </div>
                    <div class="form-group">
                        <label for="edit-employeePhone" class="control-label">联系方式:</label>
                        <input type="text" class="form-control" name="employeePhone" id="edit-employeePhone">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeDept" class="control-label">所属部门:</label>
                        <input type="text" class="form-control" name="employeeDept" id="edit-employeeDept">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeJob" class="control-label">职位:</label>
                        <input type="text" class="form-control" name="employeeJob" id="edit-employeeJob">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeNo" class="control-label">工号:</label>
                        <input type="text" class="form-control" name="employeeNo" id="edit-employeeNo">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeAge" class="control-label">年龄:</label>
                        <input type="text" class="form-control" name="employeeAge" id="edit-employeeAge">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeEducation" class="control-label">学历:</label>
                        <input type="text" class="form-control" name="employeeEducation" id="edit-employeeEducation">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeIntime" class="control-label">入职时间:</label>
                        <input type="text" class="form-control" name="employeeIntime" id="edit-employeeIntime">
                    </div>
                    <div class="form-group">
                        <label for="edit-employeeText" class="control-label">备注:</label>
                        <textarea style="height: 100px;" class="form-control" name="employeeText" id="edit-employeeText"></textarea>
                    </div>
                    <div class="form-group hidden">
                        <label for="edit-createTime" class="control-label">创建时间:</label>
                        <input type="text" class="form-control" name="createTime" id="edit-createTime">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-pill btn-line btn-warning" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-pill btn-line btn-warning">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- delete -->
<div class="modal fade" id="modal-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="employeeDelete">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除员工</h4>
                </div>
                <div class="modal-body">
                    确认要删除该员工记录吗？
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="hidden" class="form-control" name="action" value="delete">
                        <input type="text" class="form-control" name="id" id="delete-id">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-pill btn-line btn-warning" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-pill btn-line btn-warning">删除</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
<script>
    $('#modal-delete').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let id = button.data('id');
        let modal = $(this);
        modal.find('#delete-id').val(id);
    })

    $('#modal-edit').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let id = button.data('id');
        let modal = $(this);
        $.ajax({
            url: 'employeeGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                        modal.find('#edit-id').val(vo.id);
                        modal.find('#edit-employeeName').val(vo.employeeName);
                        for (let val of "男/女".split('/')) {
                            if (val == vo.employeeSex) {
                                modal.find('#edit-employeeSex_' + vo.employeeSex).prop("checked", true);
                            } else {
                                modal.find('#edit-employeeSex_' + vo.employeeSex).removeAttr("checked");
                            }
                        };
                        modal.find('#edit-employeePhone').val(vo.employeePhone);
                        modal.find('#edit-employeeDept').val(vo.employeeDept);
                        modal.find('#edit-employeeJob').val(vo.employeeJob);
                        modal.find('#edit-employeeNo').val(vo.employeeNo);
                        modal.find('#edit-employeeAge').val(vo.employeeAge);
                        modal.find('#edit-employeeEducation').val(vo.employeeEducation);
                        modal.find('#edit-employeeIntime').val(vo.employeeIntime);
                        modal.find('#edit-employeeText').val(vo.employeeText);
            }
        })
    })
    $('#modal-info').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let id = button.data('id');
        let modal = $(this);
        $.ajax({
            url: 'employeeGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                modal.find('#info-employeeName').text(vo.employeeName);
                modal.find('#info-employeeSex').text(vo.employeeSex);
                modal.find('#info-employeePhone').text(vo.employeePhone);
                modal.find('#info-employeeDept').text(vo.employeeDept);
                modal.find('#info-employeeJob').text(vo.employeeJob);
                modal.find('#info-employeeNo').text(vo.employeeNo);
                modal.find('#info-employeeAge').text(vo.employeeAge);
                modal.find('#info-employeeEducation').text(vo.employeeEducation);
                modal.find('#info-employeeIntime').text(vo.employeeIntime);
                modal.find('#info-employeeText').text(vo.employeeText);
            }
        })
    })
    function searchList() {
        window.location.href = "employeeList?searchColumn="+document.getElementById("searchColumn").value+"&keyword=" + document.getElementById("search_keyword").value;
    }
    //增加表单提交之前进行检查，如果return false，则不允许提交
    function addCheck() {
        //根据ID获取值
        if (document.getElementById("add-employeeName").value.trim().length == 0) {
            alert("姓名不能为空");
            return false;
        }
        if (document.getElementById("add-employeePhone").value.trim().length == 0) {
            alert("联系方式不能为空");
            return false;
        }
        if (document.getElementById("add-employeeDept").value.trim().length == 0) {
            alert("所属部门不能为空");
            return false;
        }
        if (document.getElementById("add-employeeJob").value.trim().length == 0) {
            alert("职位不能为空");
            return false;
        }
        if (document.getElementById("add-employeeNo").value.trim().length == 0) {
            alert("工号不能为空");
            return false;
        }
        if (document.getElementById("add-employeeAge").value.trim().length == 0) {
            alert("年龄不能为空");
            return false;
        }
        if (document.getElementById("add-employeeEducation").value.trim().length == 0) {
            alert("学历不能为空");
            return false;
        }
        if (document.getElementById("add-employeeIntime").value.trim().length == 0) {
            alert("入职时间不能为空");
            return false;
        }
        return true;
    }
    //编辑表单提交之前进行检查，如果return false，则不允许提交
    function editCheck() {
        //根据ID获取值
        if (document.getElementById("edit-employeeName").value.trim().length == 0) {
            alert("姓名不能为空");
            return false;
        }
        if (document.getElementById("edit-employeePhone").value.trim().length == 0) {
            alert("联系方式不能为空");
            return false;
        }
        if (document.getElementById("edit-employeeDept").value.trim().length == 0) {
            alert("所属部门不能为空");
            return false;
        }
        if (document.getElementById("edit-employeeJob").value.trim().length == 0) {
            alert("职位不能为空");
            return false;
        }
        if (document.getElementById("edit-employeeNo").value.trim().length == 0) {
            alert("工号不能为空");
            return false;
        }
        if (document.getElementById("edit-employeeAge").value.trim().length == 0) {
            alert("年龄不能为空");
            return false;
        }
        if (document.getElementById("edit-employeeEducation").value.trim().length == 0) {
            alert("学历不能为空");
            return false;
        }
        if (document.getElementById("edit-employeeIntime").value.trim().length == 0) {
            alert("入职时间不能为空");
            return false;
        }
        return true;
    }
</script>
</html>
