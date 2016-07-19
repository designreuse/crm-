<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/font/awesome/css/font-awesome.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
    <link rel="stylesheet" href="/static/plugins/fullcalendar/fullcalendar.min.css">
    <link rel="stylesheet" href="/static/plugins/fullcalendar/fullcalendar.print.css" media="print">
    <link rel="stylesheet" href="/static/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="/static/plugins/colorpicker/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/_all-skins.min.css">
</head>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp" %>
    <!-- Left side column. contains the logo and sidebar -->
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="todolist"/>
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
            <div class="row">
                <div class="col-md-8">
                    <div class="box box-primary pull-right">
                        <div class="box-body no-padding">
                            <div id='calendar'></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="box box-default collapsed-box">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-list"></i> 超时计划</h3>
                            <div class="box-tools">
                                <button class="btn btn-box-tool" id="timeoutBtn" data-widget="collapse"
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
                <form id="saveTodoForm" method="post">
                    <input type="hidden" id="start">
                    <input type="hidden" id="end">
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
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="editTodoModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">查看待办事项</h4>
            </div>
            <div class="modal-body">
                <form id="editTodoForm" method="post">
                    <input type="hidden" id="event_id">
                    <div class="form-group">
                        <label>待办内容</label>
                        <div id="event_title"></div>
                    </div>

                    <div class="form-group">
                        <label>开始日期~结束日期</label>
                        <div><span id="event_start"></span>~<span id="event_end"></span></div>
                    </div>
                    <div class="form-group">
                        <label>提醒时间</label>
                        <div id="event_remindtime"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="editBtn">已完成</button>
                <button type="button" class="btn btn-danger" id="delBtn">删除</button>
            </div>
        </div>
    </div>
</div>


<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="//cdn.bootcss.com/jqueryui/1.12.0/jquery-ui.js"></script>
<script src="//cdn.bootcss.com/jQuery-slimScroll/1.3.8/jquery.slimscroll.min.js"></script>
<script src="/static/plugins/daterangepicker/moment.min.js"></script>
<script src="/static/plugins/fullcalendar/fullcalendar.min.js"></script>
<script src="/static/plugins/fullcalendar/lang-all.js"></script>
<script src="/static/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="/static/plugins/datepicker/bootstrap-datepicker.js"></script>

<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script>
    $(function () {
        var _event = null;

        $('#calendar').fullCalendar({
            lang: "zh-CN",
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            buttonText: {
                today: '今天',
                month: '月视图',
                week: '周视图',
                day: '日视图'
            },
            events: "/todo/load",//请求返回数据的网址
            dayClick: function (date, jsEvent, view) {
                $("#saveTodoForm")[0].reset();
                $("#todo_start").val(date.format())
                $("#todo_end").val(date.format())

                $("#newTodoModal").modal({
                    show: true,
                    keyboard: false,
                    backdrop: "static"
                });
            },

            eventClick: function (calEvent, jsEvent, view) {//点击对应事件
                _event = calEvent;
                $("#event_id").val(calEvent.id);
                $("#event_start").text(moment(calEvent.start).format("YY年-MM月-DD日"));
                $("#event_end").text(moment(calEvent.end).format("YY年-MM月-DD日"));
                if ($("#event_remindtime").val()) {
                    $("#event_remindtime").text(calEvent.remindtime);
                } else {
                    $("#event_remindtime").text("无");
                }
                $("#editTodoModal").modal({
                    show: true,
                    backdrop: "static"
                })

            }
        })
        //新增
        $("#todo_start,#todo_end").datepicker({
            format: "yyyy-mm-dd",
            autoclose: true,
            language: "zh-CN",
            todayHighlight: true
        })
        $("#todo_color").colorpicker({
            color: "#61a5e8"
        })
        $("#saveBtn").click(function () {
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
            $.post("/todo/new", $("#saveTodoForm").serialize()).done(function (result) {
                if (result.state == "success") {
                    $("#newTodoModal").modal("hide");
                    $("#calendar").fullCalendar('renderEvent', result.data)
                }
            }).fail(function () {
                alert("服务器出错,新建待办事项失败");
            })
        })

        $("#delBtn").click(function () {
            var id = $("#event_id").val();
            if (confirm("是否确认删除该待办事项?")) {
                $.get("/todo/del/" + id).done(function (data) {
                    if (data == "success") {
                        $("#calendar").fullCalendar('removeEvents', id);
                        $("#editTodoModal").modal("hide");
                    }
                }).fail(function () {
                    alert("服务器异常");
                })
            }
        })

        $("#editBtn").click(function () {
            var id = $("#event_id").val();
            $.post("/todo/editdone/" + id).done(function (data) {
                if (data == "success") {
                    _event.color = "#cccccc";
                    $("#calendar").fullCalendar("updateEvent", _event);
                    $("#editTodoModal").modal("hide");
                }
            }).fail(function () {
                alert("服务器异常.")
            })
        })
        $("#timeoutBtn").click(function(){
            $.get("/todo/timeout").done(function(result){
                $("#tbody").html("");
                var timelist = result.data;
                console.log(timelist.length)
                if (result.state=="success"&&timelist.length){
                    var tds = "";
                    for (var i=0;i<timelist.length;i++){
                        var trs = "<tr><td>"+timelist[i].title+"</td><td>"+timelist[i].start+"</td><td>"+timelist[i].end+"</td></tr>";
                        $("#tbody").append(trs)
                    }
                }
            }).fail(function(){
                alert("服务器出错");
            })
        })

    });
</script>
</body>
</html>

