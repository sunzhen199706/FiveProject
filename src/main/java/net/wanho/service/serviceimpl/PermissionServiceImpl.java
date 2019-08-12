package net.wanho.service.serviceimpl;

import net.wanho.mapper.PermissionMapper;
import net.wanho.pojo.Permission;
import net.wanho.service.PermissionServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2019/8/7/007.
 */
@Service
public class PermissionServiceImpl implements PermissionServiceI {
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<Permission> selectOnePermission() {
        List<Permission> permissions = permissionMapper.selectOnePermission();
        return permissions;
    }

    @Override
    public List<Permission> selectTwoPernission(Integer id) {

        return permissionMapper.selectTwoPernission(id);
    }

    @Override
    public void updatePermissionName(String name, Integer id) {
        permissionMapper.updatePermissionName(name,id);
    }
    //删除权限
    @Override
    public void deletePermissionById(Integer id) {
        permissionMapper.deletePermissionById(id);
    }
    //判断是否有下级权限并返回下级权限对象集合
    @Override
    public List<Permission> selectLowerMenu(Integer id) {
        return permissionMapper.selectLowerMenu(id);
    }
    //删除下级权限
    @Override
    public void deletePermissionByParamid(Integer paramId) {
        permissionMapper.deletePermissionByParamid(paramId);
    }
}
