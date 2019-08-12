package net.wanho.mapper;

import net.wanho.pojo.Permission;
import net.wanho.pojo.Role;

import java.util.List;

/**
 * Created by Administrator on 2019/8/5/005.
 */
public interface RoleMapper {
    //查询角色
    List<Role> selectRoleAll();
    //查询所有权限
    List<Permission> selectPermissionAll();
    //根据ID查询角色拥有的权限
    List<Integer> selectPermissionIdByRoleId(Integer RoleId);

    //修改角色的权限
    //先做删除
    void deleteRolePermission(Integer roleId);
    //在做新增
    void insertRolePermissipon(Integer roleId,String permissionId);

    //新增角色
    void insertRole(Role role);

    //删除角色（禁用）
    void deleteRole(Integer roleId);
}
