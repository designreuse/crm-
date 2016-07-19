package com.kingit.service;

import com.kingit.mapper.TodoMapper;
import com.kingit.pojo.Todo;
import com.kingit.utils.ShiroUtil;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/18.
 */
@Named
public class TodoService {
    @Inject
    private TodoMapper todoMapper;

    public void saveTodo(Todo todo,String hour,String minute) {

        String remindTime = todo.getStart()+"日"+hour+"时"+minute+"分";
        if(StringUtils.isNotEmpty(hour)&&StringUtils.isNotEmpty(minute)){
            todo.setRemindtime(remindTime);
        }
        todo.setUserid(ShiroUtil.getCurrentUserId());
        todo.setDone(false);
        todoMapper.save(todo);
    }

    public void del(Integer id) {
        todoMapper.del(id);
    }

    public void update(Todo todo) {
        todoMapper.update(todo);
    }

    public Todo findById(Integer id) {
        return todoMapper.findById(id);
    }


    public List<Todo> findByParam(Map<String, Object> param) {
        param.put("userid", ShiroUtil.getCurrentUserId());
        return todoMapper.findByParam(param);
    }

    public List<Todo> findTimeOutList() {
        return todoMapper.findTimeOutList(ShiroUtil.getCurrentUserId(), DateTime.now().toString("yyyy-MM-dd"));
    }

    public void saveCustomTodo(Todo todo, String hour, String minute) {
        String remindTime = todo.getStart()+"日"+hour+"时"+minute+"分";
        if(StringUtils.isNotEmpty(hour)&&StringUtils.isNotEmpty(minute)){
            todo.setRemindtime(remindTime);
        }
        todo.setUserid(ShiroUtil.getCurrentUserId());
        todo.setDone(false);
        todoMapper.save(todo);
    }

    public List<Todo> findTodoListByCuid(Integer cuid) {
        return todoMapper.findTodoListByCuid(ShiroUtil.getCurrentUserId(),cuid);

    }
}
