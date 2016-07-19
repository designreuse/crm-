package com.kingit.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2016/7/16.
 */
public class SaleLog implements Serializable {
    public static String TYPE_LOG_AUTO = "auto";
    public static String TYPE_LOG_HAND = "hand";


    public static String TYPE_CONTRNT_FIRST = "创建新机会";




    private Integer id;
    private String content;
    private Timestamp creattime;
    private String type;
    private Integer saleid;

    public SaleLog() {
    }

    public SaleLog(String content, String type, Integer saleid) {
        this.content = content;
        this.type = type;
        this.saleid = saleid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreattime() {
        return creattime;
    }

    public void setCreattime(Timestamp creattime) {
        this.creattime = creattime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getSaleid() {
        return saleid;
    }

    public void setSaleid(Integer saleid) {
        this.saleid = saleid;
    }

    @Override
    public String toString() {
        return "SaleLog{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", creattime=" + creattime +
                ", type='" + type + '\'' +
                ", saleid=" + saleid +
                '}';
    }
}
