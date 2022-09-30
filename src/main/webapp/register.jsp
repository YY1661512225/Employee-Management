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
        <img class="col-sm-offset-4 col-sm-4" alt="" src="${APP_PATH}/static/img/logo.gif" >
        <div class="col-sm-offset-4 col-sm-4 text-center"><h1>职工注册</h1></div>
    </div>
    <div id="empAddModel">
        <br>
        <br>
        <form class="form-horizontal">
            <div class="form-group">
                <label for="empName_add_input" class="col-sm-offset-4 col-sm-1 control-label">职工</label>
                <div class="col-sm-3">
                    <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                    <span class="help-block"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="password_add_input" class="col-sm-offset-4 col-sm-1 control-label">密码</label>
                <div class="col-sm-3">
                    <input type="password" name="password" class="form-control" id="password_add_input" placeholder="password">
                    <span class="help-block"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="email_add_input" class="col-sm-offset-4 col-sm-1 control-label">邮箱</label>
                <div class="col-sm-3">
                    <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
                    <span class="help-block"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-offset-4 col-sm-1 control-label">性别</label>
                <div class="col-sm-3">
                    <label class="radio-inline">
                        <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-offset-4 col-sm-1 control-label">部门名称</label>
                <div class="col-sm-3">
                    <!--部门提交Did即可-->
                    <select class="form-control" name="dId" id="dept_add_select">

                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-2 text-center">
                    <button type="submit" class="btn btn-success" id="emp_register_btn">注册</button>
                </div>
                <div class="col-sm-2 text-center">
                    <button type="reset" class="btn btn-primary" id="">重置</button>
                </div>
            </div>
        </form>
    </div>

    <script type="text/javascript">

        // 注册
        $("#emp_register_btn").click(function () {
            // 先对要提交给服务器的数据进行校验
            // if (!validate_add_form()){
            //     return false;
            // }
            // 判断之前的Ajax用户名校验是否成功，如果成功，
            // if (this.attr("ajax-nav")=="error"){
            //     return false;
            // }
            // 将模态框中填写的表单数据提交给服务器，保存
            if (validate_add_form("#empName_add_input", "#email_add_input") & $("#emp_register_btn").attr("ajax-nav")=="success"){
                saveEmp("#empAddModel", "#empName_add_input", "#email_add_input", "POST");
            }
        });
        // 发送ajax请求保存职工
        // serialize form表单序列化
        function saveEmp(ele_model, ele_empName, ele_email, typee) {
            var Method = ""
            if (typee=="POST"){
                Method = Method + "&_method=POST"
            }
            // alert($(ele_model+" form").serialize());
            $.ajax({
                url:"${APP_PATH}/emps",
                data:$(ele_model+" form").serialize(),
                type:typee,
                success:function (result) {
                    // alert(result);
                    if (result.code==100){
                        console.log(result);
                        alert(result.msg);
                        // 关闭模态框
                        // 返回本页面
                        location.href="${APP_PATH}/emp_manager.jsp";

                    } else {
                        // 显示失败信息
                        alert(result.msg);
                        // 错误信息
                        if (undefined != result.extend.errorFields.email){
                            show_validate_msg(ele_email, "error", result.extend.errorFields.email);
                        }
                        if (undefined != result.extend.errorFields.empName){
                            show_validate_msg(ele_empName, "error", result.extend.errorFields.empName);
                        }
                    }

                }
            });
        }
        // 绑定单击事件
        $("#empName_add_input").change(function () {
            checkUser("#empName_add_input", "#emp_register_btn");
        });
        function checkUser(ele_empName, ele_save) {
            // 发送ajax请求 校验用户名是否可用
            var empName = $(ele_empName).val();
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"empName="+empName,
                type:"GET",
                success:function (result) {
                    if (result.code==100){
                        show_validate_msg(ele_empName, "success", "用户名可用！");
                        $(ele_save).attr("ajax-nav", "success");
                    }else {
                        show_validate_msg(ele_empName, "error", result.extend.va_msg);
                        $(ele_save).attr("ajax-nav", "error");
                    }
                }
            });
        }
        function show_validate_msg(ele, static, msg) {
            // 清除当前元素的校验状态
            $(ele).parent().removeClass("form-group has-success", "form-group has-error");
            $(ele).next("span").text("");
            if ("success" == static){
                $(ele).parent().addClass("form-group has-success");
                $(ele).next("span").text(msg);
            }else if ("error" == static){
                $(ele).parent().addClass("form-group has-error");
                $(ele).next("span").text(msg);
            }
        }

        // 校验表单数据
        function validate_add_form(ele_empName, ele_email) {
            // 1.拿到需要校验的数据，使用正则表达式校验
            var empName = $(ele_empName).val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{3,5}$)/;
            if (!regName.test(empName)){
                // alert("用户名可以是3-5位中文或者3-16位英文和数字的组合！");
                show_validate_msg(ele_empName, "error", "用户名可以是3-5位中文或者6-16位英文和数字的组合！");
                return false;
            } else {
                show_validate_msg(ele_empName, "success", "");
            }
            // 校验邮箱信息
            var email = $(ele_email).val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                // alert("邮箱格式不正确！");
                show_validate_msg(ele_email, "error", "邮箱格式不正确");
                return false;
            } else {
                show_validate_msg(ele_email, "success", "");
            }
            if (regEmail.test(email) & regName.test(empName)){
                return true;
            }
        }

        getDepts("#dept_add_select");

        // 查询部门信息，显示在下拉列表中
        function getDepts(el) {
            // 清空下拉列表
            $.ajax({
                url:"${APP_PATH}/dept",
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    ul = $(el)
                    ul.empty();
                    // 1.显示在下拉列表中
                    var depts = result.extend.depts;
                    $.each(depts, function (index, items) {
                        ul.append($("<option></option>").append(items.deptName).attr("value", items.deptId));
                    });

                }
            });
        }

        function reset_form(ele) {
            $(ele)[0].reset();
            $(ele).find("*").removeClass("form-group has-success", "form-group has-error");
            $(ele).find(".help-block").text();
        }

    </script>
</div>

</body>
</html>
