package net.wanho.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.wanho.mapper.RoleMapper;
import net.wanho.pojo.Permission;
import net.wanho.pojo.Role;
import net.wanho.pojo.User;
import net.wanho.service.RoleServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2019/8/5/005.
 */
@Service
public class RoleServiceImpl  implements RoleServiceI{
    @Autowired
    private RoleMapper roleMapper;
    @Override
    public List<Role> selectRoleAll() {
        List<Role> roles = roleMapper.selectRoleAll();
        return roles;
    }

    //用户分页
    @Override
    public PageInfo<Role> getAllRoleByPage(Integer pageNum) {
        PageHelper.startPage(pageNum, 5);
        List<Role> roles = roleMapper.selectRoleAll();
        PageInfo<Role> pageInfo = new PageInfo<Role>(roles);

        return pageInfo;
    }


    @Override
    public List<Permission> selectPermissionAll() {
        List<Permission> permissions = roleMapper.selectPermissionAll();
        return permissions;
    }

    @Override
    public List selectPermissionIdByRoleId(Integer RoleId) {
        List<Integer> list = roleMapper.selectPermissionIdByRoleId(RoleId);
        return list;
    }

    @Override
    public void updateRolePermission(Integer roleId, String permissionId) {
        roleMapper.deleteRolePermission(roleId);
        String[] permissionIds= permissionId.split(",");
        for (String id : permissionIds) {
            roleMapper.insertRolePermissipon(roleId,id);
        }
    }

    @Override
    public void insertRole(Role role, String permissionId) {
        roleMapper.insertRole(role);
        Integer roleId=role.getRoleid();
        String[] permissionIds= permissionId.split(",");
        for (String id : permissionIds) {
            roleMapper.insertRolePermissipon(roleId,id);
        }
    }

    @Override
    public void deleteRole(Integer roleId) {
        roleMapper.deleteRole(roleId);
    }
}
