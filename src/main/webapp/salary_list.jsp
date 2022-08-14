<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>工资管理</title>
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
                <jsp:param value="active" name="Salary_active"/>
            </jsp:include>
        </div>
        <br>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="row">
                <div class="col-sm-7">
                    <div class="input-group">
                        <input class="form-control" type="hidden" id="searchColumn" name="searchColumn" value="salary_name"/>
                        <input class="form-control" type="text" id="search_keyword" name="search_keyword" placeholder="姓名"/> <span class="input-group-btn"><button class="btn btn-pill btn-line btn-warning" type="button" onclick="searchList()">搜索</button></span>
                    </div>
                </div>
                <div class="col-sm-5">
                    <button type="button" <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if> class="btn btn-pill btn-line btn-warning" data-toggle="modal" data-target="#modal-add">添加工资
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
                            <th>工号</th>
                            <th>部门</th>
                        <th>薪资</th>
                        <th>扣除薪资</th>
                        <th>实发薪资</th>
                            <th>备注</th>
                        <th style="text-align: center;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="vo">
                        <tr>
                <td>${vo.salaryName}</td>
                <td>${vo.salaryNo}</td>
                <td>${vo.salaryDept}</td>
                <td>${vo.salaryMoney}</td>
                <td>${vo.salaryFmoney}</td>
                <td>${vo.salaryTmoney}</td>
                <td title="${vo.salaryText}">
                <c:choose>
                    <c:when test="${fn:length(vo.salaryText) > 19}">
                        <c:out value="${fn:substring(vo.salaryText, 0, 19)}..."/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${vo.salaryText}"/>
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
            <form action="salaryAdd" onsubmit="return addCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">工资表</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="add">
                    </div>
                    <div class="form-group">
                        <label for="add-salaryName" class="control-label">姓名:</label>
                        <input type="text" class="form-control" name="salaryName" id="add-salaryName">
                    </div>
                    <div class="form-group">
                        <label for="add-salaryNo" class="control-label">工号:</label>
                        <input type="text" class="form-control" name="salaryNo" id="add-salaryNo">
                    </div>
                    <div class="form-group">
                        <label for="add-salaryDept" class="control-label">部门:</label>
                        <input type="text" class="form-control" name="salaryDept" id="add-salaryDept">
                    </div>
                    <div class="form-group">
                        <label for="add-salaryMoney" class="control-label">薪资:</label>
                        <input type="text" class="form-control" name="salaryMoney" id="add-salaryMoney" onchange="countSalary()">
                    </div>
                    <div class="form-group">
                        <label for="add-salaryMoney" class="control-label">扣除薪资:</label>
                        <input type="text" class="form-control" name="salaryFmoney" id="add-salaryFmoney" onchange="countSalary()">
                    </div>
                    <div class="form-group">
                        <label for="add-salaryMoney" class="control-label">实际薪资:</label>
                        <input type="text" class="form-control" name="salaryTmoney" id="add-salaryTmoney" readonly>
                    </div>

                    <div class="form-group">
                        <label for="add-salaryText" class="control-label">备注:</label>
                        <textarea style="height: 100px;" class="form-control" name="salaryText" id="add-salaryText"></textarea>
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
                    <h4 class="modal-title">工资</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-hover" style="font-size: 15px;">
                        <tr>
                            <td style="width: 15%;">姓名:</td>
                            <td><b id="info-salaryName"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">工号:</td>
                            <td><b id="info-salaryNo"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">部门:</td>
                            <td><b id="info-salaryDept"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">薪资:</td>
                            <td><b id="info-salaryMoney"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">扣除薪资:</td>
                            <td><b id="info-salaryFmoney"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">实际薪资:</td>
                            <td><b id="info-salaryTmoney"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">备注:</td>
                            <td><b id="info-salaryText"></b></td>
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
            <form action="salaryEdit" onsubmit="return editCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">更新工资</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="edit">
                        <input type="text" readonly class="form-control" name="id" id="edit-id">
                    </div>
                    <div class="form-group">
                        <label for="edit-salaryName" class="control-label">姓名:</label>
                        <input type="text" class="form-control" name="salaryName" id="edit-salaryName">
                    </div>
                    <div class="form-group">
                        <label for="edit-salaryNo" class="control-label">工号:</label>
                        <input type="text" class="form-control" name="salaryNo" id="edit-salaryNo">
                    </div>
                    <div class="form-group">
                        <label for="edit-salaryDept" class="control-label">部门:</label>
                        <input type="text" class="form-control" name="salaryDept" id="edit-salaryDept">
                    </div>
                    <div class="form-group">
                        <label for="edit-salaryMoney" class="control-label">薪资:</label>
                        <input type="text" class="form-control" name="salaryMoney" id="edit-salaryMoney" onchange="countEditSalary()">
                    </div>
                    <div class="form-group">
                        <label for="edit-salaryMoney" class="control-label">扣除薪资:</label>
                        <input type="text" class="form-control" name="salaryFmoney" id="edit-salaryFmoney" onchange="countEditSalary()">
                    </div>
                    <div class="form-group">
                        <label for="edit-salaryMoney" class="control-label">实际薪资:</label>
                        <input type="text" class="form-control" name="salaryTmoney" id="edit-salaryTmoney" readonly>
                    </div>
                    <div class="form-group">
                        <label for="edit-salaryText" class="control-label">备注:</label>
                        <textarea style="height: 100px;" class="form-control" name="salaryText" id="edit-salaryText"></textarea>
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
            <form action="salaryDelete">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除工资</h4>
                </div>
                <div class="modal-body">
                    确认要删除该工资记录吗？
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
            url: 'salaryGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                modal.find('#edit-id').val(vo.id);
                modal.find('#edit-salaryName').val(vo.salaryName);
                modal.find('#edit-salaryNo').val(vo.salaryNo);
                modal.find('#edit-salaryDept').val(vo.salaryDept);
                modal.find('#edit-salaryMoney').val(vo.salaryMoney);
                modal.find('#edit-salaryFmoney').val(vo.salaryFmoney);
                console.log(vo.salaryFmoney)
                if (vo.salaryFmoney !== '' && vo.salaryFmoney !== undefined) {
                    var salaryTmoney = vo.salaryMoney - vo.salaryFmoney;
                    if (salaryTmoney > 0) {
                        modal.find('#edit-salaryTmoney').val(vo.salaryMoney - vo.salaryFmoney);
                    } else {
                        modal.find('#edit-salaryTmoney').val(0);
                    }
                } else {
                    modal.find('#edit-salaryTmoney').val(vo.salaryMoney);
                }
                modal.find('#edit-salaryText').val(vo.salaryText);
            }
        })
    })
    $('#modal-info').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let id = button.data('id');
        let modal = $(this);
        $.ajax({
            url: 'salaryGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                modal.find('#info-salaryName').text(vo.salaryName);
                modal.find('#info-salaryNo').text(vo.salaryNo);
                modal.find('#info-salaryDept').text(vo.salaryDept);
                modal.find('#info-salaryMoney').text(vo.salaryMoney);
                modal.find('#info-salaryFmoney').text(vo.salaryFmoney);
                modal.find('#info-salaryTmoney').text(vo.salaryTmoney);
                modal.find('#info-salaryText').text(vo.salaryText);
            }
        })
    })

    function countSalary() {
        var salaryMoney = $("#add-salaryMoney").val()
        var salaryFmoney = $("#add-salaryFmoney").val()
        if (salaryFmoney !== '') {
            var salaryTmoney = salaryMoney - salaryFmoney
            if (salaryTmoney >= 0) {
                $("#add-salaryTmoney").val(salaryMoney - salaryFmoney)
            } else {
                $("#add-salaryTmoney").val(0)
            }
        } else {
            $("#add-salaryTmoney").val(salaryMoney)
        }
    }

    function countEditSalary() {
        var salaryMoney = $("#edit-salaryMoney").val()
        var salaryFmoney = $("#edit-salaryFmoney").val()
        if (salaryFmoney !== '') {
            var salaryTmoney = salaryMoney - salaryFmoney
            if (salaryTmoney >= 0) {
                $("#edit-salaryTmoney").val(salaryMoney - salaryFmoney)
            } else {
                $("#edit-salaryTmoney").val(0)
            }
        } else {
            $("#edit-salaryTmoney").val(salaryMoney)
        }
    }
    function searchList() {
        window.location.href = "salaryList?searchColumn="+document.getElementById("searchColumn").value+"&keyword=" + document.getElementById("search_keyword").value;
    }
    //增加表单提交之前进行检查，如果return false，则不允许提交
    function addCheck() {
        //根据ID获取值
        if (document.getElementById("add-salaryName").value.trim().length == 0) {
            alert("姓名不能为空");
            return false;
        }
        if (document.getElementById("add-salaryNo").value.trim().length == 0) {
            alert("工号不能为空");
            return false;
        }
        if (document.getElementById("add-salaryDept").value.trim().length == 0) {
            alert("部门不能为空");
            return false;
        }
        if (document.getElementById("add-salaryMoney").value.trim().length == 0) {
            alert("薪资不能为空");
            return false;
        }
        return true;
    }
    //编辑表单提交之前进行检查，如果return false，则不允许提交
    function editCheck() {
        //根据ID获取值
        if (document.getElementById("edit-salaryName").value.trim().length == 0) {
            alert("姓名不能为空");
            return false;
        }
        if (document.getElementById("edit-salaryNo").value.trim().length == 0) {
            alert("工号不能为空");
            return false;
        }
        if (document.getElementById("edit-salaryDept").value.trim().length == 0) {
            alert("部门不能为空");
            return false;
        }
        if (document.getElementById("edit-salaryMoney").value.trim().length == 0) {
            alert("薪资不能为空");
            return false;
        }
        return true;
    }
</script>
</html>
