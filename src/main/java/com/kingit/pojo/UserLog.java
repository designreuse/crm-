package com.kingit.pojo;

import java.io.Serializable;

/**
 * Created by Administrator on 2016/7/8.
 */
public class UserLog implements Serializable {
   private Integer id ;
   private String logintime;
   private String loginip;
   private Integer userid;

    public UserLog() {
    }

    public UserLog(String logintime, String loginip, Integer userid) {
        this.logintime = logintime;
        this.loginip = loginip;
        this.userid = userid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogintime() {
        return logintime;
    }

    public void setLogintime(String logintime) {
        this.logintime = logintime;
    }

    public String getLoginip() {
        return loginip;
    }

    public void setLoginip(String loginip) {
        this.loginip = loginip;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    @Override
    public String toString() {
        return "UserLog{" +
                "id=" + id +
                ", logintime='" + logintime + '\'' +
                ", loginip='" + loginip + '\'' +
                ", userid=" + userid +
                '}';
    }
}
