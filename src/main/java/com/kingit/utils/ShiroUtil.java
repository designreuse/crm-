package com.kingit.utils;

import com.kingit.pojo.Role;
import com.kingit.pojo.User;
import org.apache.shiro.SecurityUtils;

/**
 * Created by Administrator on 2016/7/9.
 */
public class ShiroUtil {
    public static User getCurrentUser(){
        //SecurityUtils.getSubject().getPrincipal()获取当前捕获对象
        User user= (User) SecurityUtils.getSubject().getPrincipal();
        if (user.getRoleid()==1){
            user.setRole(new Role(1,"管理员"));
        }else if (user.getRoleid()==2){
            user.setRole(new Role(2,"经理"));
        }else {
            user.setRole(new Role(3,"员工"));
        }
        return user;
    }
    public static Integer getCurrentUserId(){
        return getCurrentUser().getId();
    }
    public static String getCurrentUserName(){
        return getCurrentUser().getUsername();
    }

    public static String getCurrentRealName() {
        return getCurrentUser().getRealname();
    }
    public static boolean isManger(){
        System.out.println(getCurrentUser());
        return "经理".equals(getCurrentUser().getRole().getRolename());
    }

    public static boolean isUser(){
        return "员工".equals(getCurrentUser().getRole().getRolename());
    }

    public static boolean isAdmin(){
        return "管理员".equals(getCurrentUser().getRole().getRolename());
    }
}
