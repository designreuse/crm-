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
    <link rel="stylesheet" href="/static/font/font-awesome-3.2.1/css/font-awesome.min.css">
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
    <link rel="stylesheet" href="/static/plugins/webuploader/webuploader.css">
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
            <h6 class="box-title">项目详情</h6>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box box-success">
                <shiro:hasRole name="经理">
                    <div class="box box-header">
                        <div class="box-tools">
                            <button id="delBtn" class="btn btn-success"><i class="fa fa-trash"></i>删除该项目</button>
                        </div>
                    </div>
                </shiro:hasRole>

                <div class="box box-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">
                            <a href="#" class="close" data-dismiss="alert">
                                &times;
                            </a>
                            <strong>${message}!</strong>
                        </div>
                    </c:if>
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>关联客户</td>
                            <td><a href="/customer/view/${sale.custid}">${sale.custname}</a></td>
                            <td>价值</td>
                            <td>${sale.price}</td>
                            <td>所属员工</td>
                            <td>${sale.username}</td>
                        </tr>
                        <tr>
                            <td>当前进度</td>
                            <td>${sale.progress} <a href="javascript:;" id="editProgress">修改进度</a></td>
                            <td>最后跟进时间</td>
                            <td>${empty sale.lasttime?"无":sale.lasttime}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="box box-primary">
                            <div class="box-header">
                                <h3 class="box-title">跟进记录</h3>
                                <div class="box-tools">
                                    <button class="box-tools btn btn-success" id="newSaleBtn">新增记录</button>
                                </div>
                            </div>
                            <div class="box-body">
                                <ul class="timeline">
                                    <c:forEach items="${saleLogList}" var="log">
                                        <li>
                                            <c:choose>
                                                <c:when test="${log.type=='auto'}">
                                                    <i class="fa fa-bolt"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-commenting bg-aqua"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="timeline-item">
                                                <span class="time"><i class="fa fa-clock-o"></i><span class="timeago"
                                                                                                      title="${log.creattime}"></span></span>

                                                <h3 class="timeline-header"><a
                                                        href="/customer/view/${sale.custid}">${log.content}</a></h3>
                                            </div>

                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="box-footer"></div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="box box-primary">
                            <div class="box-header">
                                <h3 class="box-title">相关资料</h3>
                                <div class="box-tools">
                                    <div id="picker" class="pull-right btn btn-group-sm"><span class="text"><i
                                            class="fa fa-upload"></i>上传文件</span></div>
                                </div>
                            </div>
                            <div class="box-body">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>文件名</th>
                                        <th>大小</th>
                                        <th>创建时间</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty fileList}">
                                        <h3>暂时没有上传文件</h3>
                                    </c:if>
                                    <c:forEach items="${fileList}" var="file">
                                        <tr>
                                            <td><a href="/sale/file/${file.id}">${file.name}</a></td>
                                            <td>${file.size}</td>
                                            <td>${file.creattime}</td>
                                        </tr>

                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="box-footer">
                            </div>
                        </div>
                        <div class="box box-default">
                            <div class="box-header">
                                <h3 class="box-title"><i class="fa fa-calendar-check-o"></i>任务列表</h3>
                            </div>
                            <div class="box-body">
                                <h5>计划任务</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="box box-footer"></div>
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
                <h4 class="modal-title">新增跟进记录</h4>
            </div>
            <div class="modal-body">
                <form id="newProgressForm" method="post" action="/sale/edit/${sale.id}">
                    <input type="hidden" id="newProgressId" name="id" value="${sale.id}">
                    <div class="form-group">
                        <textarea name="content" id="saveContent" rows="4" class="form-control"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="editProgressBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="editSaleModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改进度</h4>
            </div>
            <div class="modal-body">
                <form id="editForm" method="post" action="/sale/edit/${sale.id}">
                    <input type="hidden" name="id" value="${sale.id}">
                    <input type="hidden" name="userid" value="${sale.userid}">
                    <div class="form-group">
                        <label>当前进度</label>
                        <select class="form-control" name="progress" id="editPro">
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
<script src="/static/plugins/timeago/jquery.timeago.js"></script>
<script src="/static/plugins/timeago/jquery.timeago.zh-CN.js"></script>
<script src="/static/plugins/webuploader/webuploader.min.js"></script>

<script>
    $(function () {
        $(".timeago").timeago();
        $("#editProgress").click(function () {
            $("#editSaleModal").modal({
                keyboard: false,
                show: true,
                backdrop: "static"
            })
        })
        $("#editBtn").click(function () {
            $("#editForm").submit();
            $("#editProgress").modal("hide");
        })
        $("#newSaleBtn").click(function () {
            $("#newSaleModal").modal({
                show: true,
                keyboard: false,
                backdrop: "static"
            })
        })
        $("#editProgressBtn").click(function () {
            var id = $("#newProgressId").val();
            var content = $("#saveContent").val();
            if (!content) {
                $("#saveContent").focus();
                return;
            }
            $.post("/sale/edithand/" + id, {"id": id, "content": content}).done(function (data) {
                if (data == "success") {
                    $("#newSaleModal").modal("hide");
                }
                location.reload();
            }).fail(function () {
                alert("服务器异常,手动修改进程失败.");
            });
        })

        var uploader = WebUploader.create({

            // swf文件路径
            swf: '/static/plugins/webuploader/Uploader.swf',

            // 文件接收服务端。
            server: '/sale/file/upload',
            formData: {"saleid": "${sale.id}"},//传入参数

            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#picker',

            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false,
            auto: true,//选择文件后直接上传
        });

        uploader.on('startUpload', function (file, data) {
            $("#picker .text").html("<i class='fa fa-spinner fa-spin'></i>上传中");
        });
        uploader.on('uploadSuccess', function (file, data) {
            if (data._raw == "success") {
//               window.history.go(0);
                window.location.reload();
            }
        });

        uploader.on('uploadError', function (file) {
            alert('上传出错');
        });

        uploader.on('uploadComplete', function (file) {
            $("#picker .text").html("<i class='fa fa-upload'></i>上传文件").removeAttr("disabled");
        });

        $("#delBtn").click(function () {
            var saleid = ${sale.id};
            if (confirm("是否确认删除,删除后不可找回")) {
                $.get("/sale/del/" + saleid, {"id": saleid}).done(function () {
                    location.href = "/sale/list";
                }).fail(function () {
                    alert("服务器异常,删除项目失败.");
                })
            }
        })

    })


</script>
</body>
</html>

