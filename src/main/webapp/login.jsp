<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/main.css">
    <script src="js/jquery-3.5.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <style>
        body{padding: 0;margin: 0;background: url("img/1.jpg") no-repeat;background-size: 100%;}


        #main_form {
            width: 300px;
            height: 150px;
            margin: 100px auto;

            background-color: #F0F0F0;
            border: 1px solid #c2c2c2;
        }

        #input_content {
            margin-top: 20px;
            text-align: center;
            border: 5px;
        }

        #verify_image, #submit_btn {
            text-align: center;
            margin: 20px auto;
        }


    </style>
    <script type="text/javascript">
        let alert_msg = '${alert_msg}';
        if (alert_msg != null && alert_msg.trim() != '') {
            window.alert(alert_msg);
        }
    </script>
</head>

<body>
<div class="container">
    <div class="loginBox">
        <form class="form-horizontal" action="authLogin" method="post" onsubmit="return check()" style="background-color: #ffffffe0;border-radius: 20px;">
            <div class="loginLabel"><label style="text-align: center;font-size: 40px;padding-top:40px;font-weight: 700;color:#000000;text-shadow: 2px 3px #FFFFFF;">职工信息系统</label></div>
            <br>
            <a href="#" style="font-size: 24px;color: #269abc;text-decoration: none;padding-left: 140px;">登录</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="register.jsp" style="font-size: 24px;color:black ;text-decoration: none;">注册</a>
            <br>
            <br>
            <div class="form-group" style="margin-top: 20px;">
                <label for="username" class="col-sm-3 control-label">账号</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="username" name="username" placeholder="请输入您的账号" >
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-3 control-label">密码</label>
                <div class="col-sm-7">
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入您的密码" >
                </div>
            </div>



            <div id="main_form">
                <div id="input_content">
                    <input autocomplete="off" autofocus id="verify_input" placeholder="请输入验证码" maxlength="4">
                </div>
                <div id="verify_image">
                    <img id="imgVerify" src="login/getVerify" alt="更换验证码" height="36" width="170" onclick="getVerify(this);">
                </div>

                <div id="submit_btn">
                    <input type="button" onclick="aVerify()" value="判断是否正确">
                </div>
            </div>

			
            <div class="loginBtn">
                <button type="submit" class=" btn btn-pill btn-line btn-default loginBtn">登录</button>
            </div>
            <br>
            <br>
        </form>
    </div>
</div>
</body>

//验证码
<script type="text/javascript" src="./js/jquery.min.js"></script>

<script>


    function getVerify() {
        $("#verify_input").val("");
        $("#imgVerify").attr("src", 'login/getVerify?' + Math.random());//jquery方式
    }

    function aVerify() {
        let value = $("#verify_input").val();

        if (value.length < 4) {
            alert("验证码不足4位 , 请重新输入！！");
            return 0;
        }


        $.ajax({
            async: false,
            type: 'post',
            url: 'login/checkVerify',
            dataType: "json",
            data: {
                verifyInput: value
            },
            success: function (result) {

                if (result) {

                    if (getVerify()) {

                    } else {
                        window.location.href = "http://localhost:8089/login.jsp";
                    }

                } else {
                    alert("验证失败 , 点击确定重新验证");
                    getVerify();
                }
                // window.location.reload();
            }
        });
    }


</script>

<script type="text/javascript">
    //提交之前进行检查，如果return false，则不允许提交
    function check() {
        //根据ID获取值
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;
        if (username == "") {
            alert("用户名不能为空!");
            return false;
        }
        if (password == "") {
            alert("密码不能为空!");
            return false;
        }
        return true;
    }
</script>
</html>
