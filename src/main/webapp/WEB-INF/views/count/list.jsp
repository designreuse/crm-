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
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-green.min.css">
</head>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp" %>
    <!-- Left side column. contains the logo and sidebar -->
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="count"/>
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

        <section class="content">
            <div class="col-md-5">
                <div class="box box-primary">
                    <div class="box-header"></div>
                    <div class="box-body">
                        <div id="main" style="width: 350px;height:300px;"></div>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="box box-primary">
                    <div class="box-header"></div>
                    <div class="box-body">
                        <div id="salesColumn" style="width: 450px;height:300px;"></div>
                    </div>
                </div>
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
<script src="/static/js/echarts.common.min.js"></script>
<script src="/static/js/moment.min.js"></script>
<script>
    $(function () {
        // 基于准备好的dom，初始化echarts实例
        var now = moment().format("YYYY年MM月");
        var pieChart = echarts.init(document.getElementById('main'));
        var pieOption = {
            title: {
                text: '销售饼图' + "(" + now + ")",
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series: [
                {
                    name: '销售机会',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        pieChart.setOption(pieOption)
        // 异步加载数据
        $.get('/count/progress/data').done(function (data) {
            // 填入数据
            pieChart.setOption({
                series: [{
                    data: data
                }]
            });
        });

        var barChart = echarts.init($("#salesColumn")[0]);
// 显示标题，图例和空的坐标轴
        var barOption = {
            title: {
                text: '个人销售业绩'+ "(" + now + ")",
                x: 'center'
            },
            tooltip: {},
            xAxis: {
                data: []
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: []
            }]
        };


        barChart.setOption(barOption);
        $.get('/count/sales').done(function (data) {
            // 填入数据
            barChart.setOption({
                xAxis: {
                    data: data.names
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '销量',
                    data: data.values
                }]
            });
        });
    })
</script>
</body>
</html>

