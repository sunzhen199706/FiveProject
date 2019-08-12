<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <script type="application/javascript" src="/js/jquery-3.4.1.js"></script>
    <script type="application/javascript" src="/js/jqPaginator.js"></script>
    <script type="application/javascript" src="/js/bootstrap.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.css">
</head>
<body>
<div class="container">
    <form class="form-horizontal" action="" method="post">
        <div class="input-group">
            <span class="input-group-addon" id="basic-addon1">用户名：</span>
            <input type="text" class="form-control" placeholder="用户名" aria-describedby="basic-addon1" name="username">
        </div>
        <div class="input-group">
            <span class="input-group-addon" id="basic-addon2">密  码：</span>
            <input type="password" class="form-control" placeholder="密码" aria-describedby="basic-addon2" name="password">
        </div>
        <div class="input-group">
            <span>自动登录：</span>&nbsp;&nbsp;<input type="checkbox" name="remember" value="1">
        </div>
        <div class="input-group">
            <input type="button" value="登录" class="btn btn-primary" onclick="changeAction(1)">

            <input type="button" value="注册" class="btn btn-warning" onclick="changeAction(0)">
        </div>

    </form>
</div>
<script type="application/javascript">
    <c:if test="${flag eq '1'}"> alert("注册成功")</c:if>
    <c:if test="${flag eq '2'}"> alert("用户名已存在")</c:if>
    <c:if test="${flag eq '3'}"> alert("用户名和密码不能为空")</c:if>
    <c:if test="${flag eq 'login'}"> alert("账号或密码错误")</c:if>

    function changeAction(flag) {
        if (flag){
            $(".form-horizontal").attr("action","/login/check").submit();
        }else {
            $(".form-horizontal").attr("action","/login/register").submit();
        }
    }
</script>
</body>
</html>