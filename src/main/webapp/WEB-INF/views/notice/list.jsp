<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM|公告管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/plugins/datatable/css/dataTables.bootstrap.min.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
</head>

<body class="hold-transition skin-green sidebar-mini">
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
            <h1>
                公告列表
            </h1>
            <ol class="breadcrumb">
                <li><a href="/home"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active"><i class="fa fa-bell"></i> 公告列表</li>
            </ol>
            <c:if test="${message=='success'}">
                <div class="alert alert-success">
                    <button class="close" data-dismiss="alert">
                        &times;
                    </button>
                    <strong>发表公告成功</strong>
                </div>
            </c:if>
            <div class="box box-primary">
                <div class="box-body">

                    <shiro:hasRole name="经理">
                        <div class="box-tools pull-right">
                            <a href="/notice/new" class="btn btn-success"><i class="fa fa-pencil"></i> 新建公告</a>
                        </div>
                    </shiro:hasRole>
                    <table id="showNoticeTable" class="table table-bordered table-striped dataTable" role="grid"
                           aria-describedby="example1_info">
                        <thead>
                        <tr role="row">
                            <th>标题</th>
                            <th>作者</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>

                    </table>

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
<script src="/static/plugins/datatable/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatable/js/dataTables.bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script>
    $(function () {
        var dataTable = $("#showNoticeTable").DataTable({
            "searching": false,
            "lengthMenu": [10, 20], //定义每页显示的数量列表
            "order": [0, "desc"],//指定默认排序方式
            "serverSide": true, //表示所有的操作都在服务端进行
            "ajax": "/notice/list.json",
            "columns": [ //配置返回的JSON中[data]属性中数据key和表格列的对应关系
                {
                    "data": function (row) {
                        return "<a href='/notice/topic/"+row.id+"'>" + row.title + "</a>";
                    }
                },
                {"data": "realname"},
                {"data": "creattime"},
            ],
            "language": { //定义中文
                "zeroRecords": "没有匹配的数据",
                "lengthMenu": "显示 _MENU_ 条数据",
                "info": "显示从 _START_ 到 _END_ 条数据 共 _TOTAL_ 条数据",
                "infoFiltered": "(从 _MAX_ 条数据中过滤得来)",
                "loadingRecords": "加载中...",
                "processing": "处理中...",
                "paginate": {
                    "first": "首页",
                    "last": "末页",
                    "next": "下一页",
                    "previous": "上一页"
                },
                "infoEmpty": "没有获取到数据"
            }
        })
    })
</script>
</body>
</html>

