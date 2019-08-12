<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/7/007
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>权限展示</title>
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
    <div style="height: 500px;">
        <div class="col-lg-4">
            <div class="text-center"><kbd>一级权限</kbd></div>
            <c:forEach items="${permissions}" var="permission">
            <a class="list-group-item text-center" onmouseover="showbtn(this)" onmouseout="hidebtn(this)" onclick="showMsg(this,${permission.permissionid})">
                ${permission.permissionname}
                <div style="float: right;" hidden="hidden" >
                    <button value="${permission.permissionname}" type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#myModal" onclick="updatePermission(${permission.permissionid},this)">
                        <span class="glyphicon glyphicon-pencil"></span>修改
                    </button>
                    <button type="button" class="btn btn-danger btn-xs" onclick="remove(${permission.permissionid})">
                        <span class="glyphicon glyphicon-remove" ></span>删除
                    </button>
                </div>
            </a>
            </c:forEach>
        </div>
        <div class="col-lg-4 col-lg-push-0">
            <div class="text-center"><kbd>二级权限</kbd></div>
            <div id="erji">

            </div>
        </div>
        <div class="col-lg-4 col-lg-push-0">
            <div class="text-center"><kbd>三级权限</kbd></div>
            <div id="sanji">

            </div>
        </div>
    </div>
</div>

<div id="myModal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4>权限名修改</h4>
            </div>
            权限名:<input type="text" id="permissionname">
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" onclick="update()">确认</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<script type="application/javascript">
    function showbtn(obj){
        $(obj).find("div").removeAttr("hidden")
    }

    function hidebtn(obj){
        $(obj).find("div").attr("hidden","hidden")
    }
    function showMsg(obj,permissionId){
        $(obj).parent().find("a").removeClass("active");
        $(obj).addClass("active");
        $.ajax({
            url:"/security/selectTwoPermission",
            type: "post",
            data: {"id":permissionId},
            dataType: "json",
            success: function (data) {
                var html="";
                for (var i in data){
                    html=html+"<a class='list-group-item text-center' onmouseover='showbtn(this)' onmouseout='hidebtn(this)' onclick='showMsg1(this,"+data[i].permissionid+")'>"+
                     data[i].permissionname+
                    "<div style='float: right;' hidden>"+
                        "<button value='"+data[i].permissionname+"' type='button' class='btn btn-warning btn-xs' data-toggle='modal' data-target='#myModal' onclick='updatePermission("+ data[i].permissionid+",this)'>"+
                        "<span class='glyphicon glyphicon-pencil'></span>修改"+
                        "</button>"+
                        "<button type='button' class='btn btn-danger btn-xs'onclick='remove("+data[i].permissionid+")'>"+
                        "<span class='	glyphicon glyphicon-remove'></span>删除"+
                        "</button>"+
                        "</div>"+
                        "</a>"
                }
                $("#erji").html(html)
//                location.reload();

            }
        })
    }
    function showMsg1(obj,permissionId){
        $(obj).parent().find("a").removeClass("active");
        $(obj).addClass("active");
        $.ajax({
            url:"/security/selectTwoPermission",
            type: "post",
            data: {"id":permissionId},
            dataType: "json",
            success: function (data) {
                var html="";
                for (var i in data){
                    html=html+"<a class='list-group-item text-center' onmouseover='showbtn(this)' onmouseout='hidebtn(this)' onclick='showMsg2(this)'>"+
                        data[i].permissionname+
                        "<div style='float: right;' hidden>"+
                        "<button value='"+data[i].permissionname+"' type='button' class='btn btn-warning btn-xs' data-toggle='modal' data-target='#myModal' onclick='updatePermission("+ data[i].permissionid+",this)'>"+
                        "<span class='glyphicon glyphicon-pencil'></span> 修改"+
                        "</button>"+
                        "<button type='button' class='btn btn-danger btn-xs' onclick='remove("+data[i].permissionid+")'>"+
                        "<span class='	glyphicon glyphicon-remove'></span> 删除"+
                        "</button>"+
                        "</div>"+
                        "</a>"
                }
                $("#sanji").html(html)
            }
        })
    }
    function showMsg2(obj){
        $(obj).parent().find("a").removeClass("active");
        $(obj).addClass("active");
    }
    //修改权限名
    var permissionid;
    function updatePermission(id,obj){
        permissionid=id;
        $("#permissionname").val($(obj).val())
    }
    function update(){
        var name=$("#permissionname").val();
        $.ajax({
            url:"/security/updatePermissionName",
            type: "post",
            data: {"name":name,"id":permissionid},
            dataType: "json",
            success: function () {
                alert("修改成功");
                location.reload();
            }
        })
    }
    //删除权限
    function remove(id) {
        $.ajax({
            url:"/security/removePermission",
            type: "post",
            data: {"id":id},
            dataType: "json",
            success: function () {
                alert("删除成功");
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
