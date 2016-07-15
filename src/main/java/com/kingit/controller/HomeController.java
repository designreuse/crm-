package com.kingit.controller;

import com.kingit.dto.FlashMessage;
import com.kingit.mapper.UserMapper;
import com.kingit.service.UserService;
import com.kingit.utils.Md5Util;
import com.kingit.utils.ServletUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2016/7/7.
 */
@Controller
public class HomeController {
    @Inject
    private UserMapper userMapper;
    @Inject
    private UserService userService;

    @RequestMapping(value = "/home",method = RequestMethod.GET)
    public String home(){
        return "home";
    }
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String login(){
        return "login";
    }
    @RequestMapping(value = "/",method = RequestMethod.POST)
    public String login(String username, String password, RedirectAttributes redirectAttributes, HttpServletRequest request){
        Subject subject = SecurityUtils.getSubject();
        password = Md5Util.Md5(password);
        System.out.println("======"+password);

        if (subject.isAuthenticated()){//如果已经登录,则退出
            subject.logout();
        }

        try {
            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, password);
            subject.login(usernamePasswordToken);
            //获取登录的ip.并保存用户日志
            userService.savaUserLog(ServletUtil.getRemoteIp(request));


            return "redirect:/home";
        }catch (LockedAccountException ex){
            redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_ERROR,"账号已被禁用."));
        }catch (AuthenticationException e) {
            redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_ERROR,"账号或密码错误"));
            redirectAttributes.addFlashAttribute("username",username);
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(RedirectAttributes redirectAttributes){
        SecurityUtils.getSubject().logout();//登录退出机制
        redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_SUCCESS,"您已安全退出"));
        return "redirect:/";
    }

    @RequestMapping(value = "/403")
    public String error403(){
        return "error/403";
    }
}
