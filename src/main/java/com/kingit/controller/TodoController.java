package com.kingit.controller;

import com.google.common.collect.Maps;
import com.kingit.dto.JSONResult;
import com.kingit.exception.ForbiddenException;
import com.kingit.exception.NotFoundException;
import com.kingit.pojo.Todo;
import com.kingit.service.TodoService;
import com.kingit.utils.ShiroUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/18.
 */
@Controller
@RequestMapping("/todo")
public class TodoController {
    @Inject
    private TodoService todoService;
    @RequestMapping(value = "/list",method = RequestMethod.GET)

    public String todoList(Model model){
        List<Todo> timeOutList = todoService.findTimeOutList();
        model.addAttribute("timeoutList",timeOutList);
        return "todo/list";
    }

    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public List<Todo> todoListLoad(String start,String end){
        Map<String,Object> param = Maps.newHashMap();
        param.put("start",start);
        param.put("end",end);
        List<Todo> todoList = todoService.findByParam(param);
        return todoList;
    }

    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public JSONResult newTodo(Todo todo,String hour,String minute){
        todoService.saveTodo(todo,hour,minute);
        return new JSONResult(JSONResult.STATE_SUCCESS,todo);
    }

    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public String delTodo(@PathVariable("id") Integer id){
        Todo todo = todoService.findById(id);
        if (todo==null){
            throw new NotFoundException();
        }
        if (!ShiroUtil.getCurrentUserId().equals(todo.getUserid())){
            throw new ForbiddenException();
        };
        todoService.del(id);
        return "success";
    }

    @RequestMapping(value = "/editdone/{id:\\d+}",method = RequestMethod.POST)
    @ResponseBody
    public String editTodo(@PathVariable("id") Integer id){
        Todo todo = todoService.findById(id);
        if (todo==null){
            throw new NotFoundException();
        }
        if (!ShiroUtil.getCurrentUserId().equals(todo.getUserid())){
            throw new ForbiddenException();
        }
        todo.setDone(true);
        todoService.update(todo);
        return "success";
    }

    @RequestMapping(value = "/timeout",method = RequestMethod.GET)
    @ResponseBody
    public JSONResult timeoutLoad(){
        List<Todo> timeOutList = todoService.findTimeOutList();
        return new JSONResult(timeOutList);
    }


}
