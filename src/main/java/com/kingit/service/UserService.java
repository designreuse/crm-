package com.kingit.service;

import com.google.common.collect.Maps;
import com.kingit.mapper.RoleMapper;
import com.kingit.mapper.UserLogMapper;
import com.kingit.mapper.UserMapper;
import com.kingit.pojo.User;
import com.kingit.pojo.UserLog;
import com.kingit.utils.Md5Util;
import com.kingit.utils.ShiroUtil;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/8.
 */
@Named
public class UserService {
    @Inject
    private UserMapper userMapper;
    @Inject
    private UserLogMapper userLogMapper;
    @Inject
    private RoleMapper roleMapper;


    public User findByUserName(String username){
        User user = userMapper.findByUserName(username);
        return user;
    }

    public void updatePassword(String password) {
        User user = ShiroUtil.getCurrentUser();
        user.setPassword(Md5Util.Md5(password));
        userMapper.updateUser(user);
    }


    public Long findCurrentUserLogCount() {
        Map<String,Object> param = Maps.newHashMap();
        param.put("userId",ShiroUtil.getCurrentUserId());
        return userLogMapper.findUserLogCount(param);
    }

    public List<UserLog> findCurrentUserLog(String start,String length) {
        Map<String,Object> param = Maps.newHashMap();
        param.put("start",start);
        param.put("length",length);
        param.put("userId",ShiroUtil.getCurrentUserId());
        return userLogMapper.findUserLogByParam( param);
    }

    public void savaUserLog(String ip){
        UserLog userLog = new UserLog(DateTime.now().toString("yyyy-MM-dd HH:mm"),ip,ShiroUtil.getCurrentUserId());
        userLogMapper.saveUserLog(userLog);
    };

    public Long getTotalCount() {
       return userMapper.findCount();
    }

    public Long getRecordsFiltered(Map<String, Object> param) {
        return userMapper.findCountByParam(param);
    }

    public List<User> findUserByParam(Map<String, Object> param) {
        return userMapper.findUserByParam(param);
    }

    public void savaUser(User user) {
        user.setPassword(Md5Util.Md5(user.getPassword()));
        userMapper.saveUser(user);
    }

    public void delUser(Integer id) {
        userMapper.delUser(id);
    }

    public User findByUserid(Integer id) {
        return userMapper.findByUserID(id);
    }

    public void editUser(User user) {
        userMapper.updateUser(user);
    }

    public void resetPwd(Integer id) {
        User user = userMapper.findByUserID(id);
        user.setPassword(Md5Util.Md5("000000"));
        userMapper.updateUser(user);
    }


    public List<User> findAll() {
        return userMapper.findAll();
    }
}
