package com.kingit.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2016/7/10.
 */
public class ServletUtil {
    public static String getRemoteIp(HttpServletRequest request){
        String ip =  request.getRemoteAddr();//获取远端ip
//        if ("0:0:0:0:0:0:0:1".equals(ip)){
//            return "127.0.0.1";
//        }
//        return ip;
        return "0:0:0:0:0:0:0:1".equals(ip)?"127.0.0.1":ip;

    }
}
