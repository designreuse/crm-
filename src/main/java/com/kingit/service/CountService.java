package com.kingit.service;

import com.kingit.mapper.SaleMapper;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/19.
 */
@Named
public class CountService {
    @Inject
    private SaleMapper saleMapper;
    public List<Map<String,Object>> getCountProgress(String start,String end){
        DateTime now = DateTime.now();
        if (StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if (StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return saleMapper.getCountProgress(start,end);
    }



    public List<Map<String,Object>> loadSales(String start, String end) {
        DateTime now = DateTime.now();
        if (StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if (StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return saleMapper.loadSales(start,end);
    }
}
