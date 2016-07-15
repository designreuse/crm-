<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM日志</title>
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
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">CRM登录日志</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">

                    <div class="row">
                        <div class="col-sm-12">
                            <table id="datatable" class="table table-bordered table-striped dataTable" role="grid"
                                   aria-describedby="example1_info">
                                <thead>

                                <tr role="row">
                                    <th>登录时间</th>
                                    <th>登录ip</th>
                                </tr>
                                </thead>

                                <tbody>
                                </tbody>

                            </table>
                        </div>
                    </div>

                </div>
                <!-- /.box-body -->
            </div>
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
        var datatable = $("#datatable").DataTable({
            "searching": false,
            "lengthMenu": [5, 10, 20, 25, 50], //定义每页显示的数量列表
            "order": [0, "desc"],//指定默认排序方式
            "serverSide": true, //表示所有的操作都在服务端进行
            "ajax": "/user/log/load",
//            {
//                url: "/user/log/load", //服务端URL地址
//                data: function (dataSource) {
//                    dataSource.bookname = $("#search_bookname").val();
//                    dataSource.typeid = $("#search_type").val();
//                    dataSource.pubid = $("#search_pub").val();
//                }
//
//            },
            "columns": [ //配置返回的JSON中[data]属性中数据key和表格列的对应关系
                {"data": "logintime", "name": "logintime"},
                {"data": "loginip"}
            ],
//            "columnDefs": [ //定义列的特征
//                {targets: [0], visible: false},//不可见列
//                {targets: [1, 2, 5, 7], orderable: false}//排序规则列
//            ],
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
                }
            }
        })
    })
</script>
</body>
</html>

