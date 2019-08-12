package net.wanho.mapper;

import net.wanho.pojo.Role;
import net.wanho.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2019/8/1/001.
 */
public interface UserMapper {
    //用户注册
    void register(User user);
    //新增用户默认为普通员工
    void addUserRole(int userid);

    //查询用户名重复
    int selectByName(String name);

    //登录判断
    User selectUserByName(String username);

    //查询所有用户
    List<User> selectAllUser();

    //查询角色
    List<Role> selectAllRole();

    //修改用户角色时先删除
    void deleteRole(int id);

    //修改用户删除后再新增
    void insertRole(@Param("userId") int userId, @Param("roleId") int roleId);

    //用户删除（逻辑删）
    void deleteUser(int userId);

}
