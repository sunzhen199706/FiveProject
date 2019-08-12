<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/1/001
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="application/javascript" src="/js/jquery-3.4.1.js"></script>
    <!--<script type="text/javascript" src="js/bootstrap.min.3.3.7.js" ></script>
    <link rel="stylesheet" href="css/bootstrap.min.3.3.7.css" />-->
    <script type="application/javascript" src="/js/jqPaginator.js"></script>
    <script type="application/javascript" src="/js/bootstrap.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.css">
</head>
<body style="margin: 100px auto;width: 260px">
<button class="btn btn-success" onclick="user()">用户管理</button>
<button class="btn btn-success" onclick="role()">角色管理</button>
<button class="btn btn-success" onclick="permission()">权限管理</button>
<%--<a href="/login/getAllUsersByPage">用户管理</a>--%>
<%--<a href="/role/getAllRoleByPage">角色管理</a>--%>
<%--<a href="/security/getAllPermission">权限管理</a>--%>
<script>
    function user() {
        location.href="/login/getAllUsersByPage"
    }
    function role() {
        location.href="/role/getAllRoleByPage"
    }
    function permission() {
        location.href="/security/getAllPermission"
    }
</script>
</body>
</html>
