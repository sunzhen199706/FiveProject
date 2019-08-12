package net.wanho.controller;

import net.wanho.pojo.Permission;
import net.wanho.service.PermissionServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2019/8/7/007.
 */
@Controller
@RequestMapping("security")
public class PermissionController {
    @Autowired
    private PermissionServiceI permissionServiceI;

    @RequestMapping("getAllPermission")
    public String getAllPermission(Map map){
        List<Permission> permissions = permissionServiceI.selectOnePermission();
        map.put("permissions",permissions);
        return "security";
    }

    @RequestMapping("selectTwoPermission")
    @ResponseBody
    public List<Permission> selectTwoPermission(Integer id){
        List<Permission> permissions = permissionServiceI.selectTwoPernission(id);
        return permissions;
    }

    @RequestMapping("updatePermissionName")
    @ResponseBody
    public Integer updatePermissionName(String name,Integer id){
        permissionServiceI.updatePermissionName(name,id);
        return 1;
    }

    //递归删除权限
    @RequestMapping("removePermission")
    @ResponseBody
    public Integer removePermission(Integer id){
        //删除所选权限
        permissionServiceI.deletePermissionById(id);
        //查询是否有下级权限
        List<Permission> permissions = permissionServiceI.selectLowerMenu(id);
        if(permissions.size()>0){
            for (Permission permission : permissions) {
                //删除下级权限
                permissionServiceI.deletePermissionByParamid(permission.getPermissionid());
                //查询是否有下级菜单
                List<Permission> permissions1 = permissionServiceI.selectLowerMenu(permission.getPermissionid());
                if(permissions1.size()>0){
                    for (Permission permission1 : permissions1) {
                        //删除下级权限
                        permissionServiceI.deletePermissionByParamid(permission1.getPermissionid());
                    }
                }
            }
        }
        return 1;
    }
}
