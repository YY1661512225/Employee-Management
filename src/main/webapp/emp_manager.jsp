<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/5/9
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>职工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--web路径：不以/开始的相对路径，寻找资源，以当前资源的路径为基准，容易出问题
    以/开始的路径，寻找资源，以服务器的路径为标准，需要加入项目名，方能找到正确资源
    http:localhost:3306/crud/
    -->
    <!--引入bootstrap样式 js JQuery插件-->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--职工修改的模态框-->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">职工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post">
                    <div class="form-group">
                        <label for="empName_update_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control-static" id="empName_update_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control-static" id="email_update_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交Did即可-->
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 职工添加的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">职工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">职工</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-4">
                            <!--部门提交Did即可-->
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
            </div>
        </div>
    </div>
</div>

<!--搭建页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <img class="col-md-4" alt="" width="300px" src="${APP_PATH}/static/img/logo.gif" >
        <div class="col-md-8"><h1>职工管理系统</h1></div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            <button class="btn btn-success" id="emp_exit_all_btn">注销</button>

        </div>
    </div>
    <!--表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>编号</th>
                        <th>职工</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门名称</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info"></div>
        <!--分页条-->
        <div class="col-md-6" id="page_nav"></div>
    </div>
    <script type="text/javascript">

        var totalRecord;
        var pageRecord;
        // 1.页面加载完成之后，直接发送一个Ajax请求，要到分页数据
        $(function () {
            // 首页
            to_page(1);
        });

        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
                    console.log(result);
                    // 1.解析并显示职工数据
                    build_emps_table(result);
                    // 2.解析并显示分页信息
                    build_page_info(result);
                    // 3.解析显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        function build_emps_table(result) {
            // 清空table表格
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps, function (index, items) {
                var checkBoxTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
                var empIdTd = $("<td></td>").append(items.empId);
                var empNameTd = $("<td></td>").append(items.empName);
                var gender = items.gender=="M" ? "男":"女";
                var genderTd = $("<td></td>").append(gender);
                var emailTd = $("<td></td>").append(items.email);
                var deptNameTd = $("<td></td>").append(items.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<img/>").attr("src", "${APP_PATH}/static/assets/img/pen.svg").attr("alt", "Bootstrap" )).append("编辑");
                // 为编辑按钮添加自定义的属性，来表示当前职工的id
                editBtn.attr("edit_id", items.empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<img/>").attr("src", "${APP_PATH}/static/assets/img/trash.svg").attr("alt", "Bootstrap" )).append("删除");
                delBtn.attr("del_id", items.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                // append 执行完成之后，还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd).appendTo("#emps_table tbody");
            });
        }
        // 解析显示分页信息
        function build_page_info(result) {
            $("#page_info").empty();
            var page_info = result.extend.pageInfo;
            totalRecord = page_info.total;
            pageRecord = page_info.pageNum;
            $("<div></div>").addClass("col-md-6")
                .append("当前第").append(page_info.pageNum).append("页，总")
                .append(page_info.pages).append("页，总")
                .append(page_info.total).append("记录").appendTo("#page_info");
        }
        // 解析显示分页条数据
        function build_page_nav(result) {
            $("#page_nav").empty();
            var page_nav = result.extend.pageInfo;
            var ull = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>")
                .append("首页").attr("href", "#"));
            var prevPageLi = $("<li></li>").append($("<a></a>")
                .append("&laquo;").attr("href", "#"));
            if (page_nav.pageNum == 1) {
                firstPageLi.addClass("page-link disabled");
                prevPageLi.addClass("page-link disabled");
            } else {
                firstPageLi.click(function () {
                    to_page(1);
                });
                prevPageLi.click(function () {
                    to_page(page_nav.pageNum-1);
                });
            }
            var lastPageLi = $("<li></li>").append($("<a></a>")
                .append("末页").attr("href", "#"));
            var nextPageLi = $("<li></li>").append($("<a></a>")
                .append("&raquo;").attr("href", "#"));
            if (page_nav.pageNum == page_nav.pages) {
                lastPageLi.addClass("page-link disabled");
                nextPageLi.addClass("page-link disabled");
            } else {
                lastPageLi.click(function () {
                    to_page(page_nav.pages);
                });
                nextPageLi.click(function () {
                    to_page(page_nav.pageNum+1);
                });
            }
            ull.append(firstPageLi).append(prevPageLi)

            $.each(page_nav.navigatepageNums, function (index, items) {
                var numLi = $("<li></li>").append($("<a></a>")
                    .append(items).attr("href", "#"));
                if (page_nav.pageNum == items){
                    numLi.addClass("page-item active");
                }
                numLi.click(function () {
                    to_page(items);
                });
                ull.append(numLi);
            });
            ull.append(nextPageLi).append(lastPageLi);
            $("<nav></nav>").attr("aria-label", "Page navigation example").append(ull).appendTo("#page_nav");
        }
        // 清空表单数据 表单数据 表单样式
        function reset_form(ele) {
            $(ele)[0].reset();
            $(ele).find("*").removeClass("form-group has-success", "form-group has-error");
            $(ele).find(".help-block").text();
        }
        // 点击新增按钮，弹出模态框
        $("#emp_add_model_btn").click(function () {
            // 清空表单数据 表单数据 表单样式
            reset_form("#empAddModel form");
            // 发送ajax请求，查询部门信息，显示在下拉列表中
            getDepts("#dept_add_select");
            // 弹出模态框
            $("#empAddModel").modal({
                backdrop:"static"
            });
        });
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
        
        $("#emp_save").click(function () {
            // 先对要提交给服务器的数据进行校验
            // if (!validate_add_form()){
            //     return false;
            // }
            // 判断之前的Ajax用户名校验是否成功，如果成功，
            // if (this.attr("ajax-nav")=="error"){
            //     return false;
            // }
            // 将模态框中填写的表单数据提交给服务器，保存
            if (validate_add_form("#empName_add_input", "#email_add_input") & $("#emp_save").attr("ajax-nav")=="success"){
                saveEmp("#empAddModel", "#empName_add_input", "#email_add_input", "POST", "", totalRecord);
            }
        });

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
        // 发送ajax请求保存职工
        // serialize form表单序列化
        function saveEmp(ele_model, ele_empName, ele_email, typee, Tid, page_num) {
            var empId = "/"
            var Method = ""
            if (Tid!=""){
                empId = empId + Tid;
            }
            if (typee=="POST"){
                Method = Method + "&_method=POST"
            }
            // alert($(ele_model+" form").serialize());
            $.ajax({
                url:"${APP_PATH}/emps"+empId,
                data:$(ele_model+" form").serialize(),
                type:typee,
                success:function (result) {
                    // alert(result);
                    if (result.code==100){
                        console.log(result);
                        alert(result.msg);
                        // 关闭模态框
                        $(ele_model).modal('hide');
                        // 返回本页面
                        to_page(page_num);
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
        $("#emp_exit_all_btn").click(function () {
            location.href="${APP_PATH}/index.jsp";
        });
        // 绑定单击事件
        $("#empName_add_input").change(function () {
            checkUser("#empName_add_input", "#emp_save");
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
        // 按钮创建之前绑定单击事件 绑定无效
        // 1.创建按钮绑定单击事件 2.绑定单击事件：live() on()
        $(document).on("click", ".edit_btn", function () {
            // alert("EDIT");
            // 查询职工信息 显示职工信息
            getEmp($(this).attr("edit_id"));
            // 把职工的id传递给模态框的更新按钮
            $("#emp_update").attr("edit_id", $(this).attr("edit_id"));
            // 查询部门信息 显示部门列表
            getDepts("#dept_update_select");
            // 弹出模态框
            $("#empUpdateModel").modal({
                backdrop:"static"
            });
        });
        // 点击更新，更新职工信息
        $("#emp_update").click(function () {
            // 先对要提交给服务器的数据进行校验
            // 判断之前的Ajax用户名校验是否成功，如果成功，
            // 将模态框中填写的表单数据提交给服务器，保存
            if (validate_add_form("#empName_update_input", "#email_update_input") & $("#emp_update").attr("ajax-nav")=="success"){
                // alert("更新!");
                saveEmp("#empUpdateModel", "#empName_update_input", "#email_update_input", "PUT", $(this).attr("edit_id"), pageRecord);
            }
        });
        // 绑定单击事件
        $("#empName_update_input").change(function () {
            checkUser("#empName_update_input", "#emp_update");
        });
        // 给删除按钮 绑定单击事件
        $(document).on("click", ".delete_btn", function () {
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            if (confirm("你确定要删除【"+ empName +"】吗？")){
                // 确认 发送ajax请求 删除
                $.ajax({
                    url:"${APP_PATH}/emps/"+$(this).attr("del_id"),
                    type:"DELETE",
                    success:function (result) {
                        to_page(pageRecord);
                        alert(result.msg);
                    }
                });
            }

        });
        
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emps/"+id,
                type:"GET",
                success:function (result) {
                    console.log(result);
                    var empData = result.extend.emp;
                    $("#empName_update_input").val(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModel input[name=gender]").val([empData.gender]);
                    $("#empUpdateModel select").val([empData.dId]);
                }
            });
        }

        // 将完成全选 全不选功能
        $("#check_all").click(function () {
            // attr 获取checked值undefined
            // DOM原生的属性，attr获取自定义属性的值，prop修改和读取dom原生的属性值
            // alert($(this).prop("checked"));
            $(".check_item").prop("checked", $(this).prop("checked"));
        });
        // ".check_item"
        $(document).on("click", ".check_item", function () {
            // 判断当前选中的元素个数是否5个？
            var flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked", flag);
        });
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var str_ids = "";
            $.each($(".check_item:checked"), function () {
                // 寻找第3个td 索引=2
                empNames = $(this).parents("tr").find("td:eq(2)").text() + "，" + empNames;
                str_ids = $(this).parents("tr").find("td:eq(1)").text() + "-" + str_ids;
            });
            // 去除emps多余的逗号
            empNames = empNames.substring(0, empNames.length-1);
            // 删除的id多余的单行线
            str_ids = str_ids.substring(0, str_ids.length-1);
            if (confirm("你确定要删除【"+ empNames +"】吗？")){
                // 确认 发送ajax请求 删除
                $.ajax({
                    url:"${APP_PATH}/emps/"+str_ids,
                    type:"DELETE",
                    success:function (result) {
                        to_page(pageRecord);
                        alert(result.msg);
                    }
                });
            }

        });
    </script>
</div>

</body>
</html>

