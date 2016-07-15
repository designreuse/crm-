package com.kingit.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2016/7/13.
 */
public class Document implements Serializable {
    public static final String TYPE_DOC="doc";
    public static final String TYPE_DIR="dir";

    private Integer id;
    private String name;
    private String size;
    private Timestamp creattime;
    private String creatuser;
    private String type;
    private String filename;
    private String md5;
    private String contenttype;
    private Integer fid;

    public Document() {
    }

    public Document(String name, String size, Integer fid, String creatuser, String type, String filename, String md5, String contenttype) {
        this.name = name;
        this.size = size;
        this.fid = fid;
        this.creatuser = creatuser;
        this.type = type;
        this.filename = filename;
        this.md5 = md5;
        this.contenttype = contenttype;
    }

    public Document(String name, String size, String creatuser, String type, String filename, String contenttype, Integer fid) {
        this.name = name;
        this.size = size;
        this.creatuser = creatuser;
        this.type = type;
        this.filename = filename;
        this.contenttype = contenttype;
        this.fid = fid;
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

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Timestamp getCreattime() {
        return creattime;
    }

    public void setCreattime(Timestamp creattime) {
        this.creattime = creattime;
    }

    public String getCreatuser() {
        return creatuser;
    }

    public void setCreatuser(String creatuser) {
        this.creatuser = creatuser;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5;
    }

    public String getContenttype() {
        return contenttype;
    }

    public void setContenttype(String contenttype) {
        this.contenttype = contenttype;
    }

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }

    @Override
    public String toString() {
        return "Document{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", size='" + size + '\'' +
                ", creattime='" + creattime + '\'' +
                ", creatuser='" + creatuser + '\'' +
                ", type='" + type + '\'' +
                ", filename='" + filename + '\'' +
                ", md5='" + md5 + '\'' +
                ", contenttype='" + contenttype + '\'' +
                ", fid='" + fid + '\'' +
                '}';
    }
}
