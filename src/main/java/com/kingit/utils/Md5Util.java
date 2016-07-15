package com.kingit.utils;


import org.apache.commons.codec.digest.DigestUtils;

/**
 * Created by Administrator on 2016/7/10.
 */
public class Md5Util {
    public static String Md5(String data){
        return DigestUtils.md5Hex(data);
    }
}
