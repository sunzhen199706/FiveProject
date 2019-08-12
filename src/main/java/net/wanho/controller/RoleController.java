package net.wanho.controller;

import com.github.pagehelper.PageInfo;
import net.wanho.pojo.Permission;
import net.wanho.pojo.Role;
import net.wanho.pojo.User;
import net.wanho.service.RoleServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

import static org.apache.shiro.web.filter.mgt.DefaultFilter.roles;

/**
 * Created by Administrator on 2019/8/5/005.
 */
@Controller
@RequestMapping("role")
public class RoleController {
    @Autowired
    private RoleServiceI roleServiceI;

    @RequestMapping("role")
    public List<Role> selectRoleALL(Map map){
        List<Role> roles = roleServiceI.selectRoleAll();
        return roles;
    }
    @RequestMapping("getAllRoleByPage")
    public String getAllUsersByPage(@RequestParam(defaultValue = "1") Integer pageNum, Map map) {
        PageInfo<Role> pageInfo = roleServiceI.getAllRoleByPage(pageNum);
        map.put("pageInfo", pageInfo);
        return "roleList";

    }

    @RequestMapping("selectPermissionAll")
    @ResponseBody
    public List<Permission> selectPermissionAll(){
        List<Permission> permissions =roleServiceI.selectPermissionAll();
        return permissions;
    }

    @RequestMapping("selectPermissionIdByRoleId")
    @ResponseBody
    public List<Integer> selectPermissionIdByRoleId(Integer roleId){
        List<Integer> list = roleServiceI.selectPermissionIdByRoleId(roleId);
        return list;
    }

    @RequestMapping("updateRolePermission")
    @ResponseBody
    public int updateRolePermission(Integer roleid,String permissionIds){
        roleServiceI.updateRolePermission(roleid,permissionIds);
        return 1;
    }

    @RequestMapping("insertRole")
    @ResponseBody
    public int insertRole(String roleName, String permissionIds){
        Role role = new Role();
        role.setRolename(roleName);
        roleServiceI.insertRole(role,permissionIds);
        return 1;
    }

    @RequestMapping("deleteRole")
    @ResponseBody
    public int deleteRole(Integer roleId){
        roleServiceI.deleteRole(roleId);
        return 1;
    }

}
