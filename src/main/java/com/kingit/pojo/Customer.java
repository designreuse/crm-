package com.kingit.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2016/7/14.
 */
public class Customer implements Serializable {
    public static final String TYPE_COMPANY="company";
    public static final String TYPE_PERSON="person";


    private Integer id;
    private String name;
    private String tel;
    private String weixin;
    private String address;
    private String email;
    private Timestamp creattime;
    private String pinyin;
    private String companyname;
    private Integer companyid;
    private String level;
    private String type;
    private Integer userid;

    public Customer() {
    }

    public Customer(String name, String tel, String email, String companyname) {
        this.name = name;
        this.tel = tel;
        this.email = email;
        this.companyname = companyname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getWeixin() {
        return weixin;
    }

    public void setWeixin(String weixin) {
        this.weixin = weixin;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getCreattime() {
        return creattime;
    }

    public void setCreattime(Timestamp creattime) {
        this.creattime = creattime;
    }

    public String getPinyin() {
        return pinyin;
    }

    public void setPinyin(String pinyin) {
        this.pinyin = pinyin;
    }

    public String getCompanyname() {
        return companyname;
    }

    public void setCompanyname(String companyname) {
        this.companyname = companyname;
    }

    public Integer getCompanyid() {
        return companyid;
    }

    public void setCompanyid(Integer companyid) {
        this.companyid = companyid;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", tel='" + tel + '\'' +
                ", weixin='" + weixin + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", creattime=" + creattime +
                ", pinyin='" + pinyin + '\'' +
                ", companyname='" + companyname + '\'' +
                ", companyid=" + companyid +
                ", level='" + level + '\'' +
                ", type='" + type + '\'' +
                ", userid=" + userid +
                '}';
    }

}
