<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM|客户信息</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
    <link rel="stylesheet" href="/static/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="/static/plugins/colorpicker/bootstrap-colorpicker.min.css">
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
                <li><a href="/home"><i class="fa fa-home"></i> 主页</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">
                        <c:choose>
                            <c:when test="${customer.type == 'person'}">
                                <i class="fa fa-user"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-bank"></i>
                            </c:otherwise>
                        </c:choose>
                        ${customer.name}
                    </h3>
                </div>
                <c:if test="${not empty message}">
                    <div class="alert alert-info alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert"
                                aria-hidden="true">
                            &times;
                        </button>
                            ${message}
                    </div>
                </c:if>
                <div class="box-tools pull-right">
                    <c:if test="${not empty customer.userid}">
                        <button class="btn btn-success btn-xs" id="openCustomer">公开客户</button>
                        <button class="btn btn-danger btn-xs" id="moveCustomer">转移客户</button>
                    </c:if>
                    <c:if test="${empty customer.userid}">
                        <button class="btn btn-facebook btn-xs" id="privateCustomer">设为私有</button>
                    </c:if>
                </div>
                <div class="box-body">
                    <table class="table">
                        <tr>
                            <td>联系电话</td>
                            <td>${customer.tel}</td>
                            <td>微信</td>
                            <td>${customer.weixin}</td>
                            <td>电子邮件</td>
                            <td>${customer.email}</td>
                        </tr>
                        <tr>
                            <td>等级</td>
                            <td style="color: #ff7400">${customer.level}</td>
                            <td>地址</td>
                            <td colspan="3">${customer.address}</td>
                        </tr>
                        <c:if test="${not empty customer.companyid}">
                            <tr>
                                <td>所属公司</td>
                                <td colspan="5"><a
                                        href="/customer/view/${customer.companyid}">${customer.companyname}</a></td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty customerList}">
                            <tr>
                                <td>关联客户</td>
                                <td colspan="5">
                                    <c:forEach items="${customerList}" var="cust">
                                        <c:choose>
                                            <c:when test="${userid==cust.userid}">
                                                <a class="btn btn-success"
                                                   href="/customer/view/${cust.id}"> ${cust.name}</a>
                                            </c:when>
                                            <c:when test="${cust.userid==null}">
                                                <a class="btn btn-info"
                                                   href="/customer/view/${cust.id}"> ${cust.name}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="btn btn-danger"
                                                   href="/customer/view/${cust.id}"> ${cust.name} </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:if>
                    </table>

                </div>
                <div class="box-footer"></div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-list"></i> 项目列表</h3>
                        </div>
                        <div class="box-body">
                            <h5>暂无项目</h5>
                        </div>
                    </div>
                </div>
                <%--col-md-8 end--%>
                <div class="col-md-4">
                    <div class="box box-default collapsed-box">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-qrcode"></i> 电子名片</h3>
                            <div class="box-tools">
                                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"><i
                                        class="fa fa-plus"></i></button>
                            </div>
                        </div>
                        <div class="box-body" style="text-align: center">
                            <img src="/customer/qrcode/${customer.id}.png">
                        </div>
                    </div>

                    <div class="box box-default collapsed-box">
                        <div class="box-header with-border ">
                            <h3 class="box-title"><i class="fa fa-calendar-check-o"></i> 代办事项</h3>
                            <div class="box-tools">
                                <button class="btn btn-box-tool" id="newTodoBtn"
                                        data-toggle="tooltip"><i class="fa fa-list"></i>新增待办事项
                                </button>
                                <button class="btn btn-box-tool" id="todolistBtn" data-widget="collapse"
                                        data-toggle="tooltip"><i class="fa fa-plus"></i></button>
                            </div>
                        </div>

                        <div class="box-body" style="text-align: center">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>事项</th>
                                    <th>开始日期</th>
                                    <th>结束日期</th>
                                </tr>
                                </thead>
                                <tbody id="tbody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <%--col-md-4 end--%>
            </div>

        </section>
    </div>

</div>

<!-- Modal -->
<div class="modal fade" id="newTodoModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增待办事项</h4>
            </div>
            <div class="modal-body">
                <form id="saveTodoForm" method="post" action="/customer/newtodo">
                    <input type="hidden" name="custid" value="${customer.id}">
                    <div class="form-group">
                        <label>待办内容</label>
                        <div>
                            <input type="text" name="title" id="todo_title" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>开始日期</label>
                        <input type="text" name="start" id="todo_start" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>结束日期</label>
                        <input type="text" name="end" id="todo_end" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>提醒时间</label>
                        <div>
                            <select name="hour" style="width: 250px;height: 30px">
                                <option value="">时</option>
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                                <option value="13">13</option>
                                <option value="14">14</option>
                                <option value="15">15</option>
                                <option value="16">16</option>
                                <option value="17">17</option>
                                <option value="18">18</option>
                                <option value="19">19</option>
                                <option value="20">20</option>
                                <option value="21">21</option>
                                <option value="22">22</option>
                                <option value="23">23</option>
                            </select>
                            <select name="minute" style="width: 250px;height: 30px">
                                <option value="">分</option>
                                <option value="10">10</option>
                                <option value="20">20</option>
                                <option value="30">30</option>
                                <option value="40">40</option>
                                <option value="50">50</option>
                                <option value="55">55</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>选择颜色</label>
                        <input type="text" name="color" id="todo_color" class="form-control">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveTodoBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- ./wrapper -->
<div class="modal fade" id="moveModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">转移客户</h4>
            </div>
            <div class="modal-body">
                <form id="moveForm" action="/customer/move" method="post">
                    <input type="hidden" name="id" value="${customer.id}">
                    <div class="form-group" id="editCompanyList">
                        <label>请选择转入员工姓名</label>
                        <select name="userid" class="form-control">
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.realname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="moveBtn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/daterangepicker/moment.min.js"></script>
<script src="/static/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<script>
    $(function () {
        $("#moveCustomer").click(function () {
            $("#moveModal").modal({
                show: true,
                backdrop: "static",
                keyboard: false
            });
        })
        $("#moveBtn").click(function () {
            $("#moveForm").submit();
        })

        $("#openCustomer").click(function () {
            var id =
            ${customer.id}
            if (confirm("是否确认公开客户？")) {
                window.location.href = "/customer/open/" + id;
            }
        })

        $("#privateCustomer").click(function () {
            var id = ${customer.id};
            if (confirm("是否确认私有此客户?")) {
                window.location.href = "/customer/private/" + id;
            }
        })


        $("#newTodoBtn").click(function () {
            $("#newTodoModal").modal();



            $("#saveTodoBtn").click((function () {
                var starttime = moment($("#todo_start").val());
                var endtime = moment($("#todo_end").val());
                var title = $("#todo_title").val();

                if (!title) {
                    $("#todo_title").focus();
                    return;
                }
                if (starttime.isAfter(endtime)) {
                    alert("结束时间必须大于开始时间");
                    return;
                }
                $("#saveTodoForm").submit();
            }))

        })
        $("#todo_start,#todo_end").datepicker({
            format: "yyyy-mm-dd",
            autoclose: true,
            language: "zh-CN",
            todayHighlight: true
        })
        $("#todo_color").colorpicker({
            color: "#61a5e8"
        })

        $("#todolistBtn").click(function(){
            $.get("/customer/todolist/"+${customer.id}).done(function(result){
                $("#tbody").html("");
                var todolist = result.data;
                if (result.state=="success"&&todolist.length){
                    for (var i=0;i<todolist.length;i++){
                        var trs = "<tr><td class='text-info'>"+todolist[i].title+"</td><td>"+todolist[i].start+"</td><td>"+todolist[i].end+"</td></tr>";
                        $("#tbody").append(trs);
                    }
                }
            }).fail(function(){
                alert("服务器出错");
            })
        })
    })
</script>
</body>
</html>

