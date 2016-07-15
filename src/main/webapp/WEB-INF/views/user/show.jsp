<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM用户管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/plugins/datatable/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" href="/static/bootstrap/css/font-awesome.min.css">
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

        </section>

        <!-- Main content -->
        <section class="content">
            <%--<div class="box">--%>
            <%--<div class="box-header">--%>
            <%--<h3 class="box-title">CRM用户管理</h3>--%>
            <%--</div>--%>
            <div class="well pull-right form-control " style="float: right;height: 65px">
                <form class="form-inline">
                    <div class="form-group">
                        <input type="text" placeholder="用户姓名或用户名" value="${realname}" name="realname"
                               id="search_realname"
                               class="form-control">
                    </div>
                    <div class="form-group">
                        <select name="role" class="form-control" id="search_role">
                            <option value="">所有用户</option>
                            <c:forEach items="${roles}" var="role">
                                <option value="${role.id}" }>${role.rolename}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="button" id="searchBtn" class="btn btn-primary">搜索</button>

                    <a href="javascript:;" id="newUserBtn" class="btn btn-primary pull-right"
                       style="margin-bottom:20px;margin-left: 30px">添加新用户</a>
                </form>

            </div>
            <!-- /.box-header -->
            <div class="box-body">

                <div class="row">
                    <div class="col-sm-12">
                        <table id="showUserTable" class="table table-bordered table-striped dataTable" role="grid"
                               aria-describedby="example1_info">
                            <thead>

                            <tr role="row">
                                <th>ID</th>
                                <th>用户名</th>
                                <th>真实姓名</th>
                                <th>微信</th>
                                <th>创建时间</th>
                                <th>用户职位</th>
                                <th>用户状态</th>
                                <th>操作</th>
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

<!-- Modal -->
<div class="modal fade" id="newUserModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加新用户</h4>
            </div>
            <div class="modal-body">
                <form id="saveForm">
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" name="username" id="saveUsername" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>密码</label>
                        <input type="text" name="password" id="savePassword" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>用户姓名</label>
                        <input type="text" name="realname" id="saveRealname" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>微信</label>
                        <input type="text" name="weixin" id="saveWeixin" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>用户权限</label>
                        <select class="form-control" id="saveRoleid" name="roleid">
                            <c:forEach items="${roles}" var="role">
                                <option value="${role.id}" ${role.id==3?"selected":""}>${role.rolename}</option>
                            </c:forEach>
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

<!-- editModal -->
<div class="modal fade" id="editUserModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true"></span></button>
                <h4 class="modal-title" id="editTitle">修改用户信息</h4>
            </div>
            <div class="modal-body">
                <form id="editForm">
                    <input type="hidden" name="id" id="editId">
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" name="username" disabled id="editUsername" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>用户姓名</label>
                        <input type="text" name="realname" id="editRealname" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>微信</label>
                        <input type="text" name="weixin" id="editWeixin" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>用户权限</label>
                        <select class="form-control" id="editRoleid" name="roleid">
                            <c:forEach items="${roles}" var="role">
                                <option value="${role.id}">${role.rolename}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" id="editEnable" name="enable">
                            <option value="true">启用</option>
                            <option value="false">禁用</option>
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
<script src="/static/plugins/datatable/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatable/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/validation/jquery.validate.min.js"></script>

<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script>
    $(function () {
        var dataTable = $("#showUserTable").DataTable({
            "searching": false,
            "lengthMenu": [10, 20, 25, 50], //定义每页显示的数量列表
            "order": [0, "desc"],//指定默认排序方式
            "serverSide": true, //表示所有的操作都在服务端进行
            "ajax": {
                url: "/admin/show.json", //服务端URL地址,表格中值获取
                data: function (dataSource) {
                    dataSource.realname = $("#search_realname").val();
                    dataSource.role = $("#search_role").val();
                }

            },
            "columns": [ //配置返回的JSON中[data]属性中数据key和表格列的对应关系
                {"data": "id", "name": "id"},
                {"data": "username", "name": "username"},
                {"data": "realname", "name": "realname"},
                {"data": "weixin"},
                {"data": "createtime", "name": "createtime"},
                {"data": "role.rolename", "name": "roleid"},
                {
                    "data": function (row) {
                        if (row.enable) {
                            return "<button class='btn btn-default'>正常</button>"
                        } else {
                            return "<button class='btn btn-danger'>禁用</button>"
                        }
                    }
                },
                {
                    "data": function (row) {
                        if (row.roleid == 1) {
                            return '';
                        }
                        return "<a href='javascript:;'  class='editLink btn btn-success' rel='" + row.id + "'>编辑</a><a href='javascript:;' class='delLink btn btn-success' style='margin-left: 5px;margin-right: 5px' disabled rel='" + row.id + "'>删除</a><a href='javascript:;' class='resetLink btn btn-danger' rel='" + row.id + "'>重置密码</a>"
                    }
                },
            ],
            "columnDefs": [ //定义列的特征
                {targets: [], visible: false},//不可见列
                {targets: [3, 6,7], orderable: false}//不排序规则列
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
        $("#saveForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                username: {
                    required: true,
                    remote: "/admin/checkuser.json"
                },
                password: {
                    required: true,
                    rangelength: [3, 18]

                },
                realname: {
                    required: true
                }
            },
            messages: {
                username: {
                    required: "请输入用户名",
                    remote: "用户名已存在,请重新输入"
                },
                password: {
                    required: "请输入密码",
                    rangelength: "密码长度在3-18位之间"

                },
                realname: {
                    required: "请输入姓名"
                }
            },
            submitHandler: function (form) {
                $.post("/admin/show", $(form).serialize()).done(function (data) {
                    if (data == "success") {
                        $("#newUserModal").modal('hide');
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
        $("#newUserBtn").click(function () {
            $("#saveForm")[0].reset();
            $("#newUserModal").modal({
                show: true,
                backdrop: "static",
                keyboard: false
            })
        })
        $("#saveBtn").click(function () {
            $("#saveForm").submit();
        })
        //解决删除功能,会造成安全隐患
//        $(document).delegate(".delLink","click",function(){
//            var id = $(this).attr("rel");
//            if(confirm("是否确认删除")){
//                $.get("/user/"+id+"/del").done(function(data){
//                    if(data=="success"){
//                        dataTable.ajax.reload();
//                    }
//                }).fail(function(){
//                    alert("服务器异常,删除失败,请稍候再试.");
//                })
//            }
//        })
        $(document).delegate(".resetLink", "click", function () {
            var id = $(this).attr("rel");
            if (confirm("是否确认重置密码?重置后密码为000000")) {
                $.get("/admin/" + id + "/resetpsw").done(function (data) {
                    if (data == "success") {
                        dataTable.ajax.reload();
                        alert("重置密码成功,密码为000000")
                    }
                }).fail(function () {
                    alert("服务器异常,重置密码失败,请稍候再试.");
                })
            }
        })

        $(document).delegate(".editLink", "click", function () {
            var id = $(this).attr("rel");
            $.get("/admin/" + id + ".json").done(function (data) {
                $("#editId").val(data.id);
                $("#editUsername").val(data.username);
                $("#editPassword").val(data.password);
                $("#editRealname").val(data.realname);
                $("#editWeixin").val(data.weixin);
                $("#editRoleid").val(data.roleid);
                $("#editEnable").val(data.enable.toString());

                $("#editUserModal").modal({
                    show: true,
                    backdrop: "static",
                    keyboard: false
                });
            }).fail(function () {
                alert("服务器异常,修改失败,请稍候再试.");
            })
        })

        $("#editForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                realname: {
                    required: true,
                    rangelength:[2,18]
                },
                weixin: {
                    required: true,
                    rangelength:[3,18]
                }
            },
            messages: {
                realname: {
                    required: "请输入姓名",
                    rangelength:"长度在2-18位之间"
                },
                weixin: {
                    required: "请输入微信号码",
                    rangelength:"长度在3-18位之间"
                }
            },
            submitHandler: function (form) {
                $.post("/admin/edit", $(form).serialize()).done(function (data) {
                    if (data == "success") {
                        $("#editUserModal").modal('hide');
                        dataTable.ajax.reload();
                    }
                }).fail(function () {
                    alert("服务器异常,请稍候再试");
                })
            }
        })

        $("#editBtn").click(function () {
            $("#editForm").submit();
        })


    })
</script>
</body>
</html>

