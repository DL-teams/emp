<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>部门管理</title>
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
                <jsp:param value="active" name="Dept_active"/>
            </jsp:include>
        </div>
        <br>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="row">
                <div class="col-sm-7">
                    <div class="input-group">
                        <input class="form-control" type="hidden" id="searchColumn" name="searchColumn" value="dept_name"/>
                        <input class="form-control" type="text" id="search_keyword" name="search_keyword" placeholder="名称"/> <span class="input-group-btn"><button class="btn btn-pill btn-line btn-warning" type="button" onclick="searchList()">搜索</button></span>
                    </div>
                </div>
                <div class="col-sm-5">
                    <button type="button" <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if> class="btn btn-pill btn-line btn-warning" data-toggle="modal" data-target="#modal-add">添加部门
                    </button>
                </div>
            </div>
            <br>
            <br>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                            <th>名称</th>
                            <th>地点</th>
                            <th>员工数量</th>
                            <th>部门领导</th>
                            <th>详细信息</th>
                        <th style="text-align: center;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="vo">
                        <tr>
                <td>${vo.deptName}</td>
                <td>${vo.deptLoc}</td>
                <td>${vo.deptCount}</td>
                <td>${vo.deptLeader}</td>
                <td title="${vo.deptText}">
                <c:choose>
                    <c:when test="${fn:length(vo.deptText) > 19}">
                        <c:out value="${fn:substring(vo.deptText, 0, 19)}..."/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${vo.deptText}"/>
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
            <form action="deptAdd" onsubmit="return addCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">增加部门</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="add">
                    </div>
                    <div class="form-group">
                        <label for="add-deptName" class="control-label">名称:</label>
                        <input type="text" class="form-control" name="deptName" id="add-deptName">
                    </div>
                    <div class="form-group">
                        <label for="add-deptLoc" class="control-label">地点:</label>
                        <input type="text" class="form-control" name="deptLoc" id="add-deptLoc">
                    </div>
                    <div class="form-group">
                        <label for="add-deptCount" class="control-label">员工数量:</label>
                        <input type="text" class="form-control" name="deptCount" id="add-deptCount">
                    </div>
                    <div class="form-group">
                        <label for="add-deptLeader" class="control-label">部门领导:</label>
                        <input type="text" class="form-control" name="deptLeader" id="add-deptLeader">
                    </div>
                    <div class="form-group">
                        <label for="add-deptText" class="control-label">详细信息:</label>
                        <textarea style="height: 100px;" class="form-control" name="deptText" id="add-deptText"></textarea>
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
                    <h4 class="modal-title">部门</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-hover" style="font-size: 15px;">
                        <tr>
                            <td style="width: 15%;">名称:</td>
                            <td><b id="info-deptName"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">地点:</td>
                            <td><b id="info-deptLoc"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">员工数量:</td>
                            <td><b id="info-deptCount"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">部门领导:</td>
                            <td><b id="info-deptLeader"></b></td>
                        </tr>
                        <tr>
                            <td style="width: 15%;">详细信息:</td>
                            <td><b id="info-deptText"></b></td>
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
            <form action="deptEdit" onsubmit="return editCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">更新部门</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="edit">
                        <input type="text" readonly class="form-control" name="id" id="edit-id">
                    </div>
                    <div class="form-group">
                        <label for="edit-deptName" class="control-label">名称:</label>
                        <input type="text" class="form-control" name="deptName" id="edit-deptName">
                    </div>
                    <div class="form-group">
                        <label for="edit-deptLoc" class="control-label">地点:</label>
                        <input type="text" class="form-control" name="deptLoc" id="edit-deptLoc">
                    </div>
                    <div class="form-group">
                        <label for="edit-deptCount" class="control-label">员工数量:</label>
                        <input type="text" class="form-control" name="deptCount" id="edit-deptCount">
                    </div>
                    <div class="form-group">
                        <label for="edit-deptLeader" class="control-label">部门领导:</label>
                        <input type="text" class="form-control" name="deptLeader" id="edit-deptLeader">
                    </div>
                    <div class="form-group">
                        <label for="edit-deptText" class="control-label">详细信息:</label>
                        <textarea style="height: 100px;" class="form-control" name="deptText" id="edit-deptText"></textarea>
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
            <form action="deptDelete">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除部门</h4>
                </div>
                <div class="modal-body">
                    确认要删除该部门记录吗？
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
            url: 'deptGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                        modal.find('#edit-id').val(vo.id);
                        modal.find('#edit-deptName').val(vo.deptName);
                        modal.find('#edit-deptLoc').val(vo.deptLoc);
                        modal.find('#edit-deptCount').val(vo.deptCount);
                        modal.find('#edit-deptLeader').val(vo.deptLeader);
                        modal.find('#edit-deptText').val(vo.deptText);
            }
        })
    })
    $('#modal-info').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let id = button.data('id');
        let modal = $(this);
        $.ajax({
            url: 'deptGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                modal.find('#info-deptName').text(vo.deptName);
                modal.find('#info-deptLoc').text(vo.deptLoc);
                modal.find('#info-deptCount').text(vo.deptCount);
                modal.find('#info-deptLeader').text(vo.deptLeader);
                modal.find('#info-deptText').text(vo.deptText);
            }
        })
    })
    function searchList() {
        window.location.href = "deptList?searchColumn="+document.getElementById("searchColumn").value+"&keyword=" + document.getElementById("search_keyword").value;
    }
    //增加表单提交之前进行检查，如果return false，则不允许提交
    function addCheck() {
        //根据ID获取值
        if (document.getElementById("add-deptName").value.trim().length == 0) {
            alert("名称不能为空");
            return false;
        }
        if (document.getElementById("add-deptLoc").value.trim().length == 0) {
            alert("地点不能为空");
            return false;
        }
        if (document.getElementById("add-deptCount").value.trim().length == 0) {
            alert("员工数量不能为空");
            return false;
        }
        if (document.getElementById("add-deptLeader").value.trim().length == 0) {
            alert("部门领导不能为空");
            return false;
        }
        return true;
    }
    //编辑表单提交之前进行检查，如果return false，则不允许提交
    function editCheck() {
        //根据ID获取值
        if (document.getElementById("edit-deptName").value.trim().length == 0) {
            alert("名称不能为空");
            return false;
        }
        if (document.getElementById("edit-deptLoc").value.trim().length == 0) {
            alert("地点不能为空");
            return false;
        }
        if (document.getElementById("edit-deptCount").value.trim().length == 0) {
            alert("员工数量不能为空");
            return false;
        }
        if (document.getElementById("edit-deptLeader").value.trim().length == 0) {
            alert("部门领导不能为空");
            return false;
        }
        return true;
    }
</script>
</html>
