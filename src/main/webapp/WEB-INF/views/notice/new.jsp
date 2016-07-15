<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM|新建公告</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
    <link rel="stylesheet" href="/static/plugins/simditor-2.3.6/styles/simditor.css">
</head>

<body class="hold-transition skin-green sidebar-mini" >
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp" %>
    <!-- Left side column. contains the logo and sidebar -->
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="notice"/>
    </jsp:include>
    <%--<%@include file="../include/leftSide.jsp" %>--%>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1 class="text-center">&nbsp;&nbsp;</h1>
            <ol class="breadcrumb">
                <li><a href="/home"><i class="fa fa-home"></i>主页</a></li>
                <li><a href="/notice/list"><i class="fa fa-bell"></i>公告列表</a></li>
                <li class="active"><i class="fa fa-pencil"></i> 新增公告</li>
            </ol>
            <div class="box box-primary">
                <div class="box-header">
                    <h4>新增公告</h4>
                </div>
                <div class="box-body">
                    <form method="post" id="newNoticeForm">
                        <div class="form-group">
                            <label for="title">公告标题</label>
                            <input name="title" autofocus class="form-control" id="title">
                        </div>
                        <div class="form-group">
                            <label for="content">公告内容</label>
                            <textarea name="content" id="content" class="form-control" rows="8"></textarea>
                        </div>
                    </form>

                    <div class="box-footer">
                        <button type="submit" class="btn btn-success btn-lg pull-right" id="saveBtn">
                            提交
                        </button>
                    </div>

                </div>
            </div>
        </section>

        <!-- Main content -->
        <section class="content">

        </section>
    </div>

</div>

<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/simditor-2.3.6/scripts/module.js"></script>
<script src="/static/plugins/simditor-2.3.6/scripts/hotkeys.min.js"></script>
<script src="/static/plugins/simditor-2.3.6/scripts/uploader.js"></script>
<script src="/static/plugins/simditor-2.3.6/scripts/simditor.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script>
    $(function () {
        var editor = new Simditor({
            textarea: $("#content"),
            placeholder:"请输入公告内容",
            upload:{
                url : '/notice/img/upload', //文件上传的接口地址
//                params: null, //键值对,指定文件上传接口的额外参数,上传的时候随文件一起提交
                fileKey: 'file', //服务器端获取文件数据的参数名
//                connectionCount: 3,
//                leaveConfirm: '正在上传文件'
            }
        })

        /**
         * 确保文章标题和内容都不为空
         */
        $("#saveBtn").click(function () {
            if (!$("#title").val()) {
                $("#title").focus();
            } else if (!$("#content").val()) {
                $("#content").focus();
            } else {
                $("#newNoticeForm").submit();
            }
        })


    })
</script>
</body>
</html>

