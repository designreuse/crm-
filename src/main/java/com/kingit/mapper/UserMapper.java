package com.kingit.mapper;

import com.kingit.pojo.User;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/8.
 */
public interface UserMapper {
    User findByUserName(String username);

    User findByUserID(Integer id);

    List<User> findUserByParam(Map<String,Object> param);

    void updateUser(User user);

    Long findCount();

    Long findCountByParam(Map<String, Object> param);

    void saveUser(User user);

    void delUser(Integer id);

    List<User> findAll();

    List<User> findUserList();
}
