package com.kingit.service;

import com.google.common.collect.Maps;
import com.kingit.mapper.CustomerMapper;
import com.kingit.pojo.Customer;
import com.kingit.utils.ShiroUtil;
import com.kingit.utils.Strings;
import org.apache.commons.lang3.StringUtils;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/14.
 */
@Named
public class CustomerService {
    @Inject
    private CustomerMapper customerMapper;

    public void save(Customer customer) {
        if (customer.getCompanyid() != null) {
            Customer company = customerMapper.findById(customer.getCompanyid());
            customer.setCompanyname(company.getName());
        }
        customer.setUserid(ShiroUtil.getCurrentUserId());
        customer.setPinyin(Strings.hanziToPinyin(customer.getName()));
        customerMapper.save(customer);
    }

    public String getCompanyNameByCompanyId(Integer companyId) {
        Customer customer = customerMapper.findById(companyId);
        return customer.getCompanyname();
    }

    @Transactional
    public void update(Customer customer) {
        if (customer.getType().equals(Customer.TYPE_COMPANY)) {
            List<Customer> customerList = customerMapper.findByCompanyId(customer.getId());
            for (Customer cust : customerList) {
                cust.setCompanyid(customer.getId());
                cust.setCompanyname(customer.getName());
                customerMapper.update(cust);
            }
        } else {
            if (customer.getCompanyid() != null) {
                Customer company = customerMapper.findById(customer.getCompanyid());
                String companyName = company.getName();
                customer.setCompanyname(companyName);

            }
        }
        customer.setPinyin(Strings.hanziToPinyin(customer.getName()));
        customerMapper.update(customer);

    }

    public void delete(Integer id) {
        Customer customer = customerMapper.findById(id);
        if (Customer.TYPE_COMPANY.equals(customer.getType())){
            List<Customer> customerList = customerMapper.findByCompanyId(id);
            for (Customer cust:customerList){
                cust.setCompanyname(null);
                cust.setCompanyid(null);
                customerMapper.update(cust);

            }
        }
        customerMapper.del(id);
    }

    public Customer findById(Integer id) {
        Customer customer = customerMapper.findById(id);
            return customer;
    }

    public List<Customer> findByParam(Map<String, Object> param) {
        if (ShiroUtil.isManger()) {
            return customerMapper.findByParam(param);
        }
        param.put("userid", ShiroUtil.getCurrentUserId());
        return customerMapper.findByParam(param);
    }

    public long getFilterCount(Map<String, Object> param) {
        if (ShiroUtil.isManger()) {
            return customerMapper.findCountByParam(param);
        }
        param.put("userid", ShiroUtil.getCurrentUserId());
        return customerMapper.findCountByParam(param);
    }

    public long getTotalCount() {
        if (ShiroUtil.isManger()) {
            return customerMapper.count();
        }
        Integer userid = ShiroUtil.getCurrentUserId();
        return customerMapper.findCountByUserid(userid);
    }

    public List<Customer> findCompanyList() {
        return customerMapper.findCompanyList(ShiroUtil.getCurrentUserId());
    }

    public List<Customer> findCustomerByComapnyid(Integer companyid) {
        return customerMapper.findByCompanyId(companyid);
    }

    public void moveCustomer(Customer customer, Integer userid) {
        customer.setUserid(userid);
        customerMapper.update(customer);
    }

    public void openCustomer(Customer customer) {
        customer.setUserid(null);
        customerMapper.update(customer);
    }

    public String makeMecard(Integer id) {
        Customer customer = customerMapper.findById(id);
        StringBuilder mecard = new StringBuilder("MECARD:");
        if (StringUtils.isNotEmpty(customer.getName())){
            mecard.append("N:"+customer.getName()+";");
        }

        if (StringUtils.isNotEmpty(customer.getTel())){
            mecard.append("TEL:"+customer.getTel()+";");
        }

        if (StringUtils.isNotEmpty(customer.getEmail())){
            mecard.append("EMAIL:"+customer.getEmail()+";");
        }

        if (StringUtils.isNotEmpty(customer.getAddress())){
            mecard.append("ADR:"+customer.getAddress()+";");
        }

        if (StringUtils.isNotEmpty(customer.getEmail())){
            mecard.append("ORG:"+customer.getCompanyname()+";");
        }
        mecard.append(";");
        return mecard.toString();
    }

    public void privateCustomer(Customer customer) {
        customer.setUserid(ShiroUtil.getCurrentUserId());
        customerMapper.update(customer);
    }

    public Boolean isCompanyEmpty(Customer customer){
        Boolean falg = true;
        if (customer.getType().equals(Customer.TYPE_COMPANY)) {
            List<Customer> customerList = findCustomerByComapnyid(customer.getId());
            for (Customer cuso : customerList) {
                if (cuso.getUserid() != null && ShiroUtil.getCurrentUserId().equals(cuso.getUserid())){
                    falg = false;
                }
            }
        }
        return falg;
    }

    public List<Customer> findByOwerUserid() {
        Map<String,Object> param = Maps.newHashMap();
        param.put("userid", ShiroUtil.getCurrentUserId());
        return customerMapper.findByParam(param);
    }
}
