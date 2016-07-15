package com.kingit.mapper;

import com.kingit.pojo.UserLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/8.
 */
public interface UserLogMapper {
    Long findUserLogCount(Map<String,Object> param);
    void saveUserLog(UserLog userlog);

    List<UserLog> findUserLogByParam(Map<String, Object> param);
}
