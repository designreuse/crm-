<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM|销售机会</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
    <link rel="stylesheet" href="/static/plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="/static/plugins/datatable/css/dataTables.bootstrap.min.css">
</head>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp" %>
    <!-- Left side column. contains the logo and sidebar -->
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="sale"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>&nbsp;&nbsp;</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/home"><i class="fa fa-home"></i> 主页</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="box box-primary">

                <div class="box box-primary">
                    <div class="box box-header">
                        <h3 class="box-title">搜索</h3>
                        <div class="box-tools">
                            <button class="btn btn-box-tool btn-xs" data-widget="collapse" data-toggle="tooltip"><i
                                    class="fa fa-plus"></i></button>
                        </div>
                    </div>
                    <div class="box-body">
                        <form id="searchForm" class="form-inline">
                            <input type="hidden" id="search_start_time">
                            <input type="hidden" id="search_end_time">
                            <input type="text" value="" id="search_name" class="form-control" placeholder="机会名称">
                            <select id="search_progress" class="form-control">
                                <option value="">当前进度</option>
                                <option value="初次接触">初次接触</option>
                                <option value="确认意向">确认意向</option>
                                <option value="提供合同">提供合同</option>
                                <option value="完成交易">完成交易</option>
                                <option value="交易搁置">交易搁置</option>
                            </select>
                            <input type="text" id="rangepicker" class="form-control"
                                   placeholder="跟进时间">
                            <button class="btn btn-success" id="searchBtn"><i class="fa fa-search"></i>搜索</button>
                        </form>
                    </div>
                </div>

                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">机会列表</h3>
                        <div class="box-tools">
                            <button class="btn btn-success btn-xs" id="newChange">新增机会</button>
                        </div>
                    </div>
                    <div class="box-body">
                        <table class="table" id="saleTable">
                            <thead>
                            <tr>
                                <th>机会名称</th>
                                <th>关联客户</th>
                                <th>价值</th>
                                <th>当前进度</th>
                                <th>最后跟进时间</th>
                                <th>所属员工</th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                    <div class="box-footer"></div>
                </div>
            </div>

        </section>
    </div>

</div>

<!-- Modal -->
<div class="modal fade" id="newSaleModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加新机会</h4>
            </div>
            <div class="modal-body">
                <form id="saveForm" method="post">
                    <input type="hidden" id="startDate">
                    <input type="hidden" id="endDate">
                    <div class="form-group">
                        <label>机会名称</label>
                        <div>
                            <input type="text" name="name" id="savename" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>关联客户</label>
                        <select id="saveCustid" name="custid" class="form-control">
                            <c:forEach items="${customerList}" var="cust">
                                <option value="${cust.id}">${cust.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>价值</label>
                        <input type="text" name="price" id="savePrice" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>当前进度</label>
                        <select class="form-control" name="progress" id="saveProgress">
                            <option value="初次接触">初次接触</option>
                            <option value="确认意向">确认意向</option>
                            <option value="提供合同">提供合同</option>
                            <option value="完成交易">完成交易</option>
                            <option value="交易搁置">交易搁置</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>

<script src="/static/plugins/datatable/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatable/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/validation/jquery.validate.min.js"></script>
<script src="/static/plugins/daterangepicker/moment.min.js"></script>
<script src="/static/plugins/daterangepicker/daterangepicker.js"></script>
<script>
    $(function () {
        $("#rangepicker").daterangepicker({
            format: "YYYY-MM-DD",
            separator: "~",
            locale: {
                "applyLabel": "选择",
                "cancelLabel": "取消",
                "fromLabel": "从",
                "toLabel": "到",
                "customRangeLabel": "自定义",
                "weekLabel": "周",
                "daysOfWeek": [
                    "一",
                    "二",
                    "三",
                    "四",
                    "五",
                    "六",
                    "日"
                ],
                "monthNames": [
                    "一月",
                    "二月",
                    "三月",
                    "四月",
                    "五月",
                    "六月",
                    "七月",
                    "八月",
                    "九月",
                    "十月",
                    "十一月",
                    "十二月"
                ],
                "firstDay": 1
            },
            ranges: {
                '今天': [moment(), moment()],
                '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                '最近7天': [moment().subtract(6, 'days'), moment()],
                '最近30天': [moment().subtract(29, 'days'), moment()],
                '本月': [moment().startOf('month'), moment().endOf('month')],
                '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        });
        var dataTable = $("#saleTable").DataTable({
            "searching": false,
            "lengthMenu": [10, 20], //定义每页显示的数量列表
            "serverSide": true, //表示所有的操作都在服务端进行
            "ajax": {
                "url": "/sale/load",
                "data": function (dataSouce) {
                    dataSouce.changename = $("#search_name").val();
                    dataSouce.progress = $("#search_progress").val();
                    dataSouce.startDate = $("#search_start_time").val();
                    dataSouce.endDate = $("#search_end_time").val();
                }
            },
            "searching": false,
            "ordering": false,
            "autoWidth": false,
            "columns": [ //配置返回的JSON中[data]属性中数据key和表格列的对应关系
                {
                    "data": function (row) {
                        if(row.userid==${userid}){
                            return "<a class='text-info' href='/sale/view/" + row.id + "'>" + row.name + "</a>"
                        }
                        return "<a class='text-black' href='/sale/view/" + row.id + "'>" + row.name + "</a>"
                    }
                },
                {
                    "data": function (row) {
                        if(row.userid==${userid}){
                            return "<a class='text-info' href='/customer/view/" + row.custid + "'>" + row.custname + "</a>"

                        }
                        return "<a class='text-black' href='/customer/view/" + row.custid + "'>" + row.custname + "</a>"
                    }
                },
                {
                    "data": function (row) {
                        return "$" + row.price;
                    }
                },
                {
                    "data": function (row) {
                        if (row.progress == "初次接触") {
                            return "<button style='width: 80px' class='btn btn-info'>" + "初次接触" + "</button>";
                        } else if (row.progress == "完成交易") {
                            return "<button style='width: 80px' class='btn btn-success'>" + "完成交易" + "</button>";

                        } else if (row.progress == "交易搁置") {
                            return "<button style='width: 80px' class='btn btn-danger'>" + "交易搁置" + "</button>";

                        } else {
                            return "<button style='width: 80px' class='btn btn-primary'>" + row.progress + "</button>";
                        }
                    }
                },
                {"data": "lasttime"},
                {
                    "data": function (row) {
                        return row.username;
                    }
                }
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

        $("#newChange").click(function () {
            $("#saveForm")[0].reset();
            $("#newSaleModal").modal({
                "show": true,
                "backdrop": "static",
                "keyboard": false
            })
        })

        $("#saveBtn").click(function () {
            $("#saveForm").submit();
        })

        $("#saveForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                name: {
                    required: true,
                },
                price: {
                    number: true,
                    required: true,
                }
            },
            messages: {
                name: {
                    required: "请输入机会名称",
                },
                price: {
                    required: "请输入价格",
                    number: "请输入正数"
                }
            },
            submitHandler: function (form) {
                $.post("/sale/new", $(form).serialize()).done(function (data) {
                    if (data == "success") {
                        $("#newSaleModal").modal('hide');
                        dataTable.ajax.reload();
                    }
                }).fail(function () {
                    alert("服务器异常,请稍候再试");
                })
            }
        })

        $("#searchBtn").click(function () {
            dataTable.ajax.reload();
        })

        $('#rangepicker').on('apply.daterangepicker', function (ev, picker) {
            $("#search_start_time").val(picker.startDate.format('YYYY-MM-DD'));
            $("#search_end_time").val(picker.endDate.format('YYYY-MM-DD'));
        });

    })

</script>

</body>
</html>

