<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <%--<link rel="stylesheet" href="/static/css/font-awesome.min.css">--%>
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
        <jsp:param name="menu" value="doc"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                &nbsp;&nbsp;
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box box-header">
                    <div class="btn btn-success btn-sm" id="newDir" style="float: right;margin-top: 8px"><i
                            class="fa fa-folder"></i>创建文件夹</a> </div>
                    <div id="uploader" class="wu-example">
                        <!--用来存放文件信息-->
                        <div id="thelist" class="uploader-list"></div>
                        <div>
                            <div id="picker" class="pull-right btn btn-group-sm"><span class="text"><i
                                    class="fa fa-upload"></i>上传文件</span></div>
                        </div>
                    </div>
                </div>
                <div class="box box-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                            </button>
                                ${message}
                        </div>
                    </c:if>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>文件名</th>
                            <th>大小</th>
                            <th>创建人</th>
                            <th>上传时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty documentList}">
                            <tr>
                                <td colspan="5">暂时没有数据</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${documentList}" var="doc">
                            <tr>
                                <c:choose>
                                    <c:when test="${doc.type=='dir'}">
                                        <td><i class="fa fa-folder"></i></td>
                                        <td><a href="/doc?fid=${doc.id}">${doc.name}</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><i class="fa fa-file-o"></i></td>
                                        <td><a href="/doc/download/${doc.id}">${doc.name}</a></td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${doc.size==null}">
                                        <td>文件夹</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${doc.size}</td>
                                    </c:otherwise>
                                </c:choose>
                                <td>${doc.creatuser}</td>
                                <td><fmt:formatDate value="${doc.creattime}" pattern="y-M-d H:m"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="box box-footer"></div>
            </div>
        </section>
    </div>

</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="newDirModal" tabindex="-1" role="dialog"
     aria-labelledby="newDirModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title text-center" id="myModalLabel">
                    创建文件夹
                </h4>
            </div>
            <div class="modal-body">
                <input class="form-control" id="dirName" name="dirName" placeholder="请输入文件夹名称">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭
                </button>
                <button type="button" id="newDirBtn" class="btn btn-primary">
                    新增文件夹
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div><!-- /.modal -->

<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/plugins/webuploader/webuploader.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script>
    $(function () {
        console.log("${fid}");
        var uploader = WebUploader.create({

            // swf文件路径
            swf: '/static/plugins/webuploader/Uploader.swf',

            // 文件接收服务端。
            server: '/doc/file/upload',
            formData: {"fid": "${fid}"},//传入参数

            // 选择文件的按钮。可选。
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

        $("#newDir").click(function () {
            $("#newDirModal").modal({
                backdrop: "static",
                keyboard: false,
                show: true
            })
        })
        $("#newDirBtn").click(function () {
            var dirname = $("#dirName").val();
            $.post("/doc/dir/new", {"dirname": dirname, "fid":${fid}}).done(function (result) {
                if (result == "success") {
                    $("#newDirModal").modal('hide');
                    window.location.href = "/doc?fid=" +${fid};
                }
            }).fail(function () {
                alert("创建文件夹失败");
            })
        })
    })
</script>
</body>
</html>

