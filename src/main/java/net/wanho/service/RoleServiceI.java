package net.wanho.service;

import com.github.pagehelper.PageInfo;
import net.wanho.pojo.Permission;
import net.wanho.pojo.Role;
import net.wanho.pojo.User;

import java.util.List;

/**
 * Created by Administrator on 2019/8/5/005.
 */
public interface RoleServiceI {
    //查询角色
    List<Role> selectRoleAll();
    //查询所有权限
    List<Permission> selectPermissionAll();
    //根据ID查询角色拥有的权限
    List<Integer> selectPermissionIdByRoleId(Integer RoleId);
    //修改角色权限
    void updateRolePermission(Integer roleId,String permissionId);
    //实现用户分页
    PageInfo<Role> getAllRoleByPage(Integer pageNum);
    //新增角色
    void insertRole(Role role,String permissionId);
    //删除角色（禁用）
    void deleteRole(Integer roleId);

}
