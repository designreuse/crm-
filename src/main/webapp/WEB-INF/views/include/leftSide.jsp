<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

        <!-- Sidebar user panel (optional) -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="/static/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>Alexander Pierce</p>
                <!-- Status -->
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>

        <!-- search form (Optional) -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
            </div>
        </form>
        <!-- /.search form -->

        <!-- Sidebar Menu -->
        <ul class="sidebar-menu">
            <%--<li class="header">HEADER</li>--%>
            <!-- Optionally, you can add icons to the links -->
            <shiro:hasAnyRoles name="经理,员工">
                <li class="${param.menu=='home'?'active':''}"><a href="/home"><i class="fa fa-home"></i> <span>首页</span></a></li>
                <li class="${param.menu=='notice'?'active':''}"><a href="/notice/list"><i class="fa fa-bullhorn"></i> <span>公告</span></a></li>
                <li class="${param.menu=='project'?'active':''}"><a href="#"><i class="fa fa-building-o"></i> <span>项目管理</span></a></li>
                <li class="${param.menu=='customer'?'active':''}"><a href="/customer/list"><i class="fa fa-users"></i> <span>客户管理</span></a></li>
                <li class="${param.menu=='count'?'active':''}"><a href="#"><i class="fa fa-bar-chart"></i> <span>统计</span></a></li>
                <li class="${param.menu=='todolist'?'active':''}"><a href="#"><i class="fa fa-calendar-o"></i> <span>待办事项</span></a></li>
                <li class="${param.menu=='doc'?'active':''}"><a href="/doc"><i class="fa fa-file"></i> <span>文档管理</span></a></li>

            </shiro:hasAnyRoles>
            <shiro:hasRole name="管理员">

                <li class="treeview">
                    <a href="#"><i class="fa fa-wrench"></i> <span>系统管理</span> <i
                            class="fa fa-angle-left pull-right"></i></a>
                    <ul class="treeview-menu">
                        <li><a href="/admin/show">员工管理</a></li>
                        <li><a href="#">系统设置</a></li>
                    </ul>
                </li>
            </shiro:hasRole>

        </ul>
        <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
</aside>
