package com.kingit.pojo;

import java.io.Serializable;

/**
 * Created by Administrator on 2016/7/8.
 */
public class User implements Serializable {

    private Integer id;
    private String username;
    private String password;
    private String realname;
    private String weixin;
    private String createtime;
    private Integer roleid;

    private Boolean enable;
    private Role role;

    public User() {
    }

    public User(String password, String username, String realname,int roleid) {
        this.password = password;
        this.username = username;
        this.realname = realname;
        this.roleid = roleid;
    }


    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getWeixin() {
        return weixin;
    }

    public void setWeixin(String weixin) {
        this.weixin = weixin;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", realname='" + realname + '\'' +
                ", weixin='" + weixin + '\'' +
                ", createtime='" + createtime + '\'' +
                ", roleid=" + roleid +
                ", enable=" + enable +
                ", role=" + role +
                '}';
    }
}
