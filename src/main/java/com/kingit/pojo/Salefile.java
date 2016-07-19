package com.kingit.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2016/7/16.
 */
public class Salefile implements Serializable {
    private Integer id;
    private String filename;
    private String size;
    private String contenttype;
    private Integer saleid;
    private String name;
    private Timestamp creattime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getContenttype() {
        return contenttype;
    }

    public void setContenttype(String contenttype) {
        this.contenttype = contenttype;
    }

    public Integer getSaleid() {
        return saleid;
    }

    public void setSaleid(Integer saleid) {
        this.saleid = saleid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getCreattime() {
        return creattime;
    }

    public void setCreattime(Timestamp creattime) {
        this.creattime = creattime;
    }

    @Override
    public String toString() {
        return "Salefile{" +
                "id=" + id +
                ", filename='" + filename + '\'' +
                ", size='" + size + '\'' +
                ", contenttype='" + contenttype + '\'' +
                ", saleid=" + saleid +
                ", name='" + name + '\'' +
                ", creattime=" + creattime +
                '}';
    }
}
