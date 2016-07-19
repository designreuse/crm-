package com.kingit.mapper;

import com.kingit.pojo.Sale;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/16.
 */
public interface SaleMapper {
    void save(Sale sale);
    void del(Integer id);
    void update(Sale sale);

    Sale findById(Integer id);
    List<Sale> findByParam(Map<String,Object> param);
    List<Sale> findAll();

    Long countByParam(Map<String, Object> param);

    Long totalCount();

    void delSale(Integer id);
}
