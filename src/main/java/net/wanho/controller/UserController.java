package net.wanho.controller;

import com.github.pagehelper.PageInfo;
import net.wanho.pojo.Role;
import net.wanho.pojo.User;
import net.wanho.service.UserServiceI;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2019/8/1/001.
 */
@Controller
@RequestMapping("login")
public class UserController {

    @Autowired
    private UserServiceI userServiceI;

    //进入登录页面
    @RequestMapping("login")
    public String login(){
        return "login";
    }

    //进入操作页面
    @RequestMapping("check")
    public String check(User user,boolean remember,Map map){
        String viewName="login";
        map.put("flag","login");
        if (user == null) {
            throw new RuntimeException("参数不能为空");
        }
        try {
            UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(), user.getPassword());
            if (remember){
                token.setRememberMe(remember);
            }

            Subject subject = SecurityUtils.getSubject();
            subject.login(token);
            viewName = "check";
        } catch (Exception e) {
            e.printStackTrace();

        }

        return viewName;
    }

    @RequestMapping("checked")
    public String checked(){
        return "check";
    }

    //注册用户操作
    @RequestMapping("register")
    public String register(User user, HttpServletRequest request){
        int i = userServiceI.selectByName(user.getUsername());
        if(i>0){
            request.setAttribute("flag","2");

        }else if (user.getUsername().equals("")||user.getPassword().equals("")){
            request.setAttribute("flag","3");
        }else {
            userServiceI.register(user);
            request.setAttribute("flag","1");
        }

        return "login";
    }

    //跳转到用户管理页面
    @RequestMapping("UserList")
    public List<User> user(){

        return userServiceI.selectAllUser();
    }

    @RequestMapping("getAllUsersByPage")
    public String getAllUsersByPage(@RequestParam(defaultValue = "1") Integer pageNum, Map map) {
        PageInfo<User> pageInfo = userServiceI.getAllUsersByPage(pageNum);
        List<Role> roles = userServiceI.selectAllRole();
        map.put("pageInfo", pageInfo);
        map.put("roles",roles);
        return "UserList";

    }


    //修改用户角色
    @RequestMapping("updateRole")
    @ResponseBody
    public Integer updateUserRole(int userId,Integer[] arr){
        userServiceI.updateRole(userId,arr);
        return 1;
    }

    //删除用户
    @RequestMapping("deleteUser")
    @ResponseBody
    public Integer deleteUser(int userId){
        userServiceI.deleteUser(userId);
        return 1;
    }
}
