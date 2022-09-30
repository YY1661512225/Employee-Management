<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/7/7
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>安徽大学职工管理系统</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--搭建页面-->
<div class="container" id="loginModel">
    <!--标题-->
    <div class="row">
        <br>
        <br>
        <br>
        <br>
        <img class="col-sm-offset-4 col-sm-4" alt="" src="${APP_PATH}/static/img/logo.gif" >
        <div class="col-sm-offset-4 col-sm-4 text-center"><h1>职工管理系统</h1></div>
    </div>
    <div>
        <br>
        <br>
        <form class="form-horizontal">
            <div class="form-group">
                <label for="inputEmpName3" class="col-sm-offset-4 col-sm-1 control-label">职工</label>
                <div class="col-sm-3">
                    <input type="empName" class="form-control" id="inputEmpName3" placeholder="empName">
                </div>
            </div>
            <div class="form-group">
                <label for="inputPassword3" class="col-sm-offset-4 col-sm-1 control-label">密码</label>
                <div class="col-sm-3">
                    <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-2 text-center">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"> 记住我!
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-2 text-center">
                    <button type="submit" class="btn btn-success" id="emp_login_btn">登录</button>
                </div>
                <div class="col-sm-2 text-center">
                    <button type="button" class="btn btn-primary" onclick="jump()">注册</button>
                </div>
            </div>
        </form>
    </div>

    <script type="text/javascript">
        // 注册
        function jump() {
            window.location.href="${APP_PATH}/register.jsp";
        }

        // 登录
        $("#emp_login_btn").click(function () {
            var empName = $("#inputEmpName3").val();
            var password = $("#inputPassword3").val();
            $.ajax({
                url:"${APP_PATH}/checkUserToLogin",
                data:"empName="+empName+"&password="+password,
                type:"GET",
                success:function (result) {
                    if (result.code==100){
                        console.log("登录成功！");
                        location.href="${APP_PATH}/emp_manager.jsp";
                    }else {
                        console.log("登录失败，请您重新登录！");
                        reset_form("#loginModel form");
                    }
                }
            });
        });
        function reset_form(ele) {
            $(ele)[0].reset();
            $(ele).find("*").removeClass("form-group has-success", "form-group has-error");
            $(ele).find(".help-block").text();
        }

    </script>
</div>

</body>
</html>
