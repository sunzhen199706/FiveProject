package net.wanho.mapper;

import net.wanho.pojo.Permission;

import java.util.List;

/**
 * Created by Administrator on 2019/8/7/007.
 */
public interface PermissionMapper {
    //查询一级权限菜单
    List<Permission> selectOnePermission();
    //根据一级菜单id查询二级菜单
    List<Permission> selectTwoPernission(Integer id);
    //修改权限名称
    void updatePermissionName(String name,Integer id);
    //删除权限
    void deletePermissionById(Integer id);
    //判断是否有下级权限并返回下级权限对象集合
    List<Permission> selectLowerMenu(Integer id);
    //删除下级权限
    void  deletePermissionByParamid(Integer paramId);
}
