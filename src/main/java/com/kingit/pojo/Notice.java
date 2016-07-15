package com.kingit.pojo;

import java.io.Serializable;

/**
 * Created by Administrator on 2016/7/11.
 */
public class Notice implements Serializable {
    private Integer id;
    private String title;
    private String content;
    private String creattime;
    private String realname;
    private Integer userid;

    public Notice() {
    }

    public Notice(String title, String content, String realname, Integer userid) {
        this.title = title;
        this.content = content;
        this.realname = realname;
        this.userid = userid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreattime() {
        return creattime;
    }

    public void setCreattime(String creattime) {
        this.creattime = creattime;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    @Override
    public String toString() {
        return "Notice{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", creattime='" + creattime + '\'' +
                ", realname='" + realname + '\'' +
                ", userid=" + userid +
                '}';
    }
}
