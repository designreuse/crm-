package com.kingit.mapper;

import com.kingit.pojo.Salefile;

import java.util.List;

/**
 * Created by Administrator on 2016/7/16.
 */
public interface SalefileMapper {
    void save(Salefile salefile);
    void del(Integer id);
    Salefile findById(Integer id);
    List<Salefile> findAll();

    void delBySaleId(Integer id);

    List<Salefile> findBySaleId(Integer id);
}
