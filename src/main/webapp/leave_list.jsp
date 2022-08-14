<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>请假管理</title>
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
                <jsp:param value="active" name="Leave_active"/>
            </jsp:include>
        </div>
        <br>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="row">
                <div class="col-sm-7">
                    <div class="input-group">
                        <input class="form-control" type="hidden" id="searchColumn" name="searchColumn" value="leave_name"/>
                        <input class="form-control" type="text" id="search_keyword" name="search_keyword" placeholder="姓名"/> <span class="input-group-btn"><button class="btn btn-pill btn-line btn-warning" type="button" onclick="searchList()">搜索</button></span>
                    </div>
                </div>
                <div class="col-sm-5">
                    <button type="button" class="btn btn-pill btn-line btn-warning" data-toggle="modal" data-target="#modal-add">添加请假
                    </button>
                </div>
            </div>
            <br>
            <br>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                            <th>工号</th>
                            <th>姓名</th>
                            <th>开始</th>
                            <th>结束</th>
                            <th>天数</th>
                            <th>事由</th>
                            <th>备注</th>
                        <th style="text-align: center;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="vo">
                        <tr>
                <td>${vo.leaveNo}</td>
                <td>${vo.leaveName}</td>
                <td>${vo.leaveStart}</td>
                <td>${vo.leaveEnd}</td>
                <td>${vo.leaveDays}</td>
                <td>${vo.leaveReason}</td>
                <td title="${vo.leaveText}">
                <c:choose>
                    <c:when test="${fn:length(vo.leaveText) > 19}">
                        <c:out value="${fn:substring(vo.leaveText, 0, 19)}..."/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${vo.leaveText}"/>
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
            <form action="leaveAdd" onsubmit="return addCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">增加请假</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="add">
                    </div>
                    <div class="form-group">
                        <label for="add-leaveNo" class="control-label">工号:</label>
                        <input type="text" class="form-control" name="leaveNo" id="add-leaveNo">
                    </div>
                    <div class="form-group">
                        <label for="add-leaveName" class="control-label">姓名:</label>
                        <input type="text" class="form-control" name="leaveName" id="add-leaveName">
                    </div>
                    <div class="form-group">
                        <label for="add-leaveStart" class="control-label">开始:</label>
                        <input type="text" class="form-control" name="leaveStart" id="add-leaveStart">
                    </div>
                    <div class="form-group">
                        <label for="add-leaveEnd" class="control-label">结束:</label>
                        <input type="text" class="form-control" name="leaveEnd" id="add-leaveEnd">
                    </div>
                    <div class="form-group">
                        <label for="add-leaveDays" class="control-label">天数:</label>
                        <input type="text" class="form-control" name="leaveDays" id="add-leaveDays">
                    </div>
                    <div class="form-group">
                        <label for="add-leaveReason" class="control-label">事由:</label>
                        <input type="text" class="form-control" name="leaveReason" id="add-leaveReason">
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
                    <h4 class="modal-title">请假</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-hover" style="font-size: 15px;">
                        <tr>
                            <td style="width: 15%;">工号:</td>
                            <td><b id="info-leaveNo"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">姓名:</td>
                            <td><b id="info-leaveName"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">开始:</td>
                            <td><b id="info-leaveStart"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">结束:</td>
                            <td><b id="info-leaveEnd"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">天数:</td>
                            <td><b id="info-leaveDays"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">事由:</td>
                            <td><b id="info-leaveReason"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">审批结果:</td>
                            <td><b id="info-leaveText"></b></td>
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
            <form action="leaveEdit" onsubmit="return editCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">更新请假</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="edit">
                        <input type="text" readonly class="form-control" name="id" id="edit-id">
                    </div>
                    <div class="form-group">
                        <label for="edit-leaveNo" class="control-label">工号:</label>
                        <input type="text" class="form-control" name="leaveNo" id="edit-leaveNo">
                    </div>
                    <div class="form-group">
                        <label for="edit-leaveName" class="control-label">姓名:</label>
                        <input type="text" class="form-control" name="leaveName" id="edit-leaveName">
                    </div>
                    <div class="form-group">
                        <label for="edit-leaveStart" class="control-label">开始:</label>
                        <input type="text" class="form-control" name="leaveStart" id="edit-leaveStart">
                    </div>
                    <div class="form-group">
                        <label for="edit-leaveEnd" class="control-label">结束:</label>
                        <input type="text" class="form-control" name="leaveEnd" id="edit-leaveEnd">
                    </div>
                    <div class="form-group">
                        <label for="edit-leaveDays" class="control-label">天数:</label>
                        <input type="text" class="form-control" name="leaveDays" id="edit-leaveDays">
                    </div>
                    <div class="form-group">
                        <label for="edit-leaveReason" class="control-label">事由:</label>
                        <input type="text" class="form-control" name="leaveReason" id="edit-leaveReason">
                    </div>
                    <div class="form-group">
                        <label for="edit-leaveText" class="control-label">审批结果:</label>
                        <textarea style="height: 100px;" class="form-control" name="leaveText" id="edit-leaveText"></textarea>
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
            <form action="leaveDelete">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除请假</h4>
                </div>
                <div class="modal-body">
                    确认要删除该请假记录吗？
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
            url: 'leaveGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                        modal.find('#edit-id').val(vo.id);
                        modal.find('#edit-leaveNo').val(vo.leaveNo);
                        modal.find('#edit-leaveName').val(vo.leaveName);
                        modal.find('#edit-leaveStart').val(vo.leaveStart);
                        modal.find('#edit-leaveEnd').val(vo.leaveEnd);
                        modal.find('#edit-leaveDays').val(vo.leaveDays);
                        modal.find('#edit-leaveReason').val(vo.leaveReason);
                        modal.find('#edit-leaveText').val(vo.leaveText);
            }
        })
    })
    $('#modal-info').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let id = button.data('id');
        let modal = $(this);
        $.ajax({
            url: 'leaveGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                modal.find('#info-leaveNo').text(vo.leaveNo);
                modal.find('#info-leaveName').text(vo.leaveName);
                modal.find('#info-leaveStart').text(vo.leaveStart);
                modal.find('#info-leaveEnd').text(vo.leaveEnd);
                modal.find('#info-leaveDays').text(vo.leaveDays);
                modal.find('#info-leaveReason').text(vo.leaveReason);
                modal.find('#info-leaveText').text(vo.leaveText);
            }
        })
    })
    function searchList() {
        window.location.href = "leaveList?searchColumn="+document.getElementById("searchColumn").value+"&keyword=" + document.getElementById("search_keyword").value;
    }
    //增加表单提交之前进行检查，如果return false，则不允许提交
    function addCheck() {
        //根据ID获取值
        if (document.getElementById("add-leaveNo").value.trim().length == 0) {
            alert("工号不能为空");
            return false;
        }
        if (document.getElementById("add-leaveName").value.trim().length == 0) {
            alert("姓名不能为空");
            return false;
        }
        if (document.getElementById("add-leaveStart").value.trim().length == 0) {
            alert("开始不能为空");
            return false;
        }
        if (document.getElementById("add-leaveEnd").value.trim().length == 0) {
            alert("结束不能为空");
            return false;
        }
        if (document.getElementById("add-leaveDays").value.trim().length == 0) {
            alert("天数不能为空");
            return false;
        }
        if (document.getElementById("add-leaveReason").value.trim().length == 0) {
            alert("事由不能为空");
            return false;
        }
        return true;
    }
    //编辑表单提交之前进行检查，如果return false，则不允许提交
    function editCheck() {
        //根据ID获取值
        if (document.getElementById("edit-leaveNo").value.trim().length == 0) {
            alert("工号不能为空");
            return false;
        }
        if (document.getElementById("edit-leaveName").value.trim().length == 0) {
            alert("姓名不能为空");
            return false;
        }
        if (document.getElementById("edit-leaveStart").value.trim().length == 0) {
            alert("开始不能为空");
            return false;
        }
        if (document.getElementById("edit-leaveEnd").value.trim().length == 0) {
            alert("结束不能为空");
            return false;
        }
        if (document.getElementById("edit-leaveDays").value.trim().length == 0) {
            alert("天数不能为空");
            return false;
        }
        if (document.getElementById("edit-leaveReason").value.trim().length == 0) {
            alert("事由不能为空");
            return false;
        }
        return true;
    }
</script>
</html>
