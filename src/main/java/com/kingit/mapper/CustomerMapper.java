package com.kingit.mapper;

import com.kingit.pojo.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/14.
 */
public interface CustomerMapper {
    void save(Customer customer);
    void del(Integer id);
    void update(Customer customer);

    Customer findById(Integer id);
    List<Customer> findByParam(Map<String,Object> param);

    long findCountByParam(Map<String,Object> param);

    long findCountByUserid(@Param("userid") Integer userid);
    long count();

    List<Customer> findCompanyList(@Param("userid") Integer userid);

    List<Customer> findByCompanyId(@Param("companyid") Integer companyid);
}
