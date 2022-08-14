<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>公告管理</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/main.css">
    <script src="js/jquery-3.5.1.js"></script>
    <script src="js/bootstrap.js"></script>
</head>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                    data-toggle="collapse" data-target="#navbar" aria-expanded="false"
                    aria-controls="navbar">
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
                <jsp:param value="active" name="announcement_active"/>
            </jsp:include>
        </div>
        <div id="announcement" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">公告</h1>
            <div class="col-md-12" style="margin-bottom: 5px">
                <button type="button" <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if> class="btn btn-pill btn-line btn-warning" data-toggle="modal" data-target="#modal-add">添加公告
                </button>
            </div>
            <c:forEach items="${list}" var="vo">
                <div class="">
                    <div class="col-md-3">
                        <div class="thumbnail">
                            <div class="caption">
                                <div style="border-bottom: 1px solid black;text-align: center;text-overflow:ellipsis;overflow: hidden"><h4>${vo.title}</h4></div>
                                <div style="height:150px;margin-top: 5px;">${vo.value}</div>
                                <p>
                                    <button type="button" <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if>
                                            class="btn btn-pill btn-line btn-warning btn-sm"
                                            data-id="${vo.id}"
                                            data-toggle="modal"
                                            data-target="#modal-edit">编辑</button>
                                    <button class="btn btn-pill btn-line btn-warning btn-sm" data-id="${vo.id}"
                                            data-toggle="modal" data-target="#modal-info">详情
                                    </button>
                                    <button type="button" <c:if test="${loginUser.userType != '管理员'}">disabled="disabled" title="没有权限！！！"</c:if>
                                            data-id="${vo.id}"
                                            data-toggle="modal"
                                            data-target="#modal-delete"
                                            class="btn btn-pill btn-line btn-warning btn-sm">删除</button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
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
                    <h4 class="modal-title">公告详情</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="info-title" class="control-label">标题:</label>
                        <input type="text" class="form-control" readonly name="announcementTitle" id="info-title">
                    </div>
                    <div class="form-group">
                        <label for="info-value" class="control-label">内容:</label>
                        <textarea style="height: 150px;" readonly class="form-control" name="announcementValue" id="info-value">
                        </textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-pill btn-line btn-warning" data-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- add -->
<div class="modal fade" id="modal-add" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="announcementAdd" onsubmit="return addCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">添加公告</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="add"/>
                    </div>
                    <div class="form-group">
                        <label for="add-title" class="control-label">标题:</label>
                        <input type="text" class="form-control" name="announcementTitle" id="add-title">
                    </div>
                    <div class="form-group">
                        <label for="add-value" class="control-label">内容:</label>
                        <textarea style="height: 150px;" class="form-control" name="announcementValue" id="add-value">
                        </textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-pill btn-line btn-warning" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-pill btn-line btn-warning">提交</button>
                    </div>
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
            <form action="announcementEdit" onsubmit="return editCheck()">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">更新公告</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group hidden">
                        <label class="control-label">(hidden)</label>
                        <input type="text" class="form-control" name="action" value="edit">
                        <input type="text" readonly class="form-control" name="id" id="edit-id">
                    </div>
                    <div class="form-group">
                        <label for="edit-title" class="control-label">标题:</label>
                        <input type="text" class="form-control" name="announcementTitle" id="edit-title">
                    </div>
                    <div class="form-group">
                        <label for="edit-value" class="control-label">内容:</label>
                        <textarea style="height: 150px" type="text" rows="30" cols="30" class="form-control" name="announcementValue" id="edit-value">
                        </textarea>
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
            <form action="announcementDelete">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">删除公告</h4>
                </div>
                <div class="modal-body">
                    确认要删除该公告吗？
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
            url: 'announcementGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                modal.find('#edit-id').val(vo.id);
                modal.find('#edit-title').val(vo.title);
                modal.find('#edit-value').val(vo.value);
            }
        })
    })

    $('#modal-info').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let id = button.data('id');
        let modal = $(this);
        $.ajax({
            url: 'announcementGet?id=' + id,
            type: "get",
            success: function (voString) {
                let vo = eval('(' + voString + ')');
                modal.find('#info-title').val(vo.title);
                modal.find('#info-value').val(vo.value);
            }
        })
    })

    //编辑表单提交之前进行检查，如果return false，则不允许提交
    function editCheck() {
        if (document.getElementById("edit-title").value.trim().length == 0) {
            alert("标题不能为空");
            return false;
        }
        if (document.getElementById("edit-value").value.trim().length == 0) {
            alert("内容不能为空");
            return false;
        }
        return true;
    }

    function addCheck() {
        if (document.getElementById("add-title").value.trim().length == 0) {
            alert("标题不能为空");
            return false;
        }
        if (document.getElementById("add-value").value.trim().length == 0) {
            alert("内容不能为空");
            return false;
        }
        return true;
    }
</script>
</html>
