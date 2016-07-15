<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM客户管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/plugins/datatable/css/dataTables.bootstrap.min.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
</head>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp" %>
    <!-- Left side column. contains the logo and sidebar -->
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="customer"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>&nbsp;&nbsp;</h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box box-primary">
                <div class="box-header">
                    <span><strong class="text-center">客户管理</strong></span>
                    <button class="btn btn-success btn-sm pull-right" id="newBtn">新增客户</button>
                </div>
                <div class="box-body">
                    <table class="table" id="customerTable">
                        <thead>
                        <tr>
                            <th style="width: 20px"></th>
                            <th>客户名称</th>
                            <th>联系电话</th>
                            <th>电子邮箱</th>
                            <th>等级</th>
                            <th style="width: 80px">#</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                        <tfoot></tfoot>
                    </table>
                </div>
                <div class="box-footer"></div>
            </div>
        </section>
    </div>

</div>
<!-- Modal -->
<div class="modal fade" id="newCustomerModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加新客户</h4>
            </div>
            <div class="modal-body">
                <form id="saveForm">
                    <div class="form-group">
                        <label>类型</label>
                        <div>
                            <label class="radio-inline">
                                <input id="radioPerson" type="radio" name="type" value="person" checked>个人
                            </label>
                            <label class="radio-inline">
                                <input id="radioCompany" type="radio" name="type" value="company">公司
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>客户名称</label>
                        <input type="text" name="name" id="savename" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>电话</label>
                        <input type="text" name="tel" id="saveTel" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>邮箱</label>
                        <input type="text" name="email" id="saveEmail" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>微信</label>
                        <input type="text" name="weixin" id="saveWeixin" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>地址</label>
                        <input type="text" name="address" id="saveAddress" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>客户级别</label>
                        <select class="form-control" id="saveLevel" name="level">
                            <option value=""></option>
                            <option value="★">★</option>
                            <option value="★★">★★</option>
                            <option value="★★★">★★★</option>
                            <option value="★★★★">★★★★</option>
                            <option value="★★★★★">★★★★★</option>
                        </select>
                    </div>
                    <div class="form-group" id="companyList">
                        <label>所属公司</label>
                        <select name="companyid" id="saveCompanyid" class="form-control">
                            <option value=""></option>
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

<!-- 编辑Modal -->
<div class="modal fade" id="editCustomerModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑客户</h4>
            </div>
            <div class="modal-body">
                <form id="editForm">
                    <input type="hidden" name="id" id="editId">
                    <input type="hidden" name="userid" id="editUserid">
                    <input type="hidden" name="type" id="editType">
                    <div class="form-group">
                        <label>客户名称</label>
                        <input type="text" name="name" id="editName" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>电话</label>
                        <input type="text" name="tel" id="editTel" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>邮箱</label>
                        <input type="text" name="email" id="editEmail" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>微信</label>
                        <input type="text" name="weixin" id="editWeixin" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>地址</label>
                        <input type="text" name="address" id="editAddress" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>客户级别</label>
                        <select class="form-control" id="editLevel" name="level">
                            <option value=""></option>
                            <option value="★">★</option>
                            <option value="★★">★★</option>
                            <option value="★★★">★★★</option>
                            <option value="★★★★">★★★★</option>
                            <option value="★★★★★">★★★★★</option>
                        </select>
                    </div>
                    <div class="form-group" id="editCompanyList">
                        <label>所属公司</label>
                        <select name="companyid" id="editCompanyid" class="form-control">
                            <option value=""></option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="editBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/datatable/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatable/js/dataTables.bootstrap.js"></script>
<script src="/static/plugins/validation/jquery.validate.min.js"></script>
<script>
    $(function () {
        var dataTable = $("#customerTable").DataTable({
            "lengthMenu": [10, 20, 25, 50], //定义每页显示的数量列表
            "ordering": false,//指定默认排序方式
            "serverSide": true, //表示所有的操作都在服务端进行
            "ajax": "/customer/show.json",
            "columns": [ //配置返回的JSON中[data]属性中数据key和表格列的对应关系
                {
                    "data": function (row) {
                        if (row.type == "company") {
                            return "<i class='fa fa-bank'></i>";
                        } else {
                            return "<i class='fa fa-user' ></i>";
                        }
                    }
                },
                {
                    "data": function (row) {
                        if (row.companyname) {
                            return "<a href='/customer/view/"+row.id+"'>"+row.name+"</a>"+"->"+"<a href='/customer/view/"+row.companyid+"'>"+row.companyname+"</a>"
                        }
                        return "<a href='/customer/view/"+row.id+"'>"+row.name+"</a>";
                    }
                },
                {"data": "tel"},
                {"data": "email"},
                {
                    "data": function (row) {
                        return "<span style='color: #00a65a'>" + row.level + "</span>"
                    }
                },
                {
                    "data": function (row) {
                        return "<button class='btn btn-info editLink' rel='" + row.id + "'>编辑</button>" <shiro:hasRole name="经理"> + "<button class='btn btn-danger delLink' style='margin-left:10px' rel='" + row.id + "'>删除</button>"
                        </shiro:hasRole>
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
        $("#newBtn").click(function () {
            $("#saveForm")[0].reset();
            $("#newCustomerModal").modal({});
            $.get("/customer/getcompanylist").done(function (data) {
                if (data && data.length) {
                    var $select = $("#saveCompanyid");
                    $select.html("");
                    $select.append("<option value=''></option>");
                    for (var i = 0; i < data.length; i++) {
                        var company = data[i];
                        var option = "<option value='" + company.id + "'>" + company.name + "</option>";
                        $select.append(option);
                    }
                }
            });
        })
        $("#radioCompany").click(function () {
            $("#companyList").hide();
        })
        $("#radioPerson").click(function () {
            $("#companyList").toggle();
        })

        $("#saveForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                name: {
                    required: true,
                },
                tel: {
                    required: true,
                },
            },
            messages: {
                name: {
                    required: "请输入客户名称",
                },
                tel: {
                    required: "请输入电话",

                }
            },
            submitHandler: function (form) {
                $.post("/customer/list", $(form).serialize()).done(function (data) {
                    if (data == "success") {
                        $("#newCustomerModal").modal('hide');
                        dataTable.ajax.reload();

                    }
                }).fail(function () {
                    alert("服务器异常,请稍候再试");
                })
            }
        })
        $("#saveBtn").click(function () {
            $("#saveForm").submit();
        })

        $(document).delegate(".delLink", "click", function () {
            var id = $(this).attr("rel");
            if (confirm("是否确认删除?" + id)) {
                $.get("/customer/del/" + id).done(function (result) {
                    if (result == "success") {
                        dataTable.ajax.reload();
                        alert("删除成功");
                    }
                }).fail(function () {
                    alert("删除失败,请稍候重试.");
                })
            }
        })
        $(document).delegate(".editLink", "click", function () {
            var id = $(this).attr("rel");
            $.get("/customer/edit/" + id).done(function (data) {
                $("#editId").val(id);
                $("#editAddress").val(data.customer.address);
                $("#editEmail").val(data.customer.email);
                $("#editType").val(data.customer.type);
                $("#editUserid").val(data.customer.userid);
                $("#editWeixin").val(data.customer.weixin);
                $("#editLevel").val(data.customer.level);
                $("#editTel").val(data.customer.tel);
                $("#editName").val(data.customer.name);
                if (data.companys && data.companys.length) {
                    var $select = $("#editCompanyid");
                    $select.html("");
                    $select.append("<option value=''></option>");
                    for (var i = 0; i < data.companys.length; i++) {
                        var company = data.companys[i];
                        var option = "<option value='" + company.id + "'>" + company.name + "</option>";
                        $select.append(option);
                    }
                }
                if (data.customer.type=='company'){
                    $("#editCompanyList").hide();

                }else {
                    $("#editCompanyList").show();
                }
                $("#editCompanyid").val(data.customer.companyid);
                $("#editCustomerModal").modal();
            }).fail(function () {
                alert("服务器出错,找不到该用户信息");
            })
        })

        $("#editBtn").click(function () {
            $("#editForm").submit();
        })

        $("#editForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                name: {
                    required: true,
                },
                tel: {
                    required: true,
                },
            },
            messages: {
                name: {
                    required: "请输入客户名称",
                },
                tel: {
                    required: "请输入电话",

                }
            },
            submitHandler: function (form) {
                $.post("/customer/edit", $(form).serialize()).done(function (data) {
                    if (data == "success") {
                        $("#editCustomerModal").modal('hide');
                        window.location.href = "/customer/list";
                    }
                }).fail(function () {
                    alert("服务器异常,请稍候再试");
                })
            }
        })
    })
</script>
</body>
</html>

