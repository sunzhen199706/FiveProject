package net.wanho.service;

import com.github.pagehelper.PageInfo;
import net.wanho.pojo.Role;
import net.wanho.pojo.User;

import java.util.List;

/**
 * Created by Administrator on 2019/8/1/001.
 */
public interface UserServiceI {
    //用户注册
    void register(User user);
    //查询所有用户
    List<User> selectAllUser();
    //查询角色
    List<Role> selectAllRole();
    //修改角色
    void updateRole(int userId,Integer[] roleId);
    //实现用户分页
    PageInfo<User> getAllUsersByPage(Integer pageNum);

    //用户删除（逻辑删）
    void deleteUser(int userId);

    //登录判断
    User selectUserByName(String user);

    //注册重名判断
    int selectByName(String name);

}
