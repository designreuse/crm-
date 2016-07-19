package com.kingit.mapper;

import com.kingit.pojo.SaleLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2016/7/16.
 */
public interface SaleLogMapper {
    void del(Integer id);
    void save(SaleLog saleLog);
    SaleLog findById(Integer id);
    List<SaleLog> findALl();

    List<SaleLog> findBySaleId(@Param("id") Integer id);

    void delBySaleId(Integer id);
}
