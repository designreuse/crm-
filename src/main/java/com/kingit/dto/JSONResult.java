package com.kingit.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * 结果集为null的不再写入到json中
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class JSONResult {
    public static final String STATE_SUCCESS = "success";
    public static final String STATE_ERROR = "error";

    private String message;
    private String state;
    private Object data;

    public JSONResult(String message) {
        this(STATE_ERROR,message);
    }

    public JSONResult(Object data) {
        this(STATE_SUCCESS,data);
    }

    public JSONResult(String state, Object data) {
        this.state = state;
        this.data = data;
    }

    public JSONResult(String state, String message) {
        this.state = state;
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
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
