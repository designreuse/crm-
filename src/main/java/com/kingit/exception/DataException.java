package com.kingit.exception;

/**
 * Created by Administrator on 2016/7/12.
 */
public class DataException extends RuntimeException {
    public DataException(String message) {
        super(message);
    }

    public DataException(String message, Exception e) {
        super(message, e);
    }

    public DataException() {
    }
}
