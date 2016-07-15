package com.kingit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Administrator on 2016/7/12.
 */
@Controller
public class ErrorController {
    @RequestMapping(value = "/404",method = RequestMethod.GET)
    public String error404(){
        return "error/404";
    }

    @RequestMapping(value = "/403",method = RequestMethod.GET)
    public String error403(){
        return "error/403";
    }


}
