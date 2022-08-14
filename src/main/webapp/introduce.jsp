<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文件</title>
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
                <jsp:param value="active" name="introduce_active"/>
            </jsp:include>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">文件</h1>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>文件后缀</th>
                        <th>存储路径</th>
                        <th>文件大小</th>
                        <th>类型</th>
                        <th>下载次数</th>
                        <th>上传时间</th>
                        <th>操作</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>.exe</td>
                        <td>word</td>
                        <td>1024</td>
                        <td>text</td>
                        <td>11</td>
                        <td>2022-8-12</td>
                        <td>
                            <a href="">下载</a>
                            <a href="">删除</a>
                        </td>
                    </tr>
                    </thead>
                </table>
                <hr>
                <h3>上传文件</h3>
                <form   action="">
                    <input type="file" name="aaa"><input type="submit" value="上传文件">
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
