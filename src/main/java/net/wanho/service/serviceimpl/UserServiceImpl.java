package net.wanho.service.serviceimpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.wanho.mapper.UserMapper;
import net.wanho.pojo.Role;
import net.wanho.pojo.User;
import net.wanho.service.UserServiceI;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

/**
 * Created by Administrator on 2019/8/1/001.
 */
@Service
public class UserServiceImpl implements UserServiceI{
    @Autowired
    private UserMapper userMapper;

    @Override
    public void register(User user) {
            //给user对象进行加密
            //给userstatus赋给一个状态 1为正常
            user.setStatuc("1");
            String salt = UUID.randomUUID().toString();
            //给setSalt赋一个盐值
            user.setSalt(salt);
            //设置密码
            user.setPassword(shiroMD5(user.getPassword(),salt));
            userMapper.register(user);
            userMapper.addUserRole(user.getId());
    }
    //判断用户名是否重复
    @Override
    public int selectByName(String name) {
        return userMapper.selectByName(name);
    }

    @Override
    public List<User> selectAllUser() {
        List<User> users = userMapper.selectAllUser();
        return users;
    }

    @Override
    public List<Role> selectAllRole() {
        List<Role> roles = userMapper.selectAllRole();
        return roles;
    }

    @Override
    public void updateRole(int userId,Integer[] roleId ) {
        userMapper.deleteRole(userId);
       for (Integer id : roleId) {
            userMapper.insertRole(userId,id);
        }
    }
    //用户分页
    @Override
    public PageInfo<User> getAllUsersByPage(Integer pageNum) {
        PageHelper.startPage(pageNum, 5);
        List<User> users = userMapper.selectAllUser();
        PageInfo<User> pageInfo = new PageInfo<User>(users);

        return pageInfo;
    }

    @Override
    public void deleteUser(int userId) {
        userMapper.deleteUser(userId);
    }

    @Override
    public User selectUserByName(String username) {
        User user1 = userMapper.selectUserByName(username);
        return user1;
    }




    public String shiroMD5(String password,String salt){
//        加密方式
        String hashAlgorithmName="MD5";

//        加密次数
        int hashIterations=2;

//        把salt转成ByteSource
        ByteSource saltSource = ByteSource.Util.bytes(salt);

        Object object = new SimpleHash(hashAlgorithmName, password, saltSource, hashIterations);
        return object.toString();
    }
}
