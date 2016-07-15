package com.kingit.controller;

import com.kingit.dto.DatatableResult;
import com.kingit.exception.NotFoundException;
import com.kingit.mapper.RoleMapper;
import com.kingit.pojo.User;
import com.kingit.pojo.UserLog;
import com.kingit.service.UserService;
import com.kingit.utils.Md5Util;
import com.kingit.utils.ShiroUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/7/9.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Inject
    private UserService userService;
    @Inject
    private RoleMapper roleMapper;

    @RequestMapping(value = "/password",method = RequestMethod.GET)
    public String password(){
        return "setting/password";
    }

    @RequestMapping(value = "/password",method = RequestMethod.POST)
    @ResponseBody
    public String updatePassword(String password){
        userService.updatePassword(password);
        return "success";
    }

    /**
     * 验证原始密码是否正确(Ajax调用)
     * request.getHeader("x-requested-with"); 为 null，则为传统同步请求，为 XMLHttpRequest，则为 Ajax 异步请求。
     * @return
     */
    @RequestMapping(value = "/validation/password",method = RequestMethod.GET)
    @ResponseBody
    public String validateOldPassword(@RequestHeader("X-Requested-With") String xRequestedWith ,String oldPassword){
        if ("XMLHttpRequest".equals(xRequestedWith)){
            User user = ShiroUtil.getCurrentUser();
            if (user.getPassword().equals(Md5Util.Md5(oldPassword))){
                return "true";
            }
            return "false";
        }else {//如果不是异步请求,则报异常,为了账户安全,防止域名侵入
            throw new NotFoundException();
        }
    }

    /**
     * 记录登录日志
     * @return
     */
    @RequestMapping(value = "/log",method = RequestMethod.GET)
    public String log(){
        return "setting/loglist";
    }

    /**
     * 异步加载日志
     * @param request
     * @return
     */
    @RequestMapping(value = "/log/load",method = RequestMethod.GET)
    @ResponseBody
    public DatatableResult userlogLoad(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");

        List<UserLog> userLogList = userService.findCurrentUserLog(start,length);

        Long count = userService.findCurrentUserLogCount();

        return new DatatableResult(draw,count,count,userLogList);

    }

 }
