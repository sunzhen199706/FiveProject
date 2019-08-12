<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/5/005
  Time: 9:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
    <script type="application/javascript" src="/js/jquery-3.4.1.js"></script>
    <script type="application/javascript" src="/js/jquery.ztree.all.js"></script>
    <!--<script type="text/javascript" src="js/bootstrap.min.3.3.7.js" ></script>
    <link rel="stylesheet" href="css/bootstrap.min.3.3.7.css" />-->
    <script type="application/javascript" src="/js/jqPaginator.js"></script>
    <script type="application/javascript" src="/js/bootstrap.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/zTreeStyle/zTreeStyle.css">
</head>
<body>
<div class="container">
    <button class="btn btn-success" onclick="back()">返回主页面</button>
    <button class="btn btn-info" data-toggle="modal" data-target="#myModal1" onclick="selectPermission()">添加</button>
    <table class="table">
        <tr>
            <td>ID</td>
            <td>角色</td>
            <td>状态</td>
            <td>操作</td>
        </tr>
        <c:forEach items="${pageInfo.list}" var="role">
            <tr>
                <td>${role.roleid}</td>
                <td>${role.rolename}</td>
                <td>
                <c:if test="${role.statuc==1}"><button class="btn btn-success">正常</button></c:if>
                <c:if test="${role.statuc==0}"><button class="btn btn-danger">禁用</button></c:if>
                </td>
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#myModal"
                            onclick="selectPermission(${role.roleid})">修改
                    </button>
                    <button class="btn btn-danger" onclick="deleteRole(${role.roleid})">删除</button>
                </td>
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
<div id="myModal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4>权限修改</h4>
            </div>
            <div class="modal-body">
                <ul id="regionZTree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" onclick="update()">确认</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div id="myModal1" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4>角色新增</h4>
            </div>
            <div class="modal-body">
                角色名称:<input id="roleName" name="roleName" type="text"><br>
                选择权限:
                <ul id="regionZTree1" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" onclick="insert()">确认</button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
</body>
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

        location.href = "/role/getAllRoleByPage?pageNum=" + num;

    }
</script>
<script>
    var setting = {
        view: {
            dblClickExpand: false,//双击节点时，是否自动展开父节点的标识
            showLine: true,//是否显示节点之间的连线
            fontCss: {'color': 'black', 'font-weight': 'bold'},//字体样式函数
            selectedMulti: true //设置是否允许同时选中多个节点
        },
        check: {
//            chkboxType: {"Y": "ps", "N": "ps"},
            chkboxType: {"Y": "p", "N": "p"},
            chkStyle: "checkbox",//复选框类型
            enable: true //每个节点上是否显示 CheckBox
        },
        edit: {
            enable: true,
            editNameSelectAll: true,
            showRemoveBtn: false,
            showRenameBtn: false,
            removeTitle: "remove",
            renameTitle: "rename"
        },
        data: {
            simpleData: {//简单数据模式
                enable: true,
                idKey: "permissionid",
                pIdKey: "paramid",
                rootPId: 0

            },
            key: {
                name: "permissionname"
            }

        }

//        callback: {
//            beforeExpand:zTreeBeforeExpand, // 用于捕获父节点展开之前的事件回调函数，并且根据返回值确定是否允许展开操作
//        }
    };

    //查询用户权限和和修改时用户权限的回填
    var roleid=0;
    function selectPermission(id) {

        $.ajax({
            url: "/role/selectPermissionAll",
            type: "post",
            data: {},
            dataType: "json",
            success: function (dominZTree) {
//                console.log(dominZTree)
                zTreeObj = $.fn.zTree.init($("#regionZTree"), setting, dominZTree);
                zTreeObj = $.fn.zTree.init($("#regionZTree1"), setting, dominZTree);
                //进行修改时的回填
                if (id != null) {
                    var nodes = $.fn.zTree.getZTreeObj("regionZTree").getNodes();
                    var array = $.fn.zTree.getZTreeObj("regionZTree").transformToArray(nodes);
                    $.ajax({
                        url: "/role/selectPermissionIdByRoleId",
                        type: "post",
                        data: {"roleId": id},
                        dataType: "json",
                        success: function (hastree) {
                            for (var i in array) {
                                for (var j in hastree) {
                                    if (array[i].permissionid == hastree[j]) {
                                        $.fn.zTree.getZTreeObj("regionZTree").checkNode(array[i], true, true);
                                    }
                                }
                            }
                            //将角色Id付给一个全局变量，用于修改
                            roleid=id;
                        }
                    })
                }
            }
        });
    }

//    修改角色权限
    function update() {
        //获取权限ID
        var zTree = $.fn.zTree.getZTreeObj("regionZTree");
        checkCount = zTree.getCheckedNodes(true);
        var permissionIds = "";
        for (var i = 0; i < checkCount.length; i++) {
            if (i == 0) {
                permissionIds = checkCount[i].permissionid;
            }
            else {
                permissionIds += "," + checkCount[i].permissionid;
            }
        }
//        alert(roleid);
//        $("#checklist").val(classpurview);
        $.ajax({
            url:"/role/updateRolePermission",
            type: "post",
            data: {"roleid":roleid,"permissionIds":permissionIds},
            success: function (dominZTree) {
                alert("修改成功")
            }
        })
    }
    //    新增角色权限
    function insert() {
        //获取权限ID
        var zTree = $.fn.zTree.getZTreeObj("regionZTree1");
        checkCount = zTree.getCheckedNodes(true);
        var permissionIds = "";
        for (var i = 0; i < checkCount.length; i++) {
            if (i == 0) {
                permissionIds = checkCount[i].permissionid;
            }
            else {
                permissionIds += "," + checkCount[i].permissionid;
            }
        }
        //获取新增角色的名称
        var roleName=$("#roleName").val();
        $.ajax({
            url:"/role/insertRole",
            type: "post",
            data: {"roleName":roleName,"permissionIds":permissionIds},
            success: function (dominZTree) {
                alert("新增成功");
//                window.location.href="/role/getAllRoleByPage";
                location.reload();
            }
        })
    }
    //删除角色（禁用）
    function deleteRole(id) {
        $.ajax({
            url:"/role/deleteRole",
            type: "post",
            data: {"roleId":id},
            success: function (dominZTree) {
                alert("删除成功");
                <%--window.location.href="/role/getAllRoleByPage?pageNum=${pageInfo.pageNum}";--%>
                location.reload();
            }
        })

    }

    //返回主页面
    function back() {
        location.href="/login/checked"
    }
</script>
</html>
