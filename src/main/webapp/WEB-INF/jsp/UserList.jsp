<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/1/001
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
    <script type="application/javascript" src="/js/jquery-3.4.1.js"></script>
    <!--<script type="text/javascript" src="js/bootstrap.min.3.3.7.js" ></script>
    <link rel="stylesheet" href="css/bootstrap.min.3.3.7.css" />-->
    <script type="application/javascript" src="/js/jqPaginator.js"></script>
    <script type="application/javascript" src="/js/bootstrap.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.css">
</head>

<body>
<div class="container">
    <button class="btn btn-success" onclick="back()">返回主页面</button>
    <table class="table">
        <tr>
            <td>ID</td>
            <td>用户</td>
            <td>状态</td>
            <td>操作</td>
        </tr>
        <c:forEach items="${pageInfo.list}" var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>
                <c:if test="${user.statuc eq 1}"><button class="btn btn-success">正常</button></c:if>
                <c:if test="${user.statuc eq 0}"><button class="btn btn-danger">停职</button></c:if>
            </td>
            <td><button class="btn btn-warning" data-toggle="modal" data-target="#myModal${user.id}">修改</button>
                <button class="btn btn-danger" onclick="del(${user.id})">删除</button></td>
        </tr>
        </c:forEach>
    </table>
    <div class="pagination-layout">
        <div class="pagination">
            <ul class="pagination" total-items="pageInfo.totalRows" max-size="10" boundary-links="true">
            </ul>
        </div>
    </div>
</div>

<c:forEach items="${pageInfo.list}" var="user">
<div id="myModal${user.id}" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4>角色修改</h4>
            </div>
            <div class="modal-body">
                <c:forEach items="${roles}" var="role">
                <div class="checkbox">
                    <label>
                        <input name="roleIds${user.id}" value="${role.roleid}" type="checkbox"<c:forEach items="${user.roles}" var="role1"><c:if test="${role.roleid == role1.roleid}">   checked="checked"</c:if></c:forEach>>${role.rolename}
                        <%--<input type="checkbox" value="${role.roleid}">${role.rolename}--%>
                    </label>
                </div>
                </c:forEach>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" onclick="update${user.id}(${user.id})">确认</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal" onclick="">取消</button>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
        var if_firstime = true;
        window.onload = function () {
            $('.pagination').jqPaginator({
                totalPages: ${pageInfo.pages},
                visiblePages: 4,
                currentPage: ${pageInfo.pageNum},

                first: '<li class="first"><a href="javascript:void(0);">第一页</a></li>',
                prev: '<li class="prev"><a href="javascript:void(0);">上一页</a></li>',
                next: '<li class="next"><a href="javascript:void(0);">下一页</a></li>',
                last: '<li class="last"><a href="javascript:void(0);">最末页 </a></li>',
                page: '<li class="page"><a href="javascript:void(0);">{{page}}</a></li>',

                onPageChange: function (num) {
                    if (if_firstime) {
                        if_firstime = false;
                    } else if (!if_firstime) {
                        changePage(num);
                    }
                }
            });
        };

        function changePage(num) {

            location.href = "/login/getAllUsersByPage?pageNum=" + num;

        }
    </script>
    <script>
        function update${user.id}(userId){
            var arr = [];
            //根据name的值获取到所有选中checkbox，并遍历
            $("input[name='roleIds${user.id}']:checked").each(function (i) {
                //arr.push($(this).val());
                arr[i] = $(this).val();
            });
//            console.log(arr);
        $.ajax({
            url:"/login/updateRole",
            type: "post",
            data:{userId:userId,arr:arr},

            //提交数组时必须设置traditional参数为true
            traditional:true,
//            dataType: "json",
            success: function (data) {
                alert("修改成功");
                location.reload();
            }
        })
        }

    </script>
</c:forEach>
<script>
    function del(userId){

        $.ajax({
            url:"/login/deleteUser",
            type: "post",
            data:{userId:userId},

            //提交数组时必须设置traditional参数为true
            traditional:true,
//            dataType: "json",
            success: function (data) {
                alert("成功开除一混子");
                <%--window.location.href="/login/getAllUsersByPage?pageNum=${pageInfo.pageNum}";--%>
                location.reload();
            }
        })
    }
    //返回主页面
    function back() {
        location.href="/login/checked"
    }
</script>
</body>
</html>
