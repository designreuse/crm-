package com.kingit.mapper;

import com.kingit.pojo.Todo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/18.
 */
public interface TodoMapper {
    void del(Integer id);
    void save(Todo todo);
    void update(Todo todo);

    Todo findById(Integer id);
    List<Todo> findByParam(Map<String,Object> param);

    List<Todo> findTimeOutList(@Param("userid") Integer currentUserId,@Param("nowtime") String nowtime);

    List<Todo> findTodoListByCuid(@Param("userid") Integer currentUserId,@Param("cuid") Integer cuid);
}
