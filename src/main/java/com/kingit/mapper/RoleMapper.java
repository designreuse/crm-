package com.kingit.mapper;

import com.kingit.pojo.Role;

import java.util.List;

/**
 * Created by Administrator on 2016/7/8.
 */
public interface RoleMapper {
    Role findById(Integer id);
    List<Role> findAll();
}
