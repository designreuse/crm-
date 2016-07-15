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
    <link href="//cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
    <link href="/static/plugins/highlight/styles/atelier-seaside-light.css" rel="stylesheet">
</head>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp" %>
    <!-- Left side column. contains the logo and sidebar -->
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="home"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>&nbsp;&nbsp;</h1>
            <ol class="breadcrumb">
                <li><a href="/home"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/notice/list"><i class="fa fa-bell"></i> 公告列表</a></li>
                <li class="active"><i class="fa fa-book"></i>${notice.title}</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-header text-center" id="header"><strong><h3>${notice.title}</h3></strong>
                    <small>&nbsp;&nbsp;&nbsp;&nbsp;${notice.realname}&nbsp;&nbsp;${notice.creattime}</small>
                </div>
                <div class="box-body" id="body">${notice.content}</div>
            </div>
        </section>
    </div>
</div>

<!-- jQuery 2.2.0 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/highlight/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
</body>
</html>

