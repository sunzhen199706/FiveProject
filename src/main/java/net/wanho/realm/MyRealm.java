package net.wanho.realm;



import net.wanho.pojo.User;
import net.wanho.service.UserServiceI;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * Created by Administrator on 2019/7/30 0030.
 */
@Component
public class MyRealm extends AuthorizingRealm{
    @Autowired
    private UserServiceI userServiceI;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
//        List<String> roles= Arrays.asList("admin","manager");
//        List<String> permission =Arrays.asList("student:add","student:delete");
//        SimpleAuthorizationInfo simple =new SimpleAuthorizationInfo();
//        simple.addStringPermissions(permission);
//        simple.addRoles(roles);
//        return simple;
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //得到用户名与密码
//        String password =new String((char[]) token.getCredentials());
        String username = (String) token.getPrincipal();
        //根据用户名查询对象
        User user = userServiceI.selectUserByName(username);
//        if (user==null){
//            throw new UnknownAccountException("账号有误");
//        }


        //取出用户的密码，按照同样的加密方式进行比对
        return new SimpleAuthenticationInfo(username,user.getPassword(), ByteSource.Util.bytes(user.getSalt()),getName());
    }
}
