package com.kingit.dto;

/**
 * Created by Administrator on 2016/7/9.
 * 为了完成信息的表示,信息包含信息内容和状态级别两个方面
 */
public class FlashMessage {
    public static final String STATE_SUCCESS = "success";
    public static final String STATE_ERROR = "error";

    private String state;
    private String message;

    public FlashMessage(String message) {
        this.message = message;
    }

    public FlashMessage(String state, String message) {
        this.state = state;
        this.message = message;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
