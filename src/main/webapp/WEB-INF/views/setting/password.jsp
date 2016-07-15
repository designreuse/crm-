<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM密码管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
</head>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp" %>
    <!-- Left side column. contains the logo and sidebar -->
    <%@include file="../include/leftSide.jsp" %>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                KingIT
                <small>CRM管理系统</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="col-sm-6 pull-right">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">密码修改</h3>
                    </div>
                    <!-- /.box-header -->
                    <!-- form start -->
                    <form  id="pswForm">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="oldPassword">旧密码</label>
                                <input type="password" class="form-control" id="oldPassword" name="oldPassword"
                                       placeholder="old Password">
                            </div>
                            <div class="form-group">
                                <label for="newPassword">新密码</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword"
                                       placeholder="new Password">
                            </div>
                            <div class="form-group">
                                <label for="renewPassword">确认密码</label>
                                <input type="password" class="form-control" id="renewPassword" name="renewPassword"
                                       placeholder="new Password">
                            </div>
                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <button type="button" id="editBtn" class="btn btn-primary pull-right">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </div>
</div>

<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="/static/plugins/validation/jquery.validate.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script>
    $(function () {
        $("#pswForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                oldPassword: {
                    required: true,
                    remote: "/user/validation/password"
                },
                newPassword: {
                    required: true,
                    rangelength: [3, 18]
                },
                renewPassword: {
                    required: true,
                    equalTo: "#newPassword"
                }
            },
            messages: {
                oldPassword: {
                    required: "这是必填字段",
                    remote: "旧密码错误"
                },
                newPassword: {
                    required: "这是必填字段",
                    rangelength: "密码长度在3 到18之间"
                },
                renewPassword: {
                    required: "这是必填字段",
                    equalTo: "两次密码输入不一致"
                }
            },
            /**
             * submitHandler:
             *通过验证后运行的函数,里面要加上表单提交的函数,否则表单不会提交 $(".selector").validate({
             * submitHandler:function(form) {
             *      $(form).ajaxSubmit();
             *      }
              *})
             * @param form
             */
            submitHandler: function (form) {
                var password = $("#newPassword").val();
                $.post("/user/password", {"password": password}).done(function (data) {
                    if (data == "success") {
                        alert("密码修改成功,点击确定重新登录.");
                        window.location.href = "/";
                    }
                }).fail(function () {
                    alert("服务器异常,请稍候再试.")
                })
            }

        })
        $("#editBtn").click(function () {
            $("#pswForm").submit();
        })
    })
</script>
</body>
</html>

