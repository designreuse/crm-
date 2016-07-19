package com.kingit.controller;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.kingit.service.CountService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/19.
 */
@Controller
@RequestMapping("/count")
public class CountController {
    @Inject
    private CountService countService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String countList(Model model){
        return "count/list";
    }

    @RequestMapping(value = "/progress/data",method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String,Object>> loadPieData(@RequestParam(required = false,defaultValue = "") String start,@RequestParam(required = false,defaultValue = "") String end){
        return countService.getCountProgress(start,end);
    }

    @RequestMapping(value = "/sales",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> loadSalesData(@RequestParam(required = false,defaultValue = "") String start,@RequestParam(required = false,defaultValue = "") String end){
        List<Map<String,Object>> data = countService.loadSales(start,end);

        List<String> names = Lists.newArrayList();
        List<String> values = Lists.newArrayList();
        Map<String,Object> result = Maps.newHashMap();

        for (Map<String,Object> map:data){
            for (Map.Entry<String,Object> entry :map.entrySet()){
                if (entry.getKey().equals("name")){
                    names.add(entry.getValue().toString());
                }else if (entry.getKey().equals("value")){
                    values.add(entry.getValue().toString());
                }
            }
        }

        result.put("names",names);
        result.put("values",values);
        return result;
    }

}
